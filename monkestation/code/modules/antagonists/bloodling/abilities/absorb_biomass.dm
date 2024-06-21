/datum/action/cooldown/mob_cooldown/bloodling/absorb
	name = "Absorb Biomass"
	desc = "Allows you to absorb a dead carbon or living mob close to you."
	button_icon_state = "absorb"

/datum/action/cooldown/mob_cooldown/bloodling/absorb/PreActivate(atom/target)
	if(owner == target)
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
	. = ..()
	var/mob/living/basic/bloodling/our_mob = owner
	/// How long it takes to absorb something
	var/absorb_time = 5 SECONDS
	/// How much biomass is gained from absorbing something
	var/biomass_gain = 10

	our_mob.balloon_alert(our_mob, "You begin absorbing [target]!")

	// This prevents the mob from being dragged away from the bloodling during the process
	target.AddComponentFrom(REF(src), /datum/component/leash, our_mob, 1)

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
		biomass_gain = max(mob_to_absorb.getMaxHealth() * 0.5, biomass_gain)
		if(biomass_gain > 150)
			our_mob.balloon_alert(our_mob, "[target] is too large!")
			return FALSE

		if(biomass_gain < 10)
			biomass_gain = 10
	else
		var/mob/living/carbon/carbon_to_absorb = target
		if(issimian(carbon_to_absorb))
			biomass_gain = 50
		else
			biomass_gain = 100
			absorb_time = 10 SECONDS

	if(!do_after(owner, absorb_time, mob_to_absorb))
		mob_to_absorb.RemoveComponentSource(REF(src), /datum/component/leash)
		return FALSE

	our_mob.add_biomass(biomass_gain)
	mob_to_absorb.gib()
	our_mob.visible_message(
		span_alertalien("[our_mob] wraps its tendrils around [target]. It absorbs it!"),
		span_noticealien("You wrap your tendrils around [target] and absorb it!"),
	)
	return TRUE
