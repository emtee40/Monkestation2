/datum/action/cooldown/mob_cooldown/bloodling/give_life
	name = "Give Life"
	desc = "Bestow the gift of life onto the ignorant."
	button_icon_state = "alien_hide"

/datum/action/cooldown/mob_cooldown/bloodling/give_life/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return
	to_chat(on_who, span_noticealien("You prepare to bestow a life. <b>Click a target to grant them the gift!</b>"))

/datum/action/cooldown/mob_cooldown/bloodling/give_life/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("They do not deserve it... Yet..."))

/datum/action/cooldown/mob_cooldown/bloodling/give_life/PreActivate(atom/target)
	if(!ismob(target))
		owner.balloon_alert(owner, "only works on mobs!")
		return FALSE
	var/mob/living/mob_target = target
	if(mob_target.ckey && !mob_target.stat == CONSCIOUS)
		owner.balloon_alert(owner, "only works on non-sentient conscious mobs!")
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/bloodling/give_life/Activate(atom/target)
	var/mob/living/target_mob = target

	var/question = "Would you like to be a [target_mob] servant of [owner]?"
	var/list/candidates = poll_candidates_for_mobs(question, ROLE_SENTIENCE, ROLE_SENTIENCE, 10 SECONDS, target_mob, POLL_IGNORE_SHUTTLE_DENIZENS)
	if(!LAZYLEN(candidates) && !LAZYLEN(target_mob))
		return FALSE
	var/mob/dead/observer/C = pick_n_take(candidates)
	message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(target_mob)])")
	target_mob.ghostize(FALSE)
	target_mob.key = C.key
	return TRUE

