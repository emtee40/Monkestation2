/datum/ai_controller/basic_controller/slime
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_BASIC_MOB_SCARED_ITEM = /obj/item/extinguisher,
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_WONT_TARGET_CLIENTS = FALSE, //specifically to stop targetting clients
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_slime_playful
	planning_subtrees = list(
		//we try to flee first these flip flop based on flee state which is controlled by a componenet on the mob
		/datum/ai_planning_subtree/simple_find_nearest_target_to_flee_has_item,
		/datum/ai_planning_subtree/flee_target,
		//now we try to
		/datum/ai_planning_subtree/simple_find_target_no_trait/slime,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/slime,
	)


/datum/ai_movement/jps_slime
	max_pathing_attempts = 20

/datum/ai_movement/jps_slime/start_moving_towards(datum/ai_controller/controller, atom/current_movement_target, min_distance)
	. = ..()
	var/atom/movable/moving = controller.pawn
	var/delay = controller.movement_delay

	var/datum/move_loop/loop = SSmove_manager.jps_move(moving,
		current_movement_target,
		delay,
		repath_delay = 0.1 SECONDS,
		max_path_length = AI_MAX_PATH_LENGTH * 3,
		minimum_distance = controller.get_minimum_distance(),
		access = controller.get_access(),
		subsystem = SSai_movement,
		extra_info = controller,
	)

	RegisterSignal(loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(loop, COMSIG_MOVELOOP_JPS_REPATH, PROC_REF(repath_incoming))

/datum/ai_movement/jps_slime/proc/repath_incoming(datum/move_loop/has_target/jps/source)
	SIGNAL_HANDLER
	var/datum/ai_controller/controller = source.extra_info

	source.access = controller.get_access()
	source.minimum_distance = controller.get_minimum_distance()
