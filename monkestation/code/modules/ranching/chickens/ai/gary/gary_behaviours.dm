/datum/ai_behavior/head_to_hideout
	required_distance = 0
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/head_to_hideout/setup(datum/ai_controller/controller)
	var/datum/weakref/weak_turf = controller.blackboard[BB_GARY_HIDEOUT]
	var/turf/target_turf = weak_turf?.resolve()
	var/mob/living/owner = controller.pawn
	set_movement_target(controller, target_turf)
	if(get_dist(get_turf(owner), target_turf) > 14)
		if(owner.fading_leap_up())
			owner.forceMove(target_turf)
			owner.fading_leap_down()
	return ..()

// We actually only wanted the movement so if we've arrived we're done
/datum/ai_behavior/head_to_hideout/perform(seconds_per_tick, datum/ai_controller/controller, area_key, turf_key)
	. = ..()
	var/datum/weakref/weak_turf = controller.blackboard[BB_GARY_HIDEOUT]
	var/turf/target_turf = weak_turf?.resolve()

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

	var/turf/current_home = get_turf(pawn)
	for(var/shiny_object in stored_items)
		if(!shiny_object)
			continue
		var/obj/item/spawned = new shiny_object(current_home)
		spawned.AddComponent(/datum/component/garys_item)
	finish_action(controller, TRUE)

/datum/ai_behavior/setup_hideout/perform(seconds_per_tick, datum/ai_controller/controller, ...)
	. = ..()
	finish_action(controller, TRUE)

/datum/ai_behavior/setup_hideout/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	controller.blackboard[BB_GARY_HIDEOUT_SETTING_UP] = FALSE
