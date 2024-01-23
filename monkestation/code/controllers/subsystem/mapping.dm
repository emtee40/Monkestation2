/datum/controller/subsystem/mapping
	///Assoc list of sublists of random room templates, keyed to their room_key value
	var/list/random_room_templates = list()
	///Temporary assoc list of sublists of the room spawner effects, keyed to the type of the spawner
	//var/list/random_room_spawners = list()
	///Assoc list of sublists of random room templates, keyed to what spawner type they are valid for
	var/list/valid_random_templates_by_spawner_type = list()

/datum/controller/subsystem/mapping/proc/LoadStationRoomTemplates()
	for(var/datum/map_template/random_room/room as anything in subtypesof(/datum/map_template/random_room))
		room = new room
		if(!room.mappath)
			message_admins("Template [initial(room.name)] found without mappath. Yell at coders")
			stack_trace("Template [initial(room.name)] found without mappath.")
			qdel(room)
			continue

		if(!room.room_key || !room.room_id)
			qdel(room)
			continue

		if(!random_room_templates[room.room_key])
			random_room_templates[room.room_key] = list()

		random_room_templates[room.room_key] += room
		map_templates[room.room_id] = room
