/datum/action/cooldown/bloodling/absorb
	name = "Hide"
	desc = "Allows you to hide beneath tables and certain objects."
	button_icon_state = "alien_hide"
	/// If we are currently absorbing
	var/absorbing = FALSE

/datum/action/cooldown/bloodling/absorb/Activate(atom/target)
	for(var/mob/dead_mob in view(owner, 1))
		if(!dead_mob.stat == DEAD)
			continue
		dead_mob.gib()
		if(dead_mob)
