/obj/effect/royale_barrier
	name = "Death wall"
	icon = 'icons/effects/fields.dmi'
	icon_state = "projectile_dampen_generic"
	///Ref to our controller
	var/datum/royale_barrier_controller/controller
	///How far from the center are we
	var/current_radius

/obj/effect/royale_barrier/Initialize(mapload, controller)
	. = ..()
	src.controller = controller
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, connections)
	current_radius = world.maxx //this assumes the world is square

/obj/effect/royale_barrier/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	var/turf/new_turf = get_turf(src)
	for(var/mob/living/living_mob in new_turf)
		to_chat(living_mob, span_userdanger("You left the zone!"))
		living_mob.dust()

	if(controller && isturf(old_loc))
		controller.add_invalid_turf(old_loc)

/obj/effect/royale_barrier/proc/on_entered(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER

	if(isliving(arrived))
		var/mob/living/living_arrived = arrived
		to_chat(living_arrived, span_userdanger("You left the zone!"))
		living_arrived.dust()

///Move us towards the center of the zone
/obj/effect/royale_barrier/proc/decrease_size()
	if(!controller)
		return

	var/minx = clamp(controller.center_cords["x"] - current_radius, 12, world.maxx)
	var/maxx = clamp(controller.center_cords["x"] + current_radius, 12, world.maxx)
	var/miny = clamp(controller.center_cords["y"] - current_radius, 12, world.maxy)
	var/maxy = clamp(controller.center_cords["y"] + current_radius, 12, world.maxy)
	if(y == maxy || y == miny)
		//We have nowhere to move to so are deleted
		if(x == minx || x == minx + 1 || x == maxx || x == maxx - 1)
			qdel(src)
			return
	//Where do we go to?
	if(x == minx)
		forceMove(get_step(get_turf(src), EAST))
	else if(x == maxx)
		forceMove(get_step(get_turf(src), WEST))
	else if(y == miny)
		forceMove(get_step(get_turf(src), NORTH))
	else if(y == maxy)
		forceMove(get_step(get_turf(src), SOUTH))
	current_radius--
