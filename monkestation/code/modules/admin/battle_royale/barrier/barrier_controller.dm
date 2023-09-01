/datum/royale_barrier_controller
	///List of turfs outside the barrier area
	var/list/invalid_turfs = list()
	///List of our barriers
	var/list/barriers = list()
	///List of cords to home in on, first value is x, second is y
	var/turf/center_cords = list()
	///How close to shrinking are we, one tile for every 10 value
	var/shrink_value = 0

/datum/royale_barrier_controller/Destroy(force, ...)
	QDEL_LIST(barriers)
	return ..()

/datum/royale_barrier_controller/proc/setup()
	QDEL_LIST(barriers)
	var/turf/center_turf = SSmapping.get_station_center()
	center_cords["x"] = center_turf.x
	center_cords["y"] = center_turf.y
	barriers = list()
	for(var/z_level in SSmapping.levels_by_any_trait(list(ZTRAIT_STATION, ZTRAIT_ICE_RUINS, ZTRAIT_ICE_RUINS_UNDERGROUND)))
		var/list/edge_turfs = list()
		edge_turfs += block(locate(1, 1, z_level), locate(world.maxx, 1, z_level))
		edge_turfs += block(locate(12, world.maxy, z_level), locate(world.maxx, world.maxy, z_level))
		edge_turfs |= block(locate(1, 1, z_level), locate(1, world.maxy, z_level))
		edge_turfs |= block(locate(world.maxx, 1, z_level), locate(world.maxx, world.maxy, z_level))
		for(var/turf/edge_turf in edge_turfs)
			var/obj/effect/royale_barrier/barrier = new(edge_turf, src)
			barriers += barrier
			CHECK_TICK

/datum/royale_barrier_controller/proc/add_invalid_turf(turf/invalid_turf)
	invalid_turfs += invalid_turf
	RegisterSignal(invalid_turf, COMSIG_ATOM_ENTERED, PROC_REF(on_invalid_entered))

/datum/royale_barrier_controller/proc/on_invalid_entered(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER

	var/turf/source_turf = source
	if(QDELETED(arrived) || locate(/obj/effect/royale_barrier) in source_turf)
		return

	if(isliving(arrived))
		var/mob/living/living_arrived = arrived
		to_chat(living_arrived, span_userdanger("Your not getting out that easy."))
		var/list/turf_list = GLOB.station_turfs.Copy()
		shuffle_inplace(turf_list)
		for(var/turf/possible_turf in turf_list)
			if(isclosedturf(possible_turf) || (possible_turf in invalid_turfs))
				continue
			do_teleport(living_arrived, pick(possible_turf), forced = TRUE)
			break
		living_arrived.Sleeping(5 SECONDS)

/datum/royale_barrier_controller/proc/check_barrier_movement(amount)
	if(!amount)
		return

	amount = 10 * amount //this allows us to avoid floating points
	amount = truncate(amount) //make extra sure we dont have any floating points
	shrink_value += amount

	var/shrink_amount = FLOOR(shrink_value, 10)
	shrink_value = max(shrink_value - shrink_amount, 0)
	if(shrink_amount)
		for(var/tiles_to_advance in 1 to (shrink_amount / 10))
			advance_barriers()

/datum/royale_barrier_controller/proc/advance_barriers()
	for(var/obj/effect/royale_barrier/barrier in barriers)
		barrier.decrease_size()

/datum/royale_barrier_controller/proc/clear_barriers()
	QDEL_LIST(barriers)
	barriers = list()
	invalid_turfs = list()
