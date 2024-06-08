/datum/hover_data/ghost_critter

/datum/hover_data/ghost_critter/setup_data(atom/source, mob/enterer)
	if(!enterer.client)
		return
	var/time_left = enterer.client.ghost_critter_cooldown
	if(world.time > time_left)
		return

	time_left -= world.time
	var/obj/effect/overlay/hover/data = new(null)
	data.maptext = "You have [DisplayTimeText(time_left)] left until you can spawn as a ghost critter again."
	data.maptext_width = 256
	var/image/new_image = new(source)
	new_image.appearance = data.appearance
	SET_PLANE_EXPLICIT(new_image, new_image.plane, source)
	add_client_image(new_image, enterer.client)

/obj/structure/ghost_critter_spawn
	name = "Ghost Critter Spawnpoint"

	icon = 'monkestation/code/modules/ghost_critters/icons/spawnpoint.dmi'
	icon_state = "ghost_spawn"

	density = FALSE
	resistance_flags = INDESTRUCTIBLE

	plane = GHOST_PLANE
	appearance_flags = KEEP_TOGETHER
	invisibility = INVISIBILITY_OBSERVER

/obj/structure/ghost_critter_spawn/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/hovering_information, /datum/hover_data/ghost_critter)

/obj/structure/ghost_critter_spawn/Click(location, control, params)
	. = ..()
	if(!isobserver(usr))
		return

	var/mob/dead/observer/ghost = usr
	if(!ghost.client)
		return

	if(ghost.client.ghost_critter_cooldown > world.time)
		return

	ghost.client.try_critter_spawn(src)
	qdel(ghost)
