/datum/map_template/random_room
	///The key type that this room will spawn under
	var/room_key = RANDOM_ROOM_KEY_DEFAULT
	///Our exact id, should be unique to each type. If unset then we will be ignored
	var/room_id
	///List of stations this template is restricted to. Keep unset to allow spawning on any station
	var/list/valid_station_list //TODO: convert this into defines
	///Do we spawn centered
	var/centerspawner = TRUE
	///How many tiles tall is this template
	var/template_height = 0
	///How many tiles long is this template
	var/template_width = 0
	///Weight for this room to be picked for spawning
	var/weight = 10
	///Amount to subtract from weight each time we spawn
	var/scaling_weight = 0
	///The maximum amount of times this room can be picked to spawn, set to -1 for unlimited
	var/stock = 1
