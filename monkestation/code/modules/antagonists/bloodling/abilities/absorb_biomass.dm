/datum/action/cooldown/bloodling/absorb
	name = "Absorb Biomass"
	desc = "Allows you to absorb a dead creature close to you."
	button_icon_state = "alien_hide"

/datum/action/cooldown/bloodling/absorb/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return
	to_chat(on_who, span_noticealien("You prepare to claim a creatures biomass. <b>Click a target to begin absorbing it!</b>"))

/datum/action/cooldown/bloodling/absorb/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("You steady yourself. Now is not the time to claim biomass..."))

/datum/action/cooldown/bloodling/absorb/PreActivate(atom/target)
	if(get_dist(owner, target) > 1)
		return FALSE
	if(istype(target, /obj/item/food/deadmouse))
		return ..()
	if(!ismob(target))
		owner.balloon_alert(owner, "doesn't work on non-mobs!")
		return FALSE
	var/mob/living/mob_to_absorb = target
	if(!mob_to_absorb.stat == DEAD)
		owner.balloon_alert(owner, "only works on dead mobs!")
		return FALSE
	return ..()

/datum/action/cooldown/bloodling/absorb/Activate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner

	if(istype(target, /obj/item/food/deadmouse))
		if(!do_after(our_mob, 5 SECONDS))
			return FALSE
		our_mob.add_biomass(10)
		qdel(target)
		our_mob.visible_message(
		span_alertalien("[our_mob] wraps its tendrils around [target]. It absorbs it!"),
		span_noticealien("You wrap your tendrils around [target] and absorb it!"),
		)
		return TRUE
	var/mob/living/mob_to_absorb = target
	if(!do_after(our_mob, 10 SECONDS))
		return FALSE
	our_mob.add_biomass(mob_to_absorb.getMaxHealth() * 0.5)
	mob_to_absorb.gib()

	our_mob.visible_message(
		span_alertalien("[our_mob] wraps its tendrils around [target]. It absorbs it!"),
		span_noticealien("You wrap your tendrils around [target] and absorb it!"),
	)
	return TRUE
