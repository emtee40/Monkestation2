/obj/item/pinpointer/crew/contractor
	name = "contractor pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. Ignores suit sensors, but is much less accurate."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	minimum_range = 15
	has_owner = TRUE
	ignore_suit_sensor_level = TRUE

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

/obj/item/pinpointer/area_pinpointer/Destroy()
	tracked_area = null
	pinpointer_turf = null
	return ..()

// we need to get our own examine text, since it would be "tracking the floor" otherwise
/obj/item/pinpointer/area_pinpointer/examine(mob/user)
	. = ..()
	if(target)
		. += "It is currently tracking [tracked_area]."

/obj/item/pinpointer/area_pinpointer/get_direction_icon(here, there)
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)

	var/turf/pinpointer_turf = get_turf(src)
	for(var/turf/possible_turf as anything in area_turfs) // im a bit scared of the effects this may have on performance, but it seems fine
		if(get_dist_euclidian(pinpointer_turf, possible_turf) <= minimum_range)
			return "pinon[alert ? "alert" : ""]direct[icon_suffix]"

	return ..()

/obj/item/pinpointer/area_pinpointer/scan_for_target()
	var/current_turf = get_turf(src)

	if(pinpointer_turf == current_turf) // if our position has not changed, we dont need to update our target.
		return

	pinpointer_turf = current_turf

	/// The turf that has the lowest possible range towards us and the area
	var/turf/closest_turf
	/// Whats the range between us and the closest turf?
	var/closest_turf_range = 255
	for(var/turf/open/floor as anything in area_open_turfs) // Lets go over everything and check their distances for the closest tile
		if(get_dist_euclidian(pinpointer_turf, floor) < closest_turf_range)
			closest_turf_range = get_dist_euclidian(pinpointer_turf, floor)
			closest_turf = floor

	target = closest_turf

/obj/item/pinpointer/area_pinpointer/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		area_open_turfs = list() // empty the list so we can fill it on the next activation with the new area's turfs
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

	var/list/area_turfs = list()
	area_turfs = get_area_turfs(tracked_area)
	for(var/turf/floor as anything in area_turfs) // Lets go over everything and store the turfs we care about
		if(floor.density) // catch all the walls, we dont want them
			continue
		area_open_turfs += floor

	var/turf/target_turf = get_first_open_turf_in_area(target_area)
	target = target_turf

	toggle_on()

	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))

/obj/item/extraction_pack/contractor
	name = "black fulton extraction pack"
	desc = "A modified fulton pack that can be used indoors thanks to Bluespace technology. Favored by Syndicate Contractors."
	icon = 'monkestation/icons/obj/items/fulton.dmi'
	can_use_indoors = TRUE
