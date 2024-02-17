/obj/item/pinpointer/crew/contractor
	name = "contractor pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. Ignores suit sensors, but is much less accurate."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	minimum_range = 15
	has_owner = TRUE
	ignore_suit_sensor_level = TRUE

/obj/item/extraction_pack/contractor
	name = "black fulton extraction pack"
	desc = "A modified fulton pack that can be used indoors thanks to Bluespace technology. Favored by Syndicate Contractors."
	icon = 'monkestation/icons/obj/items/fulton.dmi'
	can_use_indoors = TRUE

/obj/item/pinpointer
	var/special_examine = FALSE

/obj/item/pinpointer/area_pinpointer
	name = "hacked pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. This one seems to have wires sticking out of it, and can point onto areas instead of humans."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	special_examine = TRUE
	/// We save our position every time we scan_for_target()
	/// Its used to check if we moved so we may ignore calculations when being still, along with calculations between us and the target turfs.
	var/turf/pinpointer_turf
	/// The area we are currently tracking
	var/area/tracked_area
	/// The list of all open turfs within our tracked area, stored so we dont have to re-generate it every time we are tracking the area
	var/list/turf/open/area_open_turfs = list()
	/// The list of all turfs with doors on them, used for the door mode
	var/list/turf/open/door_turfs = list()
	/// a switch, if TRUE it will display all door turfs instead of all open turfs
	var/door_mode = FALSE

/obj/item/pinpointer/area_pinpointer/Destroy()
	tracked_area = null
	pinpointer_turf = null
	area_open_turfs = null
	door_turfs = null
	return ..()

/obj/item/pinpointer/area_pinpointer/AltClick(mob/living/carbon/user)
	if(!istype(user) || !user.can_perform_action(src))
		return
	user.visible_message(span_notice("[user] quietly flips a switch in [user.p_their()] pinpointer."), span_notice("You quietly flip the switch your pinpointer."))
	door_mode = !door_mode

// we need to get our own examine text, since it would be "tracking the floor" otherwise
/obj/item/pinpointer/area_pinpointer/examine(mob/user)
	. = ..()
	if(target)
		. += span_notice("It is currently tracking [tracked_area].")
	if(door_mode)
		. += span_notice("It is currently tracking the nearest door in the given area, alt+click to switch modes")
	else
		. += span_notice("It is currently tracking the nearest floor in the given area, alt+click to switch modes")

/obj/item/pinpointer/area_pinpointer/get_direction_icon(here, there)
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)

	var/turf/pinpointer_turf = get_turf(src)
	for(var/turf/possible_turf as anything in area_turfs) // im a bit scared of the effects this may have on performance, but it seems fine
		if(get_dist_euclidian(pinpointer_turf, possible_turf) <= minimum_range)
			return "pinon[alert ? "alert" : ""]direct[icon_suffix]"

	return ..()

/obj/item/pinpointer/area_pinpointer/proc/regenerate_tracked_turfs()
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)
	for(var/turf/floor as anything in area_turfs) // Lets go over everything and store the turfs we care about
		if(floor.density) // catch all the walls, we dont want them
			continue
		area_open_turfs += floor
		if(locate(/obj/machinery/door/airlock) in floor)
			door_turfs += floor

/obj/item/pinpointer/area_pinpointer/scan_for_target()
	var/current_turf = get_turf(src)

	if(pinpointer_turf == current_turf) // if our position has not changed, we dont need to update our target.
		return

	pinpointer_turf = current_turf

	/// The turf that has the lowest possible range towards us and the area
	var/turf/closest_turf
	/// Whats the range between us and the closest turf?
	var/closest_turf_range = 255
	if(!door_mode)
		for(var/turf/open/floor as anything in area_open_turfs) // Lets go over every turf and check their distances for the closest tile
			if(get_dist_euclidian(pinpointer_turf, floor) < closest_turf_range)
				closest_turf_range = get_dist_euclidian(pinpointer_turf, floor)
				closest_turf = floor
	else // if door_mode is TRUE, we instead want to track the nearest airlock instead of all turfs
		for(var/turf/open/floor as anything in door_turfs) // Lets go over every door and check their distances for the closest tile
			if(get_dist_euclidian(pinpointer_turf, floor) < closest_turf_range)
				closest_turf_range = get_dist_euclidian(pinpointer_turf, floor)
				closest_turf = floor

	target = closest_turf

/obj/item/pinpointer/area_pinpointer/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		area_open_turfs = list() // empty the lists so we can fill it on the next activation with the new area's turfs
		door_turfs = list() // if we wouldn't empty them, the pinpointer would get both confusing and very expensive to run
		return

	if(!user)
		CRASH("[src] has had attack_self attempted by a non-existing user.")

	// This list should ONLY include areas that are on our z-level and are actually recognizable, else we confuse the contractor
	var/list/possible_areas = list()
	for(var/area/area in GLOB.areas)
		var/our_z = user.z
		var/area_z = area.z
		if(!our_z || !area_z)
			// What the actual hell are you doing
			CRASH("[src] has detected an area without a valid z-level. What")

		if(our_z != area_z)
			continue

		possible_areas += area

	if(!length(possible_areas))
		CRASH("[src] has failed to detect a valid area, this should never happen!")

	var/target_area = tgui_input_list(user, "Area to track", "Pinpoint", sort_list(possible_areas))
	if(isnull(target_area))
		return
	if(QDELETED(src) || QDELETED(user) || !user.is_holding(src) || user.incapacitated())
		return

	tracked_area = target_area

	regenerate_tracked_turfs()

	target = get_first_open_turf_in_area(target_area)

	toggle_on()

	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))

/**
 * Debug area pinpointer focuses on visualization over performance, admin-spawn only
 * Red - This tile is ignored by tracking
 * Yellow - This tile is not tracked, but is marked
 * Green - This tile is tracked and potentially a target
 * Blue - This is the tile we are currently tracking
 */
/obj/item/pinpointer/area_pinpointer/debug
	name = "debug area pinpointer"
	desc = "A debug version of the area pinpointer, this one visualizes all of the turfs that are being tracked and ignored."
	var/list/obj/machinery/door/airlock/affected_airlock_list = list()

/obj/item/pinpointer/area_pinpointer/debug/scan_for_target()
	. = ..()
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)
	for(var/turf/floor as anything in area_turfs) // Lets go over everything and store the turfs we care about
		floor.maptext = initial(floor.maptext)
		if(floor.density)
			floor.color = rgb(255, 0, 0) // color the walls red, we dont track them
			floor.maptext = MAPTEXT("X")
			continue
		if(!door_mode)
			floor.color = rgb(0, 255, 0) // color the floors green, we track them
		else
			floor.color = rgb(255, 255, 0) // we are not necessarily tracking them, but still mark them since they are relevant
		if(locate(/obj/machinery/door/airlock) in floor)
			var/obj/machinery/door/airlock/affected_airlock = locate(/obj/machinery/door/airlock) in floor
			affected_airlock_list += affected_airlock
			affected_airlock.alpha = 50
			if(door_mode)
				floor.color = rgb(0, 255, 0) // color the doors green, we are tracking them
			else
				floor.color = rgb(255, 255, 0) // we aint tracking them, still mark them

	target.color = rgb(0, 0, 255) // higher color priority than any other turfs
	target.maptext = MAPTEXT("TARGET")

/obj/item/pinpointer/area_pinpointer/debug/attack_self(mob/living/user)
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)
	if(active)
		for(var/turf/floor as anything in area_turfs) // we need to clear all the colors we created
			floor.color = initial(floor.color)
			floor.maptext = initial(floor.maptext)
		for(var/obj/machinery/door/airlock/affected_airlock as anything in affected_airlock_list) // we need to reset the alpha on the airlocks
			affected_airlock.alpha = initial(affected_airlock.alpha)
		affected_airlock_list = list() // empty da list when we are done cleaning
	return ..()

/obj/item/pinpointer/area_pinpointer/debug/Destroy()
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)
	if(active)
		for(var/turf/floor as anything in area_turfs) // we need to clear all the colors we created
			floor.color = initial(floor.color)
			floor.maptext = initial(floor.maptext)
		for(var/obj/machinery/door/airlock/affected_airlock as anything in affected_airlock_list) // we need to reset the alpha on the airlocks
			affected_airlock.alpha = initial(affected_airlock.alpha)
	affected_airlock_list = null
	return ..()
