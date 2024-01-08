/datum/action/cooldown/bloodling/infest
	name = "Infest"
	desc = "Allows you to infest a living creature, turning them into a thrall. Can be used on mindshielded people but it takes longer. Costs 75 biomass."
	button_icon_state = "alien_hide"
	biomass_cost = 75

/datum/action/cooldown/bloodling/infest/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("You ready yourself to infest a creature! <b>Click a target to begin infesting it!</b>"))

/datum/action/cooldown/bloodling/infest/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("You steady yourself. Now is not the time to infest..."))

/datum/action/cooldown/bloodling/infest/PreActivate(atom/target)
	if(!ismob(target))
		owner.balloon_alert(owner, "doesn't work on non-mobs!")
		return FALSE
	var/mob/living/alive_mob = target
	if(isnull(alive_mob.mind))
		owner.balloon_alert(owner, "doesn't work on mindless mobs!")
		return FALSE
	if(alive_mob.stat == DEAD)
		owner.balloon_alert(owner, "doesn't work on dead mobs!")
		return FALSE
	return ..()

/datum/action/cooldown/bloodling/infest/Activate(atom/target)
	var/mob/living/mob = target
	if(istype(mob, /mob/living/carbon/human))
		var/mob/living/carbon/human/carbon_mob = target
		if(HAS_TRAIT(carbon_mob, TRAIT_MINDSHIELD))
			if(!do_after(owner, 15 SECONDS))
				return FALSE
		else
			if(!do_after(owner, 10 SECONDS))
				return FALSE
		var/datum/antagonist/changeling/bloodling_thrall/thrall = carbon_mob.mind.add_antag_datum(/datum/antagonist/changeling/bloodling_thrall)
		thrall.set_master(owner)
	else
		if(!do_after(owner, 5 SECONDS))
			return FALSE
		var/datum/antagonist/infested_thrall/thrall = mob.mind.add_antag_datum(/datum/antagonist/infested_thrall)
		thrall.set_master(owner)
	return TRUE
