GLOBAL_DATUM(battle_royale_controller, /datum/battle_royale_controller)

///List of all /datum/battle_royale_data/custom that have been created
GLOBAL_LIST_EMPTY(custom_battle_royale_data)

//Battle royale controller, IF THERE ARE MULTIPLE OF THESE SOMETHING HAS GONE VERY WRONG
/datum/battle_royale_controller
	///Is this datum active and processing, checked before doing most actions
	var/active = FALSE
	///How long has this datum been active for
	var/active_for = 0
	///list of our /datum/battle_royale_data datums
	var/list/data_datums
	///List of all our players
	var/list/players = list()
	///How large are teams, team sizes of over 1 are NYI
	var/teamsize = 1
	///List of all our teams, indexed by team name, only used for multiplayer teams
	var/list/teams = list()
	///Should the barrier move, not recommended unless you plan on ending the royale yourself
	var/barrier_moving = TRUE
	///Tracker var for what data in data_datums we should use next
	var/next_data_datum_value = 0

///Build our data_datums list, if fast is TRUE then we will use the faster pre-made battle_royale_data set, if custom is TRUE then we will use custom data if possible
/datum/battle_royale_controller/proc/build_data_datums(fast = FALSE, custom = FALSE)
	var/list/new_data_datums = list()
	var/highest_active_time = 0
	if(custom && length(GLOB.custom_battle_royale_data))
		for(var/datum/battle_royale_data/new_data_datum in GLOB.custom_battle_royale_data)
			new_data_datums += new_data_datum
	else
		for(var/datum/battle_royale_data/new_data_datum as anything in subtypesof(/datum/battle_royale_data))
			if(istype(data_datum, /datum/battle_royale_data/custom) || (fast ? istype(data_datum, /datum/battle_royale_data/fast) : !istype(data_datum, /datum/battle_royale_data/fast)))
				continue
			new_data_datum = new new_data_datum()
			if(new_data_datums[new_data_datum.active_time])
				message_admins("[new_data_datum] created with duplicate active_time to [new_data_datums[new_data_datum.active_time]] in new_data_datums.")
				qdel(new_data_datum)
				continue
			new_data_datums[new_data_datum.active_time] = new_data_datum
			if(new_data_datum.active_time > highest_active_time)
				highest_active_time = new_data_datum.active_time

	var/data_datums_iterator = 0
	for(var/i in 1 to highest_active_time)
		if(new_data_datums[i])
			var/datum/battle_royale_data/data_datum = new_data_datums[i]
			new_data_datums[i] = FALSE
			new_data_datums[data_datums_iterator++] = data_datum
	return new_data_datums


/datum/battle_royale_controller/proc/activate()
	active = TRUE
	START_PROCESSING(SSprocessing, src)

/datum/battle_royale_controller/proc/deactivate()
	active = FALSE
	STOP_PROCESSING(SSprocessing, src)

/datum/battle_royale_data
	///When does this dataset take effect
	var/active_time = 0
	///What does this set the weight of common loot drops to
	var/common_weight = 0
	///What does this set the weight of utility loot drops to
	var/utility_weight = 0
	///What does this set the weight of rare loot drops to
	var/rare_weight = 0
	///What does this set the weight of very rare loot drops to
	var/very_rare_weight = 0
	///What does this set the weight of misc loot drops to
	var/misc_weight = 0
	///How many tiles per second does this make the barrier move
	var/barrier_move_speed = 0

//Used for admin custom royale data sets
/datum/battle_royale_data/custom/New()
	. = ..()
	GLOB.custom_battle_royale_data += src

/datum/battle_royale_data/custom/Destroy(force, ...)
	GLOB.custom_battle_royale_data -= src
	return ..()
