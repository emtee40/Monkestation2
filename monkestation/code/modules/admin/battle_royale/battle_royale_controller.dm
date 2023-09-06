GLOBAL_DATUM(battle_royale_controller, /datum/battle_royale_controller)

///List of all /datum/battle_royale_data/custom that have been created
GLOBAL_LIST_EMPTY(custom_battle_royale_data)

#define COIN_PRIZE "coins"
//Battle royale controller, IF THERE ARE MULTIPLE OF THESE SOMETHING HAS GONE SUPER WRONG
/datum/battle_royale_controller
	///Is this controller active and processing
	var/active = FALSE
	///How long has this datum been active for
	var/active_for = 0
	///list of our /datum/battle_royale_data datums
	var/list/data_datums
	///list of all our players assigned "antag" datums
	var/list/players = list()
	///Tracker var for what data in data_datums we should use next
	var/next_data_datum_value = 1
	///Ref to the /datum/battle_royale_data we are currently using
	var/datum/battle_royale_data/current_data
	///Ref to our barrier controller
	var/datum/royale_storm_controller/storm_controller = new
	///Assoc list of prizes for the winner
	var/list/prizes = list(COIN_PRIZE = 0,
						HIGH_THREAT = 0,
						MEDIUM_THREAT = 0,
						LOW_THREAT = 0)
	///What is the expected time for the entire station to be covered in storms
	var/max_duration = 0
	///Assoc list of loot tables to use
	var/static/list/loot_tables = list(COMMON_LOOT_TABLE = GLOB.royale_common_loot,
									UTILITY_LOOT_TABLE = GLOB.royale_utility_loot,
									RARE_LOOT_TABLE = GLOB.royale_rare_loot,
									SUPER_RARE_LOOT_TABLE = GLOB.royale_super_rare_loot,
									MISC_LOOT_TABLE = GLOB.royale_misc_loot)

/datum/battle_royale_controller/New()
	. = ..()
	if(GLOB.battle_royale_controller)
		message_admins("Battle royale controller datum created with already existing controller, force ending the current royale of the old controller and qdeling it.")
		QDEL_NULL(GLOB.battle_royale_controller)

	GLOB.battle_royale_controller = src
	storm_controller.royale_controller = src

/datum/battle_royale_controller/Destroy(force, ...)
	message_admins("Battle royale controller datum destroyed, force ending it's current royale.")
	GLOB.battle_royale_controller = null
	current_data = null
	QDEL_LIST(data_datums)
	QDEL_NULL(storm_controller)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/battle_royale_controller/process(seconds_per_tick)
	if(!active)
		message_admins("Battle royale controller attempting to process while inactive, stopping proccessing.")
		STOP_PROCESSING(SSprocessing, src)
		return

	if(!current_data)
		message_admins("Battle royale controller attempting to process without set current_data, stopping processing.")
		deactivate()
		return

	active_for += seconds_per_tick SECONDS
	if(check_data())
		current_data = data_datums["[next_data_datum_value]"]
		next_data_datum_value++

	spawn_loot_pods(calculate_spawned_loot_pods(seconds_per_tick))

	if(SPT_PROB(current_data.rare_drop_prob, 1))
		spawn_rare_drop()

	if(SPT_PROB(current_data.super_drop_prob, 1))
		spawn_super_drop()

///Setup and start a royale
/datum/battle_royale_controller/proc/setup(fast = FALSE, custom = FALSE, mob/user)
	if(active)
		if(user)
			to_chat(user, span_warning("A game has already started!"))
		return

	build_data_datums(fast, custom)
	send_to_playing_players(span_ratvar("Battle Royale will begin soon..."))
	GLOB.enter_allowed = FALSE
	GLOB.ghost_role_flags = NONE
	world.update_status()
	if(SSticker.current_state < GAME_STATE_PREGAME)
		send_to_playing_players(span_boldannounce("Battle Royale: Waiting for server to be ready..."))
		SSticker.start_immediately = FALSE
		UNTIL(SSticker.current_state >= GAME_STATE_PREGAME)
		send_to_playing_players(span_boldannounce("Battle Royale: Done!"))

	if(SSticker.current_state == GAME_STATE_PREGAME)
		for(var/mob/dead/new_player/player in GLOB.player_list)
			to_chat(player, span_greenannounce("You have been forced as an observer. When the prompt to join battle royale comes up, press yes. \
											This is normal and you are still in queue to play."))
			player.ready = FALSE
			player.make_me_an_observer()
		send_to_playing_players(span_boldannounce("Battle Royale: Force-starting game."))
		SSticker.start_immediately = TRUE

	send_to_playing_players(span_boldannounce("Battle Royale: Clearing world mobs."))
	for(var/mob/living/mob as() in GLOB.mob_living_list)
		mob.dust(TRUE, FALSE, TRUE)
		CHECK_TICK

	sound_to_playing_players('sound/misc/server-ready.ogg', 50, FALSE)
	send_to_playing_players(span_greenannounce("Battle Royale: STARTING IN 30 SECONDS."))
	send_to_playing_players(span_greenannounce("If you are on the main menu, observe immediately to sign up. (You will be prompted in 30 seconds.)"))
	sleep(30 SECONDS)
	send_to_playing_players(span_boldannounce("Battle Royale: STARTING IN 5 SECONDS."))
	send_to_playing_players(span_greenannounce("Make sure to hit yes to the sign up message given to all observing players."))
	sleep(5 SECONDS)
	send_to_playing_players(span_boldannounce("Battle Royale: Starting game."))
	start_royale()

///Start the royale
/datum/battle_royale_controller/proc/start_royale()
	if(!do_ghost_drop("Would you like to partake in BATTLE ROYALE?"))
		message_admins("No participants for battle royale, stopping royale.")
		end_royale()
		return

	storm_controller.setup()
	sound_to_playing_players('sound/misc/airraid.ogg', 100, FALSE)
	send_to_playing_players(span_boldannounce("A 1 minute grace period has been established. Good luck."))
	send_to_playing_players(span_boldannounce("WARNING: YOU WILL BE GIBBED IF YOU LEAVE THE STATION Z-LEVEL!"))
	send_to_playing_players(span_boldannounce("[length(players)] people remain..."))

	activate()
	addtimer(CALLBACK(src, PROC_REF(end_grace)), 1 MINUTES)
	if(length(data_datums))
		current_data = data_datums["[next_data_datum_value]"]
		next_data_datum_value++

	if(current_data)
		spawn_loot_pods(150)

/datum/battle_royale_controller/proc/do_ghost_drop(message, turf/turf_override, given_poll_time = 30 SECONDS, grace = TRUE)
	var/list/participants = list() //poll_ghost_candidates() requires station sentience to be enabled, so we have to manually do it
	for(var/mob/dead/observer/ghost_player in GLOB.player_list)
		participants += ghost_player

	participants = poll_candidates("[message]", poll_time = given_poll_time, group = participants)
	if(!length(participants))
		return FALSE

	players = list()
	for(var/mob/participant in participants)
		var/key = participant.key
		CHECK_TICK
		var/turf/spawn_turf = turf_override ? turf_override : get_safe_random_station_turf() //could also make this pick from assistant spawns
		var/obj/structure/closet/supplypod/centcompod/pod = new
		var/mob/living/carbon/human/spawned_human = new(pod)
		spawned_human.key = key
		if(grace)
			ADD_TRAIT(spawned_human, TRAIT_PACIFISM, BATTLE_ROYALE_TRAIT)
			spawned_human.status_flags |= GODMODE
			var/datum/action/cooldown/spell/aoe/knock/knock_spell = new
			knock_spell.Grant(spawned_human)
			to_chat(spawned_human, span_notice("You have been given knock and pacifism for 1 minute."))

		spawned_human.equipOutfit(/datum/outfit/job/assistant)
		spawned_human.setMaxHealth(200)
		spawned_human.set_health(200)
		var/obj/item/implant/weapons_auth/auth = new
		auth.implant(spawned_human)
		players += spawned_human.mind?.add_antag_datum(/datum/antagonist/battle_royale)
		new /obj/effect/pod_landingzone(spawn_turf, pod)
	return TRUE

///Remove grace period buffs and effects
/datum/battle_royale_controller/proc/end_grace()
	for(var/mob/player in GLOB.player_list)
		var/datum/action/cooldown/spell/aoe/knock/knock_spell = locate() in player.actions
		if(knock_spell)
			qdel(knock_spell)
		player.status_flags &= ~GODMODE
		REMOVE_TRAIT(player, TRAIT_PACIFISM, BATTLE_ROYALE_TRAIT)
		to_chat(player, span_greenannounce("You are no longer a pacifist. Be the last spessmens standing."))

///End a battle royale
/datum/battle_royale_controller/proc/end_royale(mob/living/winner)
	deactivate()
	storm_controller?.end_storm()
	storm_controller?.stop_storm()
	SSticker.force_ending = TRUE
	if(winner && !QDELETED(winner))
		send_to_playing_players(span_ratvar("VICTORY ROYALE!"))
		send_to_playing_players(span_ratvar("[key_name(winner)] is the winner!"))
		for(var/prize in prizes)
			if(!prizes[prize])
				continue
			if(prize == COIN_PRIZE)
				winner.client.prefs.adjust_metacoins(winner.ckey, prizes[prize], "Won battle royale.")
			else
				winner.client.saved_tokens.adjust_tokens(prize, prizes[prize])
				to_chat(winner, span_boldnotice("You have gained [prizes[prize]] [prize] token(s) for winning battle royale."))

		var/turf/winner_turf = get_turf(winner)
		if(winner_turf)
			new /obj/item/melee/supermatter_sword(winner_turf)
			do_ghost_drop("You you like to be part of a horde of assistants?", winner_turf, 10 SECONDS, FALSE)
			send_to_playing_players(span_userdanger("THE HORDE COMITH."))

///Check if we should end a battle royale
/datum/battle_royale_controller/proc/check_ending()
	var/list/living_players = list()
	for(var/datum/antagonist/battle_royale/antag_datum in players)
		if(!antag_datum.died && antag_datum.owner?.current)
			living_players += antag_datum.owner.current

	if(length(living_players) <= 1)
		end_royale(length(living_players) == 1 ? living_players[1] : null)

///Return how many loot pods to spawn
/datum/battle_royale_controller/proc/calculate_spawned_loot_pods(seconds)
	var/static/persistent_count //so we can spawn less then one pod per second(process)
	if(!current_data.pods_per_second || !seconds)
		return FALSE

	var/count = current_data.pods_per_second * seconds
	if(!count)
		return FALSE

	count = 10 * count //this allows us to avoid floating points
	count = truncate(count)
	if(!persistent_count)
		persistent_count = count
	else
		persistent_count += count

	var/spawn_count = FLOOR(persistent_count, 10)
	persistent_count = max(persistent_count - spawn_count, 0)
	if(spawn_count)
		return spawn_count / 10
	else
		return FALSE

///Spawns loot pods based on passed count
/datum/battle_royale_controller/proc/spawn_loot_pods(count)
	if(!current_data)
		message_admins("Battle royale controller attempting to call spawn_loot_pods() without set current_data, aborting.")
		return

	for(var/pods_to_spawn in 1 to count)
		do_loot_drop()
		CHECK_TICK

///Return TRUE if we should move to our next data_datums entry. Otherwise, return FALSE
/datum/battle_royale_controller/proc/check_data()
	if(!current_data)
		message_admins("Battle royale controller attempting to call check_data() without set current_data, stopping processing.")
		deactivate()
		return FALSE

	if(next_data_datum_value > length(data_datums))
		return FALSE

	var/datum/battle_royale_data/next_data = data_datums["[next_data_datum_value]"]
	if(active_for >= next_data.active_time)
		return TRUE
	return FALSE

///Build our data_datums list, if fast is TRUE then we will use the faster pre-made battle_royale_data set, if custom is TRUE then we will use custom data if possible
/datum/battle_royale_controller/proc/build_data_datums(fast = FALSE, custom = FALSE)
	QDEL_LIST(data_datums)
	var/list/new_data_datums = list()
	var/highest_active_time = 0
	if(custom && length(GLOB.custom_battle_royale_data))
		for(var/datum/battle_royale_data/data_datum in GLOB.custom_battle_royale_data)
			new_data_datums += data_datum
	else
		for(var/datum/battle_royale_data/data_datum as anything in subtypesof(/datum/battle_royale_data)) //need to get this to work
			data_datum = new data_datum()
			if(!data_datum.active_time||istype(data_datum, /datum/battle_royale_data/custom)||istype(data_datum, fast?/datum/battle_royale_data/normal : /datum/battle_royale_data/fast))
				qdel(data_datum)
				continue

			if(new_data_datums["[data_datum.active_time]"])
				message_admins("[data_datum] created with duplicate active_time to [new_data_datums["[data_datum.active_time]"]] in new_data_datums.")
				qdel(data_datum)
				continue

			new_data_datums["[data_datum.active_time]"] = data_datum
			if(data_datum.active_time > highest_active_time)
				highest_active_time = data_datum.active_time

	max_duration = 0
	var/data_datums_iterator = 0
	for(var/i in 1 to highest_active_time)
		if(new_data_datums["[i]"])
			var/datum/battle_royale_data/data_datum = new_data_datums["[i]"]
			//new_data_datums["[i]"] = null //check if we need to remove fully
			new_data_datums -= "[i]"
			new_data_datums["[data_datums_iterator++]"] = data_datum
			if(data_datum.final_time)
				max_duration = data_datum.final_time

	if(!max_duration)
		message_admins("No max length set for battle royale.")
	data_datums = new_data_datums

/datum/battle_royale_controller/proc/activate()
	active = TRUE
	START_PROCESSING(SSprocessing, src)

/datum/battle_royale_controller/proc/deactivate()
	active = FALSE
	STOP_PROCESSING(SSprocessing, src)

/datum/battle_royale_controller/proc/spawn_rare_drop()
	do_loot_drop(RARE_LOOT_TABLE, 15 SECONDS, "Incoming extended supply materials.")

/datum/battle_royale_controller/proc/spawn_super_drop()
	do_loot_drop(SUPER_RARE_LOOT_TABLE, 5 MINUTES, "We found a weird looking package in the back of our warehouse. \
				We have no idea what is in it, but it is marked as incredibily dangerous and could be a superweapon.")

#define MINIMUM_USEFUL_DROP_TIME 1 MINUTES
///Reduce the extra landing time of rare and super drops to make sure they wont land after royale end
/datum/battle_royale_controller/proc/calculate_drop_time(input_delay = 0)
	return max(0.4 SECONDS, min(max_duration - MINIMUM_USEFUL_DROP_TIME, active_for + input_delay) - active_for)

///Actually spawn the loot and pod for it
/datum/battle_royale_controller/proc/do_loot_drop(table, delay, announcement)
	if(!current_data)
		return

	if(!table)
		table = pick_weight(list(COMMON_LOOT_TABLE = current_data.common_weight,
								UTILITY_LOOT_TABLE = current_data.utility_weight,
								RARE_LOOT_TABLE = current_data.rare_weight,
								SUPER_RARE_LOOT_TABLE = current_data.super_rare_weight,
								MISC_LOOT_TABLE = current_data.misc_weight))

	var/list/picked_loot = add_loot_items(pick_weight(loot_tables[table]))

	if(prob(current_data?.extra_loot_prob))
		picked_loot = add_loot_items(pick_weight(GLOB.royale_extra_loot), picked_loot)

	var/list/valid_areas_list = storm_controller.outer_areas + storm_controller.middle_areas + storm_controller.inner_areas
	if(length(valid_areas_list))
		return

	var/drop_time = calculate_drop_time(delay)
	var/turf/targeted_turf
	var/list/turf_list = GLOB.station_turfs.Copy()
	shuffle_inplace(turf_list)
	for(var/turf/possible_turf in turf_list)
		var/area/turf_area = get_area(possible_turf)
		if(isclosedturf(possible_turf) || !(turf_area.type in valid_areas_list))
			continue
		targeted_turf = possible_turf
		break

	podspawn(list("target" = targeted_turf,
				"style" = ((table == MISC_LOOT_TABLE) ? STYLE_HONK : STYLE_BOX),
				"path" = /obj/structure/closet/supplypod/battle_royale,
				"spawn" = picked_loot,
				"delays" = list(POD_TRANSIT = 1, POD_FALLING = drop_time, POD_OPENING = 1 SECONDS, POD_LEAVING = 3 SECONDS)))

	if(announcement)
		priority_announce("[announcement] \nExpected Drop Location: [get_area(targeted_turf)]\n ETA: [drop_time/10] Seconds.", "High Command Supply Control",
						SSstation.announcer.get_rand_alert_sound())

/datum/battle_royale_controller/proc/add_loot_items(input_loot, list/input_list = list())
	if(!islist(input_list))
		input_list = list(input_list)

	if(islist(input_loot))
		for(var/entry as anything in input_loot)
			for(var/count in 1 to input_loot[entry])
				input_list += entry
	else
		input_list += input_loot
	return input_list

#undef COIN_PRIZE
#undef MINIMUM_USEFUL_DROP_TIME
