/mob/living/basic/var/list/ckeywhitelist = list()

/client/proc/return_donator_mobs()
	var/list/mobs = list(
		/mob/living/basic/pet/gumball_goblin,
	)

	if(is_admin(src))
		return mobs
	var/list/valid_mobs = list()

	for(var/mob/living/basic/mob as anything in mobs)
		if(ckey in initial(mob.ckeywhitelist))
			valid_mobs |= mob
	return valid_mobs
