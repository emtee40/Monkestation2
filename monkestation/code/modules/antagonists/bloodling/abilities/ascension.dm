/datum/action/cooldown/bloodling/ascension
	name = "Ascend"
	desc = "We reach our last form...Mass consumption is required. Costs 250 Biomass and takes 5 minutes for you to ascend."
	button_icon_state = "dissonant_shriek"
	biomass_cost = 250

/datum/action/cooldown/bloodling/ascension/Activate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	our_mob.move_resist = INFINITY
	ADD_TRAIT(our_mob, TRAIT_IMMOBILIZED, REF(src))
	// Waits 5 minutes before calling the ascension
	addtimer(CALLBACK(src, PROC_REF(ascend), our_mob), 5 MINUTES)


	/* PLANS
	* turn the bloodling into a buffed up meteor heart on completion
	*/

	force_event(/datum/round_event_control/bloodling_ascension, "A bloodling is ascending")

	return TRUE

/datum/action/cooldown/bloodling/ascension/proc/ascend(mob/living/basic/bloodling)
	// Woah they can move
	REMOVE_TRAIT(bloodling, TRAIT_IMMOBILIZED, REF(src))

/* PLANS
	* Make tiles that turn people into thralls
*/
/turf/open/floor/bloodling
	name = "nerve threads"
	icon_state = "materialfloor"
	baseturfs = /turf/open/plating

/datum/dimension_theme/bloodling
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meat"
	material = /datum/material/meat
	sound = 'sound/items/eatfood.ogg'
	replace_objs = list(\
		/obj/machinery/atmospherics/components/unary/vent_scrubber = list(/obj/structure/meateor_fluff/eyeball = 1), \
		/obj/machinery/atmospherics/components/unary/vent_pump = list(/obj/structure/meateor_fluff/eyeball = 1), \
		/turf/open/floor = list(/turf/open/floor/bloodling),)

/* PLANS
	* Make this call the shuttle
*/
/datum/round_event_control/bloodling_ascension
	name = "Bloodling ascension"
	typepath = /datum/round_event/bloodling_ascension
	max_occurrences = 0
	weight = 0
	alert_observers = FALSE
	category = EVENT_CATEGORY_SPACE

/datum/round_event/bloodling_ascension
	// Holds our theme
	var/datum/dimension_theme/chosen_theme

/datum/round_event/bloodling_ascension/announce(fake)

	priority_announce("You have failed to contain the organism. Its takeover of the station will be absolute. Emergency shuttle dispatched.","Central Command Biohazard Agency", 'monkestation/sound/bloodsuckers/monsterhunterintro.ogg')

// The start of the event, it grabs a bunch of turfs to parse and apply our theme to
/datum/round_event/bloodling_ascension/start()
	chosen_theme = new /datum/dimension_theme/bloodling()
	// Placeholder code, just for testing
	var/turf/start_turf = get_turf(pick(GLOB.station_turfs))
	var/greatest_dist = 0
	var/list/turfs_to_transform = list()
	for (var/turf/transform_turf as anything in GLOB.station_turfs)
		if (!chosen_theme.can_convert(transform_turf))
			continue
		var/dist = get_dist(start_turf, transform_turf)
		if (dist > greatest_dist)
			greatest_dist = dist
		if (!turfs_to_transform["[dist]"])
			turfs_to_transform["[dist]"] = list()
		turfs_to_transform["[dist]"] += transform_turf

	if (chosen_theme.can_convert(start_turf))
		chosen_theme.apply_theme(start_turf)

	for (var/iterator in 1 to greatest_dist)
		if(!turfs_to_transform["[iterator]"])
			continue
		addtimer(CALLBACK(src, PROC_REF(transform_area), turfs_to_transform["[iterator]"]), (5 SECONDS) * iterator)

/datum/round_event/bloodling_ascension/proc/transform_area(list/turfs)
	for (var/turf/transform_turf as anything in turfs)
		if (!chosen_theme.can_convert(transform_turf))
			continue
		chosen_theme.apply_theme(transform_turf)
		CHECK_TICK
