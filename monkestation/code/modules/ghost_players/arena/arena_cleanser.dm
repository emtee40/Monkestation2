/proc/reset_arena_area()
	var/list/turfs = get_area_turfs(/area/centcom/tdome/arena/actual)
	for(var/turf/listed_turf in turfs)
		for(var/atom/listed_atom in listed_turf.contents)
			if(istype(listed_atom, /mob/dead/observer))
				continue
			if(istype(listed_atom, /mob/living/carbon/human/ghost))
				var/mob/living/carbon/human/ghost/mob = listed_atom
				mob.move_to_ghostspawn()
				mob.fully_heal()
				continue
			qdel(listed_atom)
		listed_turf.baseturfs = list(/turf/open/indestructible/event/plating)
	var/turf/located = locate(148, 29, SSmapping.levels_by_trait(ZTRAIT_CENTCOM)[1]) // this grabs the bottom corner turf
	new /obj/effect/spawner/room/random_arena_spawner(located)

/obj/effect/spawner/room/random_arena_spawner
	name = "random arena spawner"
	valid_room_keys = list(RANDOM_ROOM_KEY_ARENA)
	room_width = 17
	room_height = 10
