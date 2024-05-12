/datum/ai_behavior/head_to_hideout
	required_distance = 0
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/head_to_hideout/setup(datum/ai_controller/controller)
	var/list/turf_coords = controller.blackboard[BB_GARY_HIDEOUT]
	if(!length(turf_coords))
		return
	var/turf/target_turf = locate(turf_coords[1], turf_coords[2], turf_coords[3])
	var/mob/living/owner = controller.pawn
	if(!target_turf)
		return
	set_movement_target(controller, target_turf)
	if(get_dist(get_turf(owner), target_turf) > controller.max_target_distance)
		if(owner.fading_leap_up())
			owner.forceMove(target_turf)
			owner.fading_leap_down()
	return ..()

// We actually only wanted the movement so if we've arrived we're done
/datum/ai_behavior/head_to_hideout/perform(seconds_per_tick, datum/ai_controller/controller, area_key, turf_key)
	. = ..()
	var/list/turf_coords = controller.blackboard[BB_GARY_HIDEOUT]
	if(!length(turf_coords))
		return FALSE
	var/turf/target_turf = locate(turf_coords[1], turf_coords[2], turf_coords[3])

	if(target_turf != get_turf(controller.pawn))
		finish_action(controller, succeeded = FALSE)
	else
		finish_action(controller, succeeded = TRUE)

/datum/ai_behavior/head_to_hideout/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		controller.blackboard[BB_GARY_COME_HOME] = FALSE

/datum/ai_behavior/head_to_hideout/drop/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		var/mob/living/basic/chicken/gary/pawn = controller.pawn
		pawn.held_item.forceMove(get_turf(pawn))
		pawn.held_shinies += pawn.held_item.type
		pawn.held_item.AddComponent(/datum/component/garys_item)
		pawn.held_item = null
		controller.blackboard[BB_GARY_HAS_SHINY] = FALSE

/datum/ai_behavior/setup_hideout
	///all stored items retrieved from the save of gary
	var/list/stored_items = list()

/datum/ai_behavior/setup_hideout/setup(datum/ai_controller/controller)
	var/mob/living/basic/chicken/gary/pawn = controller.pawn

	stored_items = pawn.return_stored_items()

	if(!pawn.hideout)
		pawn.hideout = new()

	var/turf/current_home = get_turf(pawn)
	for(var/shiny_object in stored_items)
		if(!shiny_object)
			continue
		var/obj/item/spawned = new shiny_object(current_home)
		pawn.hideout.add_item(spawned)
		spawned.AddComponent(/datum/component/garys_item)
	finish_action(controller, TRUE)

/datum/ai_behavior/setup_hideout/perform(seconds_per_tick, datum/ai_controller/controller, ...)
	. = ..()
	finish_action(controller, TRUE)

/datum/ai_behavior/setup_hideout/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	controller.blackboard[BB_GARY_HIDEOUT_SETTING_UP] = FALSE

/datum/ai_behavior/gary_retrieve_item
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/gary_retrieve_item/setup(datum/ai_controller/controller, ...)
	. = ..()
	if(!controller.blackboard[BB_GARY_BARTER_ITEM])
		controller.blackboard[BB_GARY_BARTERING] = FALSE
		controller.blackboard[BB_GARY_BARTER_STEP] = 0
		return
	set_movement_target(controller, controller.blackboard[BB_GARY_BARTER_ITEM])

/datum/ai_behavior/gary_retrieve_item/perform(seconds_per_tick, datum/ai_controller/controller, ...)
	. = ..()
	finish_action(controller, TRUE)

/datum/ai_behavior/gary_retrieve_item/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	var/mob/living/basic/chicken/gary/gary = controller.pawn
	var/obj/item/item = controller.blackboard[BB_GARY_BARTER_ITEM]
	gary.held_item = item
	gary.hideout.remove_item(item)
	qdel(item.GetComponent(/datum/component/garys_item))

	item.forceMove(gary)
	controller.blackboard[BB_GARY_BARTER_STEP] = 2

/datum/ai_behavior/gary_give_item
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT


/datum/ai_behavior/gary_give_item/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/datum/weakref/ref = controller.blackboard[BB_GARY_BARTER_TARGET]
	if(!ref)
		return FALSE

	set_movement_target(controller, ref.resolve())

/datum/ai_behavior/gary_give_item/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/basic/chicken/gary/pawn = controller.pawn
	var/obj/item/held_item = pawn.held_item
	var/datum/weakref/ref = controller.blackboard[BB_GARY_BARTER_TARGET]
	var/atom/target = ref.resolve()

	if(!held_item) //if held_item is null, we pretend that action was succesful
		finish_action(controller, TRUE)
		return

	if(!target || !pawn.CanReach(target) || !isliving(target))
		finish_action(controller, FALSE)
		return

	var/mob/living/living_target = target

	if(!try_to_give_item(controller, living_target, held_item))
		return
	controller.PauseAi(1.5 SECONDS)
	living_target.visible_message(
		span_info("[pawn] starts trying to give [held_item] to [living_target]!"),
		span_warning("[pawn] tries to give you [held_item]!")
	)
	if(!do_after(pawn, 1 SECONDS, living_target))
		return

	try_to_give_item(controller, living_target, held_item, actually_give = TRUE)

/datum/ai_behavior/gary_give_item/proc/try_to_give_item(datum/ai_controller/controller, mob/living/target, obj/item/held_item, actually_give)
	if(QDELETED(held_item) || QDELETED(target))
		finish_action(controller, FALSE)
		return FALSE

	var/has_left_pocket = target.can_equip(held_item, ITEM_SLOT_LPOCKET)
	var/has_right_pocket = target.can_equip(held_item, ITEM_SLOT_RPOCKET)
	var/has_valid_hand

	var/mob/living/basic/chicken/gary/pawn = controller.pawn
	pawn.held_item = null
	for(var/hand_index in target.get_empty_held_indexes())
		if(target.can_put_in_hand(held_item, hand_index))
			has_valid_hand = TRUE
			break

	if(!has_left_pocket && !has_right_pocket && !has_valid_hand)
		held_item.forceMove(get_turf(target))
		finish_action(controller, FALSE)
		return FALSE

	if(!actually_give)
		return TRUE

	if(!has_valid_hand || prob(50))
		target.equip_to_slot_if_possible(held_item, (!has_left_pocket ? ITEM_SLOT_RPOCKET : (prob(50) ? ITEM_SLOT_LPOCKET : ITEM_SLOT_RPOCKET)))
	else
		target.put_in_hands(held_item)
	finish_action(controller, TRUE)

/datum/ai_behavior/gary_give_item/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	controller.blackboard[BB_GARY_BARTER_STEP] = 0
	controller.blackboard[BB_GARY_BARTERING] = FALSE
	controller.blackboard[BB_GARY_BARTER_ITEM] = null
	controller.blackboard[BB_GARY_BARTER_TARGET] = null


/datum/ai_behavior/gary_goto_target
	required_distance = 3
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/gary_goto_target/setup(datum/ai_controller/controller, ...)
	. = ..()
	var/mob/living/owner = controller.pawn

	var/list/turfs = list()
	for(var/mob/living/mob as anything in GLOB.player_list)
		if(!istype(mob))
			continue
		if(mob.z != SSmapping.levels_by_trait(ZTRAIT_STATION)[1])
			continue
		for(var/turf/open/turf in view(5, mob))
			turfs += turf

	var/turf/open/target_turf = null
	var/sanity = 0
	while(!target_turf && sanity < 100)
		sanity++
		var/turf/turf = pick(turfs)
		if(is_safe_turf(turf))
			target_turf = turf

	if(!target_turf)
		return FALSE

	set_movement_target(controller, target_turf)
	if(get_dist(get_turf(owner), target_turf) > controller.max_target_distance)
		if(owner.fading_leap_up())
			owner.forceMove(target_turf)
			owner.fading_leap_down()
	controller.blackboard[BB_GARY_WANDER_COOLDOWN] = world.time + 5 MINUTES
	finish_action(controller, TRUE)
	return ..()

/datum/ai_behavior/gary_goto_target/perform(seconds_per_tick, datum/ai_controller/controller, ...)
	. = ..()
	finish_action(controller, TRUE)

