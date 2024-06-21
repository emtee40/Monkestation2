/datum/action/cooldown/mob_cooldown/bloodling/infest
	name = "Infest"
	desc = "Allows you to infest a living creature, turning them into a thrall. Can be used on mindshielded people but it takes longer. Costs 75 biomass."
	button_icon_state = "alien_hide"
	biomass_cost = 75

/datum/action/cooldown/mob_cooldown/bloodling/infest/PreActivate(atom/target)
	if(!ismob(target))
		owner.balloon_alert(owner, "doesn't work on non-mobs!")
		return FALSE

	var/mob/living/alive_mob = target
	if(isnull(alive_mob.mind))
		owner.balloon_alert(owner, "doesn't work on mindless mobs!")
		return FALSE

	if(IS_BLOODLING_OR_THRALL(alive_mob))
		return FALSE

	if(alive_mob.stat == DEAD)
		owner.balloon_alert(owner, "doesn't work on dead mobs!")
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/bloodling/infest/Activate(atom/target)
	var/mob/living/mob = target
	var/infest_time = 30 SECONDS

	// If they are standing on the ascended bloodling tiles it takes 1/3rd of the time to infest them
	if(isturf(get_turf(mob), /turf/open/misc/bloodling))
		infest_time = 10 SECONDS

	if(iscarbon(mob))
		var/mob/living/carbon/human/carbon_mob = target
		infest_time *= 2

		if(HAS_TRAIT(carbon_mob, TRAIT_MINDSHIELD))
			infest_time *= 4

		if(!do_after(owner, infest_time))
			return FALSE
		var/datum/antagonist/changeling/bloodling_thrall/thrall = carbon_mob.mind.add_antag_datum(/datum/antagonist/changeling/bloodling_thrall)
		thrall.set_master(owner)
	else
		if(!do_after(owner, infest_time))
			return FALSE
		var/datum/antagonist/infested_thrall/thrall = mob.mind.add_antag_datum(/datum/antagonist/infested_thrall)
		thrall.set_master(owner)
	return TRUE
