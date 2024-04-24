///How much do we subtract from the base cose of adding a new area
#define AREAS_TO_IGNORE_FOR_COST 10
///How many areas are observation consoles able to warp to at the start
#define STARTING_WARP_AREAS 10

/datum/action/innate/clockcult/add_warp_area
	name = "Add Warp Area"
	desc = "Add an additional area observation consoles can warp to."
	button_icon_state = "Spatial Warp"
	///a cache of areas we can are to the warpable list
	var/static/list/cached_addable_areas
	///what area types are we blocked from warping to
	var/static/list/blocked_areas = typecacheof(list(/area/station/service/chapel, /area/station/ai_monitored))

/datum/action/innate/clockcult/add_warp_area/New(Target)
	. = ..()
	if(!cached_addable_areas)
		cached_addable_areas = list()
		for(var/area/station_area as anything in GLOB.the_station_areas)
			station_area = GLOB.areas_by_type[station_area]
			if(station_area.outdoors || (station_area.area_flags & ABDUCTOR_PROOF) || is_type_in_typecache(station_area, blocked_areas) || (station_area in GLOB.clock_warp_areas))
				continue
			cached_addable_areas += station_area

/datum/action/innate/clockcult/add_warp_area/IsAvailable(feedback)
	if(!IS_CLOCK(owner))
		return FALSE
	return ..()

/datum/action/innate/clockcult/add_warp_area/Activate()
	if(!cached_addable_areas || !length(cached_addable_areas))
		return

	var/area/input_area = tgui_input_list(owner, "Select an area to add.", "Add Area", cached_addable_areas)
	if(!input_area)
		return

	var/cost = max((length(GLOB.clock_warp_areas) * 3) - STARTING_WARP_AREAS, 0)
	if(tgui_alert(owner, "Are you sure you want to add [input_area]? It will cost [cost] vitality.", "Add Area", list("Yes", "No")) == "Yes")
		if(GLOB.clock_vitality < cost)
			to_chat(span_brass("Not enough vitality."))
			return
		GLOB.clock_warp_areas += input_area
		cached_addable_areas -= input_area
		send_clock_message(null, "[input_area] added to warpable areas.")

/datum/action/innate/clockcult/add_warp_area/proc/build_starting_warp_areas()
	if(!cached_addable_areas || !length(cached_addable_areas))
		return

	//shuffle_inplace(cached_addable_areas) //this is so our randomly picked maint areas are random without needing to do anything weird
	for(var/i in 1 to STARTING_WARP_AREAS)
		/*if(i <= 2) //always give them 2 maint areas to hopefully be easy to warp from
			var/area/station/maintenance/maint_area = locate() in cached_addable_areas
			if(maint_area)
				cached_addable_areas -= maint_area
				GLOB.clock_warp_areas += maint_area
				continue*/ //for if I implement abscond restrictions
		GLOB.clock_warp_areas += pick_n_take(cached_addable_areas)

/datum/action/innate/clockcult/show_warpable_areas
	name = "Warpable Areas"
	desc = "Display what areas are currently warpable to by observation consoles."
	button_icon_state = "console_info"

/datum/action/innate/clockcult/show_warpable_areas/Activate()
	to_chat(owner, examine_block(span_brass("Current areas observation consoles can warp to: [english_list(GLOB.clock_warp_areas)] <br/>\
				You can add additional areas with the \"Add Warp Area\" action."))) //anyone who has this action should also have add warp area

#undef AREAS_TO_IGNORE_FOR_COST
#undef STARTING_WARP_AREAS
