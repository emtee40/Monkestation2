/mob/living/basic/holoparasite
	/// The cooldown for whenever to do the visible 'recoil' to the summoner from a holoparasite taking damage.
	COOLDOWN_DECLARE(recoil_cooldown)

/**
 * Handles brute damage for the holoparasite, transferring it to the summoner.
 */
/mob/living/basic/holoparasite/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(QDELETED(summoner?.current))
		return ..()
	// No, you can't heal the holopara.
	if(!forced && amount <= 0)
		return
	// Spread damage across different bodyparts.
	summoner.current.take_overall_damage(brute = amount)
	extra_host_damage(amount * 0.5)
	if(COOLDOWN_FINISHED(src, recoil_cooldown) && prob(70))
		var/holoparasite_visible = isturf(summoner.current.loc) && isturf(loc) && (src in viewers(world.view, summoner.current))
		if(iscarbon(summoner.current))
			var/mob/living/carbon/carbon_summoner = summoner.current
			carbon_summoner.vomit(lost_nutrition = 0, blood = TRUE, stun = FALSE, distance = HOLOPARA_CALC_BLOOD_RECOIL_DISTANCE(amount), message = FALSE, harm = FALSE)
		else
			summoner.current.add_splatter_floor()
		recoil_scream()
		to_chat(summoner.current, span_bolddanger("You painfully cough up blood as [color_name] takes damage"))
		summoner.current.visible_message(span_warning("[summoner.current] painfully coughs up blood[holoparasite_visible ? " as [color_name] takes damage" : ""]!"), vision_distance = HOLOPARA_SUMMONER_DAMAGE_VISION_RANGE)
		COOLDOWN_START(src, recoil_cooldown, HOLOPARA_VISIBLE_RECOIL_COOLDOWN)
	update_health_hud()

/**
 * Handles burn damage for the holoparasite, transferring it to the summoner.
 */
/mob/living/basic/holoparasite/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(QDELETED(summoner?.current))
		return ..()
	// No, you can't heal the holopara.
	if(!forced && amount <= 0)
		return
	summoner.current.take_overall_damage(burn = amount)
	extra_host_damage(amount * 0.5)
	if(COOLDOWN_FINISHED(src, recoil_cooldown) && prob(70))
		var/holoparasite_visible = isturf(summoner.current.loc) && isturf(loc) && (src in get_hearers_in_view(7, summoner.current))
		recoil_scream()
		to_chat(summoner.current, span_bolddanger("Your body burns [color_name] takes damage!</span>"))
		summoner.current.visible_message(span_warning("[summoner.current] cringes with pain, burns and blisters taking form on [summoner.current.p_their()] skin[holoparasite_visible ? " as [color_name] takes damage" : ""]!"), vision_distance = HOLOPARA_SUMMONER_DAMAGE_VISION_RANGE)
		COOLDOWN_START(src, recoil_cooldown, HOLOPARA_VISIBLE_RECOIL_COOLDOWN)
	update_health_hud()

/mob/living/basic/holoparasite/can_adjust_clone_loss(amount, forced, required_biotype)
	return FALSE

/mob/living/basic/holoparasite/can_adjust_oxy_loss(amount, forced, required_biotype, required_respiration_type)
	return FALSE

/mob/living/basic/holoparasite/can_adjust_tox_loss(amount, forced, required_biotype)
	return FALSE

/**
 * Handles the random chance for the summoner to scream when taking recoil damage.
 */
/mob/living/basic/holoparasite/proc/recoil_scream()
	if(summoner.current.stat == CONSCIOUS && prob(HOLOPARA_RECOIL_SCREAM_PROB))
		summoner.current.emote("scream")

/**
 * Deal extra brain damage to the host (or clone damage, if they don't have a real brain), whenever they're in crit or unconscious.
 *
 * Arguments
 * * amount: How much damage to deal (in either brain damage, or clone damage if they lack a brain).
 */
/mob/living/basic/holoparasite/proc/extra_host_damage(amount)
	// NOTE: checking unconscious and not sleeping here is intentional! ~Lucy
	if(QDELETED(summoner?.current) || !(summoner.current.IsUnconscious() || HAS_TRAIT(summoner, TRAIT_CRITICAL_CONDITION)))
		return
	// No brain? Ah whatever, just deal clone damage.
	var/obj/item/organ/internal/brain/brain = summoner.current.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!brain || brain.decoy_override)
		to_chat(summoner.current, span_bolddanger("You feel your body strain as [color_name] takes damage!"))
		summoner.current.adjustCloneLoss(amount)
		return
	to_chat(summoner.current, span_bolddanger("You feel your mind strain as [color_name] takes damage!"))
	brain.apply_organ_damage(amount, HOLOPARA_MAX_BRAIN_DAMAGE)

/**
 * A holoparasite does not sense through traditional methods, therefore it is immune to being flashed.
 */
/mob/living/basic/holoparasite/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 2.5 SECONDS)
	return FALSE

/**
 * A holoparasite does not sense through traditional methods, therefore it is immune to being banged.
 */
/mob/living/basic/holoparasite/soundbang_act()
	return FALSE

/**
 * A holoparasite's crystalline structure is unaffected by fire.
 */
/mob/living/basic/holoparasite/fire_act()
	return FALSE

/**
 * A holoparasite's crystalline structure is unaffected by radiation.
 */
/mob/living/basic/holoparasite/rad_act(amount)
	return FALSE

/**
 * An un-manifested holoparasite will be immune to EMPs, i.e in the case of a dextrous holoparasite.
 */
/mob/living/basic/holoparasite/emp_act(severity)
	if(incorporeal_move || !is_manifested())
		return EMP_PROTECT_SELF | EMP_PROTECT_CONTENTS
	return ..()

/**
 * Nar'Sie is the summoner's problem to deal with. Not the holoparasite's.
 */
/mob/living/basic/holoparasite/narsie_act()
	return FALSE

/**
 * Ratvar is the summoner's problem to deal with. Not the holoparasite's.
 */
/mob/living/basic/holoparasite/ratvar_act()
	return FALSE

/**
 * Holoparasites are NOT physically soft like flesh.
 */
/mob/living/basic/holoparasite/can_inject(mob/user, error_msg, target_zone, penetrate_thick = FALSE)
	return FALSE

/mob/living/basic/holoparasite/ex_act(severity, target)
	if(incorporeal_move || !is_manifested())
		return
	if(QDELETED(summoner?.current))
		return ..()
	switch(severity)
		if(EXPLODE_DEVASTATE)
			if(stats.defense >= 5)
				// With max defense, you can BARELY survive this around full health, but it will hurt HORRIBLY.
				if(iscarbon(summoner.current))
					var/mob/living/carbon/carbon_summoner = summoner.current
					carbon_summoner.vomit(lost_nutrition = 0, blood = TRUE, stun = FALSE, distance = 5, message = FALSE)
					carbon_summoner.take_overall_damage(brute = carbon_summoner.maxHealth * 1.1, stamina = summoner.current.maxHealth * 1.5)
				else
					summoner.current.add_splatter_floor()
					summoner.current.take_overall_damage(brute = summoner.current.maxHealth * 0.9, stamina = summoner.current.maxHealth * 1.5)
				to_chat(summoner.current, span_userdanger("You violently cough up blood, barely surviving as an explosion nearly tears apart [color_name], causing you to collapse in incredible, agonizing pain!"))
				summoner.current.visible_message(span_warning("[summoner.current] violently coughs up blood, collapsing to the ground in incredible pain!"))
				summoner.current.AdjustParalyzed(45 SECONDS, ignore_canstun = TRUE)
				//summoner.current.jitteriness = min(summoner.current.jitteriness + 180, 180)
				SSblackbox.record_feedback("tally", "holoparasite_exploded", 1, "devastate (survived)")
			else
				// RIP.
				var/list/possible_splatter_tiles = list()
				for(var/turf/open/open_turf in view(1, summoner.current))
					possible_splatter_tiles += open_turf
				for(var/i = 1 to rand(3, 5))
					if(length(possible_splatter_tiles))
						summoner.current.add_splatter_floor(pick(possible_splatter_tiles))
					if(iscarbon(summoner.current))
						var/mob/living/carbon/carbon_summoner = summoner.current
						carbon_summoner.vomit(lost_nutrition = 0, blood = TRUE, stun = FALSE, distance = 5, message = FALSE)
				summoner.current.visible_message(span_danger("[summoner.current] violently coughs up an incredible amount of blood, collapsing to the ground, seemingly dead."))
				SSblackbox.record_feedback("tally", "holoparasite_exploded", 1, "devastate (gibbed)")
				gib()
		if(EXPLODE_HEAVY)
			summoner.current.take_overall_damage(brute = summoner.current.maxHealth * 0.6, stamina = summoner.current.maxHealth * 0.6)
			//summoner.current.jitteriness = min(summoner.current.jitteriness + 90, 90)
			SSblackbox.record_feedback("tally", "holoparasite_exploded", 1, "heavy")
		if(EXPLODE_LIGHT)
			summoner.current.take_overall_damage(brute = summoner.current.maxHealth * 0.3, stamina = summoner.current.maxHealth * 0.45)
			//summoner.current.jitteriness = min(summoner.current.jitteriness + 45, 45)
			SSblackbox.record_feedback("tally", "holoparasite_exploded", 1, "light")

/mob/living/basic/holoparasite/gib()
	if(!QDELETED(summoner?.current))
		to_chat(summoner.current, span_userdanger("Your [color_name] was blown up!"))
		parent_holder.death_of_the_author(summoner.current)
