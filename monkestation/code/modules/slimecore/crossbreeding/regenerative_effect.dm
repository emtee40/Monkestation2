GLOBAL_LIST_EMPTY(regen_extract_factor)

/datum/status_effect/regenerative_extract
	id = "Slime Regeneration"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 15 SECONDS
	tick_interval = 0.5 SECONDS
	alert_type = null
	var/base_healing_amt = 2
	var/multiplier = 1
	var/diminishing_multiplier = 0.75
	var/diminish_time = 45 SECONDS
	var/nutrition_heal_cap = NUTRITION_LEVEL_FED - 50
	var/list/given_traits = list(TRAIT_NOCRITDAMAGE)

/datum/status_effect/regenerative_extract/on_apply()
	multiplier *= regen_multiplier(owner)
	owner.add_traits(given_traits, id)
	return ..()

/datum/status_effect/regenerative_extract/on_remove()
	owner.remove_traits(given_traits, id)
	start_regen_cooldown(owner, diminishing_multiplier, diminish_time)

/datum/status_effect/regenerative_extract/tick(seconds_per_tick, times_fired)
	var/heal_amt = base_healing_amt * multiplier * seconds_per_tick
	heal_act(heal_amt)
	owner.updatehealth()

/datum/status_effect/regenerative_extract/proc/heal_act(heal_amt = 0)
	owner.heal_overall_damage(brute = heal_amt, burn = heal_amt, updating_health = FALSE)
	owner.stamina?.adjust(-heal_amt, forced = TRUE)
	owner.adjustOxyLoss(-heal_amt, updating_health = FALSE)
	owner.adjustToxLoss(-heal_amt, updating_health = FALSE, forced = TRUE)
	owner.adjustCloneLoss(-heal_amt, updating_health = FALSE)
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume = min(owner.blood_volume + heal_amt, BLOOD_VOLUME_NORMAL)
	if((owner.nutrition < nutrition_heal_cap) && !HAS_TRAIT(owner, TRAIT_NOHUNGER))
		owner.nutrition = min(owner.nutrition + heal_amt, nutrition_heal_cap)
	if(iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		for(var/obj/item/organ/organ in carbon_owner.organs)
			organ.apply_organ_damage(-heal_amt)

/datum/status_effect/regenerative_extract/get_examine_text()
	return "[owner.p_They()] have a subtle, gentle glow to [owner.p_their()] skin, with slime soothing [owner.p_their()] wounds."

/datum/status_effect/regenerative_extract/purple
	base_healing_amt = 4
	diminishing_multiplier = 0.5
	diminish_time = 1.5 MINUTES
	given_traits = list(TRAIT_NOCRITDAMAGE, TRAIT_NOCRITOVERLAY, TRAIT_NOSOFTCRIT)

/datum/status_effect/regenerative_extract/silver
	base_healing_amt = 1.5
	nutrition_heal_cap = NUTRITION_LEVEL_WELL_FED + 50
	diminishing_multiplier = 0.8
	diminish_time = 30 SECONDS
	given_traits = list(TRAIT_NOCRITDAMAGE, TRAIT_NOCRITOVERLAY, TRAIT_NOFAT)

/proc/regen_multiplier(mob/living/target)
	. = 1
	if(!istype(target) || QDELING(target))
		return
	var/datum/weakref/target_ref = WEAKREF(target)
	if(isnull(GLOB.regen_extract_factor[target_ref]))
		GLOB.regen_extract_factor[target_ref] = 1
	return GLOB.regen_extract_factor[target_ref]

/proc/start_regen_cooldown(mob/living/target, amt = 1, time = 45 SECONDS)
	if(!istype(target) || QDELING(target))
		return
	var/datum/weakref/target_ref = WEAKREF(target)
	if(isnull(GLOB.regen_extract_factor[target_ref]))
		GLOB.regen_extract_factor[target_ref] = 1
	GLOB.regen_extract_factor[target_ref] *= amt
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(finish_regen_cooldown), target_ref, amt), time)

/proc/finish_regen_cooldown(datum/weakref/target_ref, amt = 1)
	if(!target_ref?.resolve())
		GLOB.regen_extract_factor -= target_ref
		return
	if(isnull(GLOB.regen_extract_factor[target_ref]))
		GLOB.regen_extract_factor[target_ref] = 1
		return
	GLOB.regen_extract_factor[target_ref] /= amt
