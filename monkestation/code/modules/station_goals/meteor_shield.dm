GLOBAL_LIST_EMPTY(meteor_shield_sats)

/obj/machinery/satellite/meteor_shield
	/// Whether the meteor sat checks for line of sight to determine if it can intercept a meteor.
	var/check_sight = TRUE
	/// The proximity monitor used to detect meteors entering the shield's range.
	var/datum/proximity_monitor/meteor_monitor

/obj/machinery/satellite/meteor_shield/Initialize(mapload)
	. = ..()
	GLOB.meteor_shield_sats += src
	setup_proximity()

/obj/machinery/satellite/meteor_shield/Destroy()
	GLOB.meteor_shield_sats -= src
	if(meteor_monitor)
		QDEL_NULL(meteor_monitor)
	return ..()

/obj/machinery/satellite/meteor_shield/vv_edit_var(vname, vval)
	. = ..()
	if(.)
		switch(vname)
			if(NAMEOF(src, kill_range))
				meteor_monitor?.set_range(kill_range)
			if(NAMEOF(src, active))
				setup_proximity()

/obj/machinery/satellite/meteor_shield/HasProximity(obj/effect/meteor/meteor)
	if(!active || !istype(meteor) || QDELING(meteor) || (obj_flags & EMAGGED))
		return
	var/turf/our_turf = get_turf(src)
	var/turf/meteor_turf = get_turf(meteor)
	if(!check_los(our_turf, meteor_turf))
		return
	our_turf.Beam(meteor_turf, icon_state = "sat_beam", time = 5)
	if(meteor.shield_defense(src))
		new /obj/effect/temp_visual/explosion(meteor_turf)
		INVOKE_ASYNC(src, PROC_REF(play_zap_sound), meteor_turf)
		qdel(meteor)

/obj/machinery/satellite/meteor_shield/proc/check_los(turf/source, turf/target) as num
	// if something goes fucky wucky, let's just assume line-of-sight by default
	if(!check_sight)
		return TRUE
	for(var/turf/segment as anything in get_line(source, target))
		if(QDELETED(segment))
			continue
		if(isclosedturf(segment) && !istransparentturf(segment))
			return FALSE
	return TRUE

/obj/machinery/satellite/meteor_shield/proc/play_zap_sound(turf/epicenter)
	if(QDELETED(epicenter))
		return
	var/static/near_distance
	if(isnull(near_distance))
		var/list/world_view = getviewsize(world.view)
		near_distance = max(world_view[1], world_view[2])
	SSexplosions.shake_the_room(
		epicenter,
		near_distance,
		far_distance = near_distance * 3,
		quake_factor = 0,
		echo_factor = 0,
		creaking = FALSE,
		near_sound = sound('sound/weapons/lasercannonfire.ogg'),
		far_sound = sound('sound/weapons/marauder.ogg')
	)

/obj/machinery/satellite/meteor_shield/toggle(user)
	. = ..()
	setup_proximity()

/obj/machinery/satellite/meteor_shield/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	setup_proximity()

/obj/machinery/satellite/meteor_shield/proc/setup_proximity()
	if((obj_flags & EMAGGED) || !active)
		if(!QDELETED(meteor_monitor))
			QDEL_NULL(meteor_monitor)
	else
		if(QDELETED(meteor_monitor))
			meteor_monitor = new(src, kill_range)

/obj/machinery/satellite/meteor_shield/piercing
	check_sight = FALSE

/proc/get_meteor_sat_coverage() as num
	var/list/covered_tiles = list()
	for(var/obj/machinery/satellite/meteor_shield/sat as anything in GLOB.meteor_shield_sats)
		if(QDELETED(sat) || !sat.active || !is_station_level(sat.z) || (sat.obj_flags & EMAGGED))
			continue
		if(sat.check_sight)
			covered_tiles |= view(sat.kill_range, sat)
		else
			covered_tiles |= range(sat.kill_range, sat)
	return length(covered_tiles)

