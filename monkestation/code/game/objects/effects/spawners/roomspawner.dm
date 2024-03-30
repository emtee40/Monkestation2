
//random room spawner. takes random rooms from their appropriate map file and places them.

/obj/effect/spawner/room
	name = "random room spawner"
	icon = 'monkestation/icons/effects/landmarks_static.dmi'
	icon_state = "random_room"
	dir = NORTH
	///List of template room_key values that are valid for us to pick from
	var/list/valid_room_keys = list()
	///What is the width of rooms we spawn
	var/room_width = 0
	///What is the height of rooms we spawn
	var/room_height = 0

/obj/effect/spawner/room/Initialize(mapload)
	. = ..()
	if(!SSmapping.valid_random_templates_by_spawner_type[src.type])
		SSmapping.valid_random_templates_by_spawner_type[src.type] = list()
		for(var/key in valid_room_keys)
			for(var/datum/map_template/random_room/possible_template in SSmapping.random_room_templates[key])
				if(room_height != possible_template.template_height || room_width != possible_template.template_width || \
					(possible_template.valid_station_list && !(SSmapping.config.map_name in possible_template.valid_station_list)))
					continue
				SSmapping.valid_random_templates_by_spawner_type[src.type] += possible_template

	//template weights can change so this has to be generated each time we want to spawn a room
	var/list/weighted_template_list = list()
	for(var/datum/map_template/random_room/template in SSmapping.valid_random_templates_by_spawner_type[src.type])
		if((template.stock != -1 && !template.stock))
			SSmapping.valid_random_templates_by_spawner_type[src.type] -= template
			continue
		weighted_template_list[template] = template.weight

	if(!length(weighted_template_list))
		message_admins("Room spawner created with no templates available. This shouldn't happen.")
		stack_trace("Room spawner([src.type]) created with no templates available.")
		return INITIALIZE_HINT_QDEL

	var/datum/map_template/random_room/picked_template = pick_weight(weighted_template_list)
	picked_template.stock--
	picked_template.weight -= picked_template.scaling_weight
	if(SSticker.state == GAME_STATE_STARTUP)
		picked_template.stationinitload(get_turf(src), picked_template.centerspawner)
	else
		picked_template.load(get_turf(src), picked_template.centerspawner)
	log_world("Loading random room template [picked_template.name] ([picked_template.type]) at [AREACOORD(src)]")
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/room/five_by_four
	name = "5x4 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_FIVE_BY_FOUR_MAINTS)
	room_width = 5
	room_height = 4

/obj/effect/spawner/room/four_by_four_maints
	name = "4x4 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_FOUR_BY_FOUR_MAINTS)
	room_width = 4
	room_height = 4

/obj/effect/spawner/room/five_by_three
	name = "5x3 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_FIVE_BY_THREE_MAINTS)
	room_width = 5
	room_height = 3

/obj/effect/spawner/room/three_by_five
	name = "3x5 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_FIVE_BY_FOUR_MAINTS)
	room_width = 3
	room_height = 5

/obj/effect/spawner/room/three_by_eight_maints
	name = "3x8 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_THREE_BY_EIGHT_MAINTS)
	room_width = 3
	room_height = 5

/obj/effect/spawner/room/eight_by_three_maints
	name = "8x3 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_EIGHT_BY_THREE_MAINTS)
	room_width = 8
	room_height = 3

/obj/effect/spawner/room/ten_by_ten
	name = "10x10 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_TEN_BY_TEN_MAINTS)
	room_width = 10
	room_height = 10

/obj/effect/spawner/room/ten_by_five
	name = "10x5 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_TEN_BY_FIVE_MAINTS)
	room_width = 10
	room_height = 5

/obj/effect/spawner/room/three_by_three
	name = "3x3 maint room spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_THREE_BY_THREE_MAINTS)
	room_width = 3
	room_height = 3

/obj/effect/spawner/room/fland
	name = "Fland Maint Room (5x11)"
	icon_state = "random_room_alternative"
	valid_room_keys = list(RANDOM_ROOM_KEY_FLAND_MAINTS)
	room_width = 5
	room_height = 11

/// MetaStation Engine Area Spawner
/obj/effect/spawner/room/random_engines/meta
	name = "meta engine spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_META_ENGINE)
	room_width = 33
	room_height = 25

/// TramStation Engine Area Spawner
/obj/effect/spawner/room/random_engines/tram
	name = "tram engine spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_TRAM_ENGINE)
	room_width = 24
	room_height = 20

/obj/effect/spawner/room/random_engines/kilo
	name = "kilo engine spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_KILO_ENGINE)
	room_width = 20
	room_height = 21

/obj/effect/spawner/room/random_bar/icebox
	name = "Icebox bar spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_ICEBOX_BAR)
	room_width = 18
	room_height = 12

/obj/effect/spawner/room/random_bar/tramstation
	name = "Tramstation bar spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_TRAM_BAR)
	room_width = 30
	room_height = 25
