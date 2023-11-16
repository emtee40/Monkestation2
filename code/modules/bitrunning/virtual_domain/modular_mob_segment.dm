#define SPAWN_ALWAYS 100
#define SPAWN_LIKELY 85
#define SPAWN_UNLIKELY 35
#define SPAWN_RARE 10

/datum/modular_mob_segment
	/// Spawn no more than this amount
	var/max = 4
	/// Set this to false if you want explicitly what's in the list to spawn
	var/exact = FALSE
	/// The list of mobs to spawn
	var/list/mob/living/mobs = list()
	/// The mobs spawned from this segment
	var/list/spawned_mob_refs = list()
	/// Chance this will spawn (1 - 100)
	var/probability = SPAWN_LIKELY

/// Spawns mobs in a circle around the location
/datum/modular_mob_segment/proc/spawn_mobs(turf/origin)
	if(!prob(probability))
		return

	var/total_amount = exact ? rand(1, max) : length(mobs)

	shuffle_inplace(mobs)


	var/list/turf/nearby = list()
	for(var/turf/tile as anything in RANGE_TURFS(2, origin))
		if(!tile.is_blocked_turf())
			nearby += tile

	if(!length(nearby))
		stack_trace("Couldn't find any valid turfs to spawn on")
		return

	for(var/index in 1 to total_amount)
		// For each of those, we need to find an open space
		var/turf/destination = pick(nearby)

		var/path // Either a random mob or the next mob in the list
		if(exact)
			path = mobs[index]
		else
			path = pick(mobs)

		var/mob/living/mob = new path(destination)
		nearby -= destination
		spawned_mob_refs.Add(WEAKREF(mob))

// Some generic mob segments. If you want to add generic ones for any map, add them here

/datum/modular_mob_segment/gondolas
	mobs = list(
		/mob/living/simple_animal/pet/gondola,
	)

/datum/modular_mob_segment/corgis
	max = 2
	mobs = list(
		/mob/living/basic/pet/dog/corgi,
	)

/datum/modular_mob_segment/monkeys
	mobs = list(
		/mob/living/carbon/human/species/monkey,
	)

/datum/modular_mob_segment/syndicate_team
	mobs = list(
		/mob/living/basic/trooper/syndicate/ranged,
		/mob/living/basic/trooper/syndicate/melee,
	)

/datum/modular_mob_segment/syndicate_elite
	mobs = list(
		/mob/living/basic/trooper/syndicate/melee/sword/space/stormtrooper,
		/mob/living/basic/trooper/syndicate/ranged/space/stormtrooper,
	)

/datum/modular_mob_segment/bears
	max = 2
	mobs = list(
		/mob/living/basic/bear,
	)

/datum/modular_mob_segment/bees
	exact = TRUE
	mobs = list(
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee/queen,
	)

/datum/modular_mob_segment/bees_toxic
	mobs = list(
		/mob/living/basic/bee/toxin,
	)

/datum/modular_mob_segment/blob_spores
	mobs = list(
//		/mob/living/basic/blob_minion, MONKEYSTATION EDIT CHANGE OLD - We dont have basic mob spores
		/mob/living/simple_animal/hostile/blob/blobspore // MONKEYSTATION EDIT CHANGE NEW - We dont have basic mob spores
	)

/datum/modular_mob_segment/carps
	mobs = list(
		/mob/living/basic/carp,
	)

/datum/modular_mob_segment/hivebots
	mobs = list(
		/mob/living/basic/hivebot,
		/mob/living/basic/hivebot/range,
	)

/datum/modular_mob_segment/hivebots_strong
	mobs = list(
		/mob/living/basic/hivebot/strong,
		/mob/living/basic/hivebot/range,
	)

/datum/modular_mob_segment/lavaland_assorted
	mobs = list(
		/mob/living/basic/mining/basilisk,
		/mob/living/basic/mining/goliath,
//		/mob/living/basic/mining/brimdemon, MONKEYSTATION EDIT CHANGE OLD - We dont have basic mob brimdemons
		/mob/living/simple_animal/hostile/asteroid/brimdemon // MONKEYSTATION EDIT CHANGE NEW - We dont have basic mob brimdemons
		/mob/living/basic/mining/lobstrosity,
	)

/datum/modular_mob_segment/spiders
	mobs = list(
		/mob/living/basic/spider/giant/ambush,
		/mob/living/basic/spider/giant/hunter,
		/mob/living/basic/spider/giant/nurse,
		/mob/living/basic/spider/giant/tarantula,
		/mob/living/basic/spider/giant/midwife,
	)

/datum/modular_mob_segment/venus_trap
	mobs = list(
//		/mob/living/basic/venus_human_trap, MONKEYSTATION EDIT CHANGE OLD - We dont have basic mob venus traps
		/mob/living/simple_animal/hostile/venus_human_trap // MONKEYSTATION EDIT CHANGE NEW - We dont have basic mob venus traps
	)

/datum/modular_mob_segment/xenos
	mobs = list(
		/mob/living/simple_animal/hostile/alien,
		/mob/living/simple_animal/hostile/alien/sentinel,
		/mob/living/simple_animal/hostile/alien/drone,
	)

#undef SPAWN_ALWAYS
#undef SPAWN_LIKELY
#undef SPAWN_UNLIKELY
#undef SPAWN_RARE
