/client
	var/ghost_critter_cooldown = 0


/client/proc/get_critter_spawn(obj/structure/ghost_critter_spawn/spawner)
	var/list/basic_list = list(
		/mob/living/basic/mouse,
		/mob/living/basic/axolotl,
		/mob/living/basic/butterfly,
		/mob/living/basic/crab
	)
	if(!patreon.has_access(ACCESS_ASSISTANT_RANK))
		return pick(basic_list)

	var/list/mobs_to_pick = list()

	if(patreon.has_access(ACCESS_ASSISTANT_RANK))
		mobs_to_pick += basic_list

	var/choice = show_radial_menu(mob, spawner, mobs_to_pick, tooltips = TRUE)
	if(!choice)
		return pick(basic_list)
	return choice

/client/proc/try_critter_spawn(obj/structure/ghost_critter_spawn/spawner)
	var/turf/open/turf = get_turf(spawner)

	var/mob/living/basic/spawned_mob = get_critter_spawn(spawner)
	var/mob/living/basic/created_mob = new spawned_mob(turf)

	ghost_critter_cooldown = world.time + 15 MINUTES

	if(!mob.mind)
		mob.mind = new /datum/mind(key)

	mob.mind.transfer_to(created_mob, TRUE)
	ADD_TRAIT(created_mob, TRAIT_MUTE, INNATE_TRAIT)

	init_verbs()
