/datum/action/cooldown/mob_cooldown/bloodling/absorb
	name = "Absorb Biomass"
	desc = "Allows you to absorb a dead carbon or living mob close to you."
	button_icon_state = "alien_hide"

/datum/action/cooldown/mob_cooldown/bloodling/absorb/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return
	to_chat(on_who, span_noticealien("You prepare to claim a creatures biomass. <b>Click a target to begin absorbing it!</b>"))

/datum/action/cooldown/mob_cooldown/bloodling/absorb/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("You steady yourself. Now is not the time to claim biomass..."))

/datum/action/cooldown/mob_cooldown/bloodling/absorb/PreActivate(atom/target)
	if(owner == target)
		return FALSE
	if(get_dist(owner, target) > 1)
		return FALSE
	if(istype(target, /obj/item/food/deadmouse))
		return ..()
	if(!ismob(target))
		owner.balloon_alert(owner, "doesn't work on non-mobs!")
		return FALSE
	var/mob/living/mob_to_absorb = target
	if(!iscarbon(mob_to_absorb))
		return ..()
	var/mob/living/carbon/carbon_to_absorb = target
	if(!carbon_to_absorb.stat == DEAD)
		owner.balloon_alert(owner, "only works on dead carbons!")
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/bloodling/absorb/Activate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	var/absorb_time = 5 SECONDS
	var/biomass_gain = 10

	if(istype(target, /obj/item/food/deadmouse))
		our_mob.add_biomass(biomass_gain)
		qdel(target)
		our_mob.visible_message(
		span_alertalien("[our_mob] wraps its tendrils around [target]. It absorbs it!"),
		span_noticealien("You wrap your tendrils around [target] and absorb it!"),
		)
		return TRUE

	var/mob/living/mob_to_absorb = target
	if(!iscarbon(mob_to_absorb))
		biomass_gain = mob_to_absorb.getMaxHealth() * 0.5
	else
		var/mob/living/carbon/carbon_to_absorb = target
		if(issimian(carbon_to_absorb))
			biomass_gain = 50
		else
			biomass_gain = 100
			absorb_time = 10 SECONDS

	mob_to_absorb.AddComponent(/datum/component/leash, our_mob, 1)
	if(!do_after(mob_to_absorb, absorb_time))
		return FALSE
	mob_to_absorb.gib()
	our_mob.visible_message(
		span_alertalien("[our_mob] wraps its tendrils around [target]. It absorbs it!"),
		span_noticealien("You wrap your tendrils around [target] and absorb it!"),
	)
	return TRUE
