/datum/action/cooldown/bloodling/absorb
	name = "Absorb Biomass"
	desc = "Allows you to hide beneath tables and certain objects."
	button_icon_state = "alien_hide"

/datum/action/cooldown/bloodling/absorb/Activate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	for(var/atom/atom in view(owner, 1))
		if(istype(atom, /obj/item/food/deadmouse))
			if(!do_after(owner, 5 SECONDS))
				break
			our_mob.add_biomass(10)
			qdel(atom)
			break
		var/mob/living/dead_mob = atom
		if(!dead_mob.stat == DEAD)
			continue
		if(!do_after(owner, 10 SECONDS))
			break
		dead_mob.gib()
		our_mob.add_biomass(dead_mob.getMaxHealth() * 0.5)
		break

/datum/action/cooldown/bloodling/absorb
	name = "Absorb Biomass"
	desc = "Allows you to hide beneath tables and certain objects."
	button_icon_state = "alien_hide"

/datum/action/cooldown/bloodling/absorb/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_changeling("You prepare to claim a creatures biomass. <b>Click a target to begin absorbing it!</b>"))

/datum/action/cooldown/bloodling/absorb/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_changeling("You steady yourself. Now is not the time to claim biomass..."))

/datum/action/cooldown/bloodling/absorb/PreActivate(atom/target)
	if(get_dist(owner, target) > 1)
		return FALSE
	if(!ismob(target) || istype(target, /obj/item/food/deadmouse)) // We love deadmouse being food
		owner.balloon_alert(owner, "doesn't work on non-mobs!")
		return FALSE

	return ..()

/datum/action/cooldown/bloodling/absorb/Activate(atom/target)
	if(!target.acid_act(200, 1000))
		to_chat(owner, span_noticealien("You cannot dissolve this object."))
		return FALSE

	owner.visible_message(
		span_alertalien("[owner] vomits globs of vile stuff all over [target]. It begins to sizzle and melt under the bubbling mess of acid!"),
		span_noticealien("You vomit globs of acid over [target]. It begins to sizzle and melt."),
	)
	return TRUE
