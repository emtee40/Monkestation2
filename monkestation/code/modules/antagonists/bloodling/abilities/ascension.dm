/datum/action/cooldown/bloodling/ascension
	name = "Ascend"
	desc = "We reach our last form...Mass consumption is required. Costs 500 Biomass and takes 5 minutes for you to ascend."
	button_icon_state = "dissonant_shriek"
	biomass_cost = 500
	var/static/datum/dimension_theme/chosen_theme

/datum/action/cooldown/bloodling/ascension/Activate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	our_mob.move_resist = INFINITY
	ADD_TRAIT(our_mob, TRAIT_IMMOBILIZED, REF(src))
	// Waits 5 minutes before calling the ascension
	addtimer(CALLBACK(src, PROC_REF(ascend), our_mob), 5 MINUTES)
	/* PLANS
	* turn the bloodling into a buffed up meteor heart on completion
	*/
	return TRUE

/datum/action/cooldown/bloodling/ascension/proc/ascend(mob/living/basic/bloodling)
	// Woah they can move
	REMOVE_TRAIT(bloodling, TRAIT_IMMOBILIZED, REF(src))
	SSshuttle.requestEvac(src, "ALERT: LEVEL 4 BIOHAZARD DETECTED. ORGANISM CONTAINMENT HAS FAILED. EVACUATE REMAINING PERSONEL.")

	if(isnull(chosen_theme))
		chosen_theme = new /datum/dimension_theme/bloodling()
	// Placeholder code, just for testing
	var/turf/start_turf = get_turf(bloodling)
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

/datum/action/cooldown/bloodling/ascension/proc/transform_area(list/turfs)
	for (var/turf/transform_turf as anything in turfs)
		if (!chosen_theme.can_convert(transform_turf))
			continue
		chosen_theme.apply_theme(transform_turf)
		CHECK_TICK

/turf/open/floor/misc/bloodling
	name = "nerve threads"
	icon = 'monkestation/code/modules/antagonists/bloodling/bloodling_sprites.dmi'
	icon_state = "flesh_tile"
	baseturfs = /turf/open/floor/plating
	smoothing_flags = SMOOTH_BITMASK

/datum/dimension_theme/bloodling
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meat"
	sound = 'sound/items/eatfood.ogg'
	replace_floors = list(/turf/open/floor/misc/bloodling = 1)
	replace_walls = /turf/closed/wall/material/meat
	window_colour = "#5c0c0c"
	replace_objs = list(\
		/obj/machinery/atmospherics/components/unary/vent_scrubber = list(/obj/structure/meateor_fluff/eyeball = 1), \
		/obj/machinery/atmospherics/components/unary/vent_pump = list(/obj/structure/meateor_fluff/eyeball = 1),)

