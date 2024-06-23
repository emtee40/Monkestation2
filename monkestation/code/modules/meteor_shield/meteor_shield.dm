GLOBAL_LIST_EMPTY_TYPED(meteor_shield_sats, /obj/machinery/satellite/meteor_shield)
GLOBAL_VAR_INIT(total_meteors_zapped, 0)

/obj/machinery/satellite/meteor_shield
	/// Whether the meteor sat checks for line of sight to determine if it can intercept a meteor.
	var/check_sight = TRUE
	/// The proximity monitor used to detect meteors entering the shield's range.
	var/datum/proximity_monitor/advanced/meteor_shield/monitor
	/// A counter for how many meteors this specific satellite has zapped.
	var/meteors_zapped = 0

/obj/machinery/satellite/meteor_shield/Initialize(mapload)
	. = ..()
	GLOB.meteor_shield_sats += src
	RegisterSignal(src, COMSIG_MOVABLE_SPACEMOVE, PROC_REF(on_space_move)) // so these fuckers don't drift off into space when you're trying to position them
	setup_proximity()
	register_context()

/obj/machinery/satellite/meteor_shield/examine(mob/user)
	. = ..()
	. += span_info("It has stopped <b>[meteors_zapped]</b> meteors so far.")
	. += span_info("Overall, all meteor shield satellites have stopped a combined <b>[GLOB.total_meteors_zapped]</b> meteors this shift.")

/obj/machinery/satellite/meteor_shield/proc/on_space_move(datum/source)
	SIGNAL_HANDLER
	return COMSIG_MOVABLE_STOP_SPACEMOVE

/obj/machinery/satellite/meteor_shield/Destroy()
	GLOB.meteor_shield_sats -= src
	QDEL_NULL(monitor)
	return ..()

/obj/machinery/satellite/meteor_shield/vv_edit_var(vname, vval)
	. = ..()
	if(.)
		switch(vname)
			if(NAMEOF(src, kill_range))
				monitor?.set_range(kill_range)
			if(NAMEOF(src, active))
				set_anchored(active)
				setup_proximity()

/obj/machinery/satellite/meteor_shield/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_LMB] = active ? "Deactivate" : "Activate"
	if(!active)
		context[SCREENTIP_CONTEXT_RMB] = "Pick up"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/satellite/meteor_shield/toggle(user)
	. = ..()
	setup_proximity()

/obj/machinery/satellite/meteor_shield/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	setup_proximity()

/obj/machinery/satellite/meteor_shield/proc/setup_proximity()
	if((obj_flags & EMAGGED) || !active)
		if(!QDELETED(monitor))
			QDEL_NULL(monitor)
	else
		if(QDELETED(monitor))
			monitor = new(src, kill_range)

/obj/machinery/satellite/meteor_shield/piercing
	check_sight = FALSE

/obj/machinery/satellite/meteor_shield/proc/change_meteor_chance(mod = 1)
	var/static/list/meteor_event_typecache
	if(!meteor_event_typecache)
		meteor_event_typecache = typecacheof(list(
			/datum/round_event_control/meteor_wave,
			/datum/round_event_control/sandstorm,
			/datum/round_event_control/space_dust,
			/datum/round_event_control/stray_meteor
		))
	var/list/all_events = SSevents.control | SSgamemode.control
	for(var/datum/round_event_control/event as anything in all_events)
		if(is_type_in_typecache(event, meteor_event_typecache))
			event.weight *= mod

/obj/machinery/satellite/meteor_shield/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN || !can_interact(user))
		return
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(active)
		balloon_alert(user, "can't pick up while active!")
		return
	balloon_alert(user, "picking up satellite...")
	if(do_after(user, 5 SECONDS, src))
		var/obj/item/meteor_shield_capsule/capsule = new(drop_location())
		user.put_in_hands(capsule)
		qdel(src)
