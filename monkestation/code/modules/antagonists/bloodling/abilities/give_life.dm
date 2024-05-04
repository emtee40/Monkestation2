/datum/action/cooldown/mob_cooldown/bloodling/give_life
	name = "Give Life"
	desc = "Bestow the gift of life onto the ignorant."
	button_icon_state = "alien_hide"

/datum/action/cooldown/mob_cooldown/bloodling/give_life/PreActivate(atom/target)
	if(!ismob(target))
		owner.balloon_alert(owner, "only works on mobs!")
		return FALSE

	var/mob/living/mob_target = target
	if(mob_target.mind && !mob_target.stat == DEAD)
		owner.balloon_alert(owner, "only works on non-sentient alive mobs!")
		return FALSE

	if(iscarbon(mob_target))
		owner.balloon_alert(owner, "doesn't work on carbons!")
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/bloodling/give_life/Activate(atom/target)
	var/mob/living/target_mob = target

	var/question = "Would you like to be a [target_mob] servant of [owner]?"
	var/list/candidates = SSpolling.poll_ghost_candidates_for_mob(
		question,
		ROLE_SENTIENCE,
		ROLE_SENTIENCE,
		10 SECONDS,
		target_mob,
		POLL_IGNORE_SHUTTLE_DENIZENS,
		pic_source = target_mob
	)
	if(!LAZYLEN(candidates))
		owner.balloon_alert(owner, "[target_mob] rejects your generous gift...for now...")
		return FALSE
	var/mob/dead/observer/candie = pick_n_take(candidates)
	message_admins("[key_name_admin(candie)] has taken control of ([key_name_admin(target_mob)])")
	target_mob.ghostize(FALSE)
	target_mob.key = candie.key
	target_mob.mind.add_antag_datum(/datum/antagonist/changeling/bloodling_thrall)
	return TRUE

