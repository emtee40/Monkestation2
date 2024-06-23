#define MINIMUM_POOL_DEPTH 1
#define MAXIMUM_POOL_DEPTH 28

/obj/machinery/pool_pump
	name = "pool pump"
	desc = "A pump that attaches to the side of a pool, with this installed it will allow you to insert a beaker and it will try and synthesize the chemicals to fill said pool."

	icon = 'monkestation/icons/obj/pools/structures.dmi'
	icon_state = "pool_pump"

	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10 ///this is basically a better chem factory its expensive as shit while running
	anchored = FALSE

	///the attached pools liquid_group
	var/datum/liquid_group/pool_group/attached_group
	///the held reagent container
	var/obj/item/reagent_containers/held_container
	///the list of creatable reagents - done via reagent = amount per process
	var/list/creatable_reagents = list()
	///the desired pool depth
	var/desired_depth = 15

	///the held turf thats being saved for when we turn the pump on
	var/turf/open/floor/lowered/iron/pool/cached_turf

	///are we turned on right now?
	var/turned_on = FALSE
	///this is our mapping var
	var/pool_dir = NORTH


/obj/machinery/pool_pump/station_pool/Initialize(mapload)
	. = ..()
	register_context()
	if(turned_on)
		START_PROCESSING(SSmachines, src)
		var/turf/open/source_turf = get_step(src, pool_dir)
		if(istype(source_turf, /turf/open/floor/lowered/iron/pool))
			connect(source_turf)

/obj/machinery/pool_pump/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_container)
		if(is_reagent_container(held_item))
			context[SCREENTIP_CONTEXT_LMB] = "Replace Beaker"
		else
			context[SCREENTIP_CONTEXT_LMB] = "Remove Beaker"
	if(!held_container)
		if(is_reagent_container(held_item))
			context[SCREENTIP_CONTEXT_LMB] = "Add Beaker"

	context[SCREENTIP_CONTEXT_ALT_LMB] = "Toggle Pumping"
	context[SCREENTIP_CONTEXT_RMB] = "Set Desired Depth"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/pool_pump/update_desc(updates)
	. = ..()
	var/list/desc_list = list()
	if(creatable_reagents)
		desc_list += "Will create:"
		for(var/datum/reagent/listed_reagent as anything in creatable_reagents)
			desc_list += "[round(creatable_reagents[listed_reagent])] units of [listed_reagent.name]"
	desc_list += "The pump is currently [turned_on ? "Turned On" : "Turned Off"]"
	desc = desc_list.Join("\n")

/obj/machinery/pool_pump/update_icon(updates)
	. = ..()
	if(turned_on)
		icon_state = "pool_pump-on"
	else
		icon_state = initial(icon_state)

/obj/machinery/pool_pump/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	var/turf/source_turf = get_turf(src)
	if(anchored || cached_turf)
		anchored = FALSE
		cached_turf = null
		attached_group = FALSE
		if(turned_on)
			turned_on = FALSE
			STOP_PROCESSING(SSmachines, src)
		to_chat(user, span_notice("You unwrench the [src]"))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	if(istype(source_turf, /turf/open/floor/lowered/iron/pool))
		return
	for(var/turf/open/open_turf in source_turf.atmos_adjacent_turfs)
		if(istype(open_turf, /turf/open/floor/lowered/iron/pool))
			connect(open_turf)
			anchored = TRUE
			to_chat(user, span_notice("You wrench the [src] securely to the ground"))
			return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/pool_pump/proc/connect(turf/open/floor/lowered/iron/pool/found_pool)
	if(!found_pool.cached_group)
		cached_turf = found_pool
		return
	if(found_pool.cached_group.connected_pump)
		return

	found_pool.cached_group.connected_pump = src

/obj/machinery/pool_pump/process()
	if(!cached_turf)
		return
	if(!length(creatable_reagents))
		return

	if(!attached_group)
		if(!cached_turf.cached_group)
			cached_turf.start_fill(creatable_reagents, 300)
		attached_group = cached_turf.cached_group
		RegisterSignal(attached_group, COMSIG_LIQUID_GROUP_DESTROYING, PROC_REF(clear_group))
		return


	if(attached_group.expected_turf_height >= desired_depth)
		return

	attached_group.add_reagents(cached_turf.liquids, creatable_reagents, 300)


/obj/machinery/pool_pump/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!held_container)
		return
	if(Adjacent(usr) && !issiliconoradminghost(usr))
		if (!usr.put_in_hands(held_container))
			held_container.forceMove(drop_location())
	else
		held_container.forceMove(drop_location())
	held_container = null

/obj/machinery/pool_pump/attackby(obj/item/weapon, mob/user, params)
	if(!is_reagent_container(weapon))
		return
	if(!held_container)
		if(!user.transferItemToLoc(weapon, src))
			return
		held_container = weapon
		creatable_reagents = build_list()
		update_appearance()
		return
	return ..()

/obj/machinery/pool_pump/proc/build_list()
	var/list/synthable_reagents = list()
	for(var/datum/reagent/listed_reagent in held_container.reagents.reagent_list)
		if(listed_reagent.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED)
			synthable_reagents[listed_reagent.type] = (listed_reagent.volume * 0.1)

	return synthable_reagents

/obj/machinery/pool_pump/AltClick(mob/user)
	. = ..()
	if(!turned_on && length(creatable_reagents))
		turned_on = TRUE
		START_PROCESSING(SSmachines, src)
	else
		turned_on = FALSE
		STOP_PROCESSING(SSmachines, src)

	update_appearance()

/obj/machinery/pool_pump/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	desired_depth = tgui_input_number(user, "Choose a desired depth for the pump", "[src]", desired_depth, MAXIMUM_POOL_DEPTH, MINIMUM_POOL_DEPTH)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef MINIMUM_POOL_DEPTH
#undef MAXIMUM_POOL_DEPTH

/obj/machinery/pool_pump/station_pool
	creatable_reagents = list(/datum/reagent/water = 25)
	desired_depth = 28
	anchored = TRUE
	turned_on = TRUE

/obj/machinery/pool_pump/proc/clear_group()
	UnregisterSignal(attached_group, COMSIG_LIQUID_GROUP_DESTROYING)
	attached_group = null
