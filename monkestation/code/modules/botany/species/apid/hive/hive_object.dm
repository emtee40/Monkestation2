GLOBAL_LIST_INIT(hive_exits, list())

/obj/structure/beebox/hive
	name = "generic hive"
	desc = "A generic hive without an owner."

	icon = 'monkestation/code/modules/botany/icons/apid_sprites.dmi'
	icon_state = "hive"

	var/obj/structure/hive_exit/linked_exit
	var/stored_honey = 0

/obj/structure/beebox/hive/Initialize(mapload)
	. = ..()

	for(var/i = 1 to 3)
		var/obj/item/honey_frame/HF = new(src)
		honey_frames += HF

	for(var/obj/structure/hive_exit/exit as anything in GLOB.hive_exits)
		if(exit.linked_hive)
			continue
		exit.linked_hive = src
		linked_exit = exit
		break

	if(!linked_exit)
		var/datum/map_template/hive/hive = new()
		var/datum/turf_reservation/roomReservation = SSmapping.request_turf_block_reservation(hive.width, hive.height, 1)
		var/turf/bottom_left = roomReservation.bottom_left_turfs[1]
		var/datum/map_template/load_from = hive

		load_from.load(bottom_left)
		for(var/obj/structure/hive_exit/exit as anything in GLOB.hive_exits)
			if(exit.linked_hive)
				continue
			exit.linked_hive = src
			linked_exit = exit
			break

/obj/structure/beebox/hive/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!linked_exit)
		return

	var/enter_time = 4 SECONDS
	if(is_species(user, /datum/species/apid))
		enter_time = 2 SECONDS

	if(!do_after(user, enter_time, src))
		return

	do_teleport(user, get_step(linked_exit, EAST), no_effects = TRUE, forced = TRUE)



/obj/structure/hive_exit
	name = "generic hive exit"
	desc = "A generic hive exit without an owner"

	icon = 'monkestation/code/modules/botany/icons/apid_sprites.dmi'
	icon_state = "hive_exit"

	var/obj/structure/beebox/hive/linked_hive

	var/list/atoms_inside = list()

/obj/structure/hive_exit/Initialize(mapload)
	. = ..()
	GLOB.hive_exits += src
	RegisterSignal(get_area(src), COMSIG_AREA_EXITED, PROC_REF(exit_area))
	RegisterSignal(get_area(src), COMSIG_AREA_ENTERED, PROC_REF(enter_area))

/obj/structure/hive_exit/Destroy()
	. = ..()
	for(var/atom/movable/listed in atoms_inside)
		listed.forceMove(get_turf(linked_hive))
	GLOB.hive_exits -= src
	linked_hive?.linked_exit = null
	linked_hive = null

/obj/structure/hive_exit/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!linked_hive)
		return

	var/enter_time = 4 SECONDS
	if(is_species(user, /datum/species/apid))
		enter_time = 2 SECONDS

	if(!do_after(user, enter_time, src))
		return

	do_teleport(user, get_turf(linked_hive), no_effects = TRUE, forced = TRUE)

/obj/structure/hive_exit/proc/exit_area(datum/source, atom/removed)
	if(isturf(removed))
		return
	atoms_inside -= removed

/obj/structure/hive_exit/proc/enter_area(datum/source, atom/added)
	if(isturf(added))
		return
	atoms_inside += added


/datum/map_template/hive
	name = "Hive Template"
	width = 15
	height = 15
	mappath = "_maps/~monkestation/templates/hives.dmm"
