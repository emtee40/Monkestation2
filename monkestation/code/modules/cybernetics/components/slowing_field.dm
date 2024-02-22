/datum/component/slowing_field
	///how slow bullets move as a multiplier (rounded to the nearest 1)
	var/bullet_speed_multiplier = 1
	///our movespeed_multipliers
	var/atom_speed_multiplier = 1
	///list of slowed things
	var/list/affected = list()

/datum/component/slowing_field/Initialize(bullet_speed_multiplier = 1, atom_speed_multiplier = 1, area_range = 1)
	. = ..()
	src.bullet_speed_multiplier = bullet_speed_multiplier
	src.atom_speed_multiplier = atom_speed_multiplier

	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered_turf),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited_turf),
		COMSIG_ATOM_INITIALIZED_ON = PROC_REF(on_entered_turf),
	)

	AddComponent(/datum/component/connect_range, parent, connections, area_range, TRUE)

/datum/component/slowing_field/Destroy(force, silent)
	. = ..()
	for(var/atom/a as anything in affected)
		on_exited_turf(src, a)

/datum/component/slowing_field/proc/on_entered_turf(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(istype(arrived, /obj/effect/temp_visual/decoy/fading))
		return
	if(arrived == parent)
		return

	arrived.add_atom_colour(GLOB.freon_color_matrix, TEMPORARY_COLOUR_PRIORITY)
	affected |= arrived

	if(isprojectile(arrived))
		var/obj/projectile/arrived_proj = arrived
		arrived_proj.pixel_speed_multiplier = bullet_speed_multiplier
	else if(isliving(arrived))
		var/mob/living/arrived_movable = arrived
		arrived_movable.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/status_effect/slowing_field, TRUE, atom_speed_multiplier)

/datum/component/slowing_field/proc/on_exited_turf(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER
	if(istype(gone, /obj/effect/temp_visual/decoy/fading))
		return
	if(gone == parent)
		return
	gone.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	affected -= gone

	if(isprojectile(gone))
		var/obj/projectile/arrived_proj = gone
		arrived_proj.pixel_speed_multiplier = 1
	else if(isliving(gone))
		var/mob/living/arrived_movable = gone
		arrived_movable.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/slowing_field)


/datum/movespeed_modifier/status_effect/slowing_field
	multiplicative_slowdown = 1
