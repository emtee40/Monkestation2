/obj/item/pinpointer/crew/contractor
	name = "contractor pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. Ignores suit sensors, but is much less accurate."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	minimum_range = 15
	has_owner = TRUE
	ignore_suit_sensor_level = TRUE

/obj/item/pinpointer/area_pinpointer
	name = "hacked pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. This one seems to have wires sticking out of it, and can point onto areas instead of humans."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	special_examine = TRUE
	var/area/examine_area
	var/pinpointer_owner

/obj/item/pinpointer/area_pinpointer/Destroy()
	examine_area = null
	return ..()

/obj/item/pinpointer/area_pinpointer/get_direction_icon(here, there)
	var/list/area_turfs = list()
	area_turfs = get_area_turfs(examine_area)

	var/turf/target_turf = get_turf(src)
	for(var/turf/possible_turf as anything in area_turfs) // im a bit scared of the effects this may have on performance, but it seems fine
		if(get_dist_euclidian(target_turf, possible_turf) <= minimum_range)
			return "pinon[alert ? "alert" : ""]direct[icon_suffix]"

	return ..()

// we need to get our own examine text, since it would be "tracking the floor" otherwise
/obj/item/pinpointer/area_pinpointer/examine(mob/user)
	. = ..()
	if(target)
		. += "It is currently tracking [examine_area]."

/obj/item/pinpointer/area_pinpointer/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		return

	if(!pinpointer_owner)
		pinpointer_owner = user

	if(pinpointer_owner != user)
		to_chat(user, span_notice("The pinpointer doesn't respond. It seems to only recognise its owner."))
		return

	// This list should ONLY include areas that are on our z-level and are actually recognizable, else we confuse the contractor
	var/list/possible_areas = list()
	for(var/area/area in GLOB.areas)
		var/our_z = user?.z
		var/area_z = area?.z
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
	if(QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated())
		return
	examine_area = target_area

	var/turf/target_turf = get_first_open_turf_in_area(target_area)

	target = target_turf
	toggle_on()
	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))

/obj/item/extraction_pack/contractor
	name = "black fulton extraction pack"
	desc = "A modified fulton pack that can be used indoors thanks to Bluespace technology. Favored by Syndicate Contractors."
	icon = 'monkestation/icons/obj/items/fulton.dmi'
	can_use_indoors = TRUE
