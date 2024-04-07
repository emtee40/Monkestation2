/datum/status_effect/rust_heal
	id = "Leeching Walk"
	alert_type = /atom/movable/screen/alert/status_effect/rust_heal
	/// How much total damage to heal per tick.
	var/total_split_healing = 5
	/// How much total immobility to heal per tick.
	var/immobility_healing = 0.75 SECONDS
	/// How much blood to regenerate per tick.
	var/blood_regen = 1.5
	/// How many fire stacks to remove per tick.
	var/fire_extinguish_rate = 1
	/// How many units of losebreath to regenerate per tick.
	var/losebreath_regen_rate = 0.5
	/// Traits to grant to the owner while active, regardless of their path.
	var/list/traits_to_give_all = list(
		TRAIT_BATON_RESISTANCE,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOFLASH,
		TRAIT_NOLIMBDISABLE
	)
	/// Traits to exclusively give to rust path heretics while active.
	var/list/traits_to_give_rust = list(
		TRAIT_IGNOREDAMAGESLOWDOWN,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NO_SLIP_WATER,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADSTORM_IMMUNE,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER
	)

/datum/status_effect/rust_heal/on_apply()
	. = ..()
	if(!rusty_check())
		return
	apply_rust_path_bonuses()
	owner.add_traits(traits_to_give_all, id)

/datum/status_effect/rust_heal/on_remove()
	. = ..()
	remove_physiology_buff()
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/rust_heal)
	REMOVE_TRAITS_IN(owner, id)

/datum/status_effect/rust_heal/tick(seconds_per_tick, times_fired)
	if(!rusty_check())
		return
	if(isoozeling(owner) && owner.nutrition <= NUTRITION_LEVEL_HUNGRY)
		owner.adjust_nutrition(blood_regen * 2 * seconds_per_tick)
	heal_damage(seconds_per_tick)
	mend_bleeding(seconds_per_tick)

/datum/status_effect/rust_heal/proc/grant_physiology_buff()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || QDELETED(human_owner.physiology) || HAS_TRAIT(owner, TRAIT_RUST_PHYSIOLOGY_BUFF))
		return
	human_owner.physiology.brute_mod *= 0.8
	human_owner.physiology.burn_mod *= 0.8
	human_owner.physiology.oxy_mod *= 0.8
	human_owner.physiology.stamina_mod *= 0.8
	human_owner.physiology.pressure_mod *= 0.3
	human_owner.physiology.heat_mod *= 0.3
	human_owner.physiology.cold_mod *= 0.3
	human_owner.physiology.siemens_coeff *= 0.3
	human_owner.physiology.stun_mod *= 0.5
	human_owner.physiology.bleed_mod *= 0.25
	human_owner.physiology.hunger_mod *= 0.25
	ADD_TRAIT(human_owner, TRAIT_RUST_PHYSIOLOGY_BUFF, id)

/datum/status_effect/rust_heal/proc/remove_physiology_buff()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || QDELETED(human_owner.physiology) || !HAS_TRAIT_FROM(owner, TRAIT_RUST_PHYSIOLOGY_BUFF, id))
		return
	human_owner.physiology.brute_mod /= 0.8
	human_owner.physiology.burn_mod /= 0.8
	human_owner.physiology.oxy_mod /= 0.8
	human_owner.physiology.stamina_mod /= 0.8
	human_owner.physiology.pressure_mod /= 0.3
	human_owner.physiology.heat_mod /= 0.3
	human_owner.physiology.cold_mod /= 0.3
	human_owner.physiology.siemens_coeff /= 0.3
	human_owner.physiology.stun_mod /= 0.5
	human_owner.physiology.bleed_mod /= 0.25
	human_owner.physiology.hunger_mod /= 0.25
	REMOVE_TRAIT(human_owner, TRAIT_RUST_PHYSIOLOGY_BUFF, id)

/datum/status_effect/rust_heal/proc/apply_rust_path_bonuses()
	var/datum/antagonist/heretic/heretic = IS_HERETIC(owner)
	if(heretic?.heretic_path != PATH_RUST)
		return
	total_split_healing = 8
	immobility_healing = 1.2 SECONDS
	blood_regen = 2.5
	fire_extinguish_rate = 2
	losebreath_regen_rate = 1
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/rust_heal)
	owner.add_traits(traits_to_give_rust, id)
	grant_physiology_buff()

/*
 * Heals the owner's damage + stamina.
 * The less different types of damage you have, the more you heal per type.
 */
/datum/status_effect/rust_heal/proc/heal_damage(seconds_per_tick)
	owner.adjust_fire_stacks(-round(fire_extinguish_rate * seconds_per_tick))
	owner.losebreath = max(owner.losebreath - losebreath_regen_rate * seconds_per_tick, 0)
	var/types_to_heal = (owner.getBruteLoss() > 0) + (owner.getFireLoss() > 0) + (owner.getToxLoss() > 0) + (owner.getOxyLoss() > 0) + (owner.getCloneLoss() > 0) + (owner.stamina.loss > 0)
	if(types_to_heal > 0)
		var/amt_to_heal = (total_split_healing / types_to_heal) * seconds_per_tick
		if(owner.has_status_effect(/datum/status_effect/determined))
			amt_to_heal *= 1.25
		amt_to_heal = CEILING(amt_to_heal, 0.5)
		owner.heal_overall_damage(brute = amt_to_heal, burn = amt_to_heal, updating_health = FALSE)
		owner.stamina.adjust(amt_to_heal, forced = TRUE)
		owner.adjustToxLoss(-amt_to_heal, updating_health = FALSE, forced = TRUE)
		owner.adjustOxyLoss(-amt_to_heal, updating_health = FALSE)
		owner.adjustCloneLoss(-amt_to_heal, updating_health = FALSE)
	owner.AdjustAllImmobility(-immobility_healing * seconds_per_tick)
	owner.updatehealth()

/*
 * Slow and stop any blood loss the owner's experiencing.
 */
/datum/status_effect/rust_heal/proc/mend_bleeding(seconds_per_tick)
	if(!iscarbon(owner) || !owner.blood_volume || HAS_TRAIT(owner, TRAIT_NOBLOOD))
		return
	var/mob/living/carbon/carbon_owner = owner
	var/datum/wound/bloodiest_wound
	for(var/datum/wound/iter_wound as anything in carbon_owner.all_wounds)
		if(iter_wound.blood_flow && (iter_wound.blood_flow > bloodiest_wound?.blood_flow))
			bloodiest_wound = iter_wound
	bloodiest_wound?.adjust_blood_flow(-blood_regen * seconds_per_tick)
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume += blood_regen * seconds_per_tick

/*
 * Check if the owner is standing on a rusty turf,
 * removing the status effect if they're not.
 */
/datum/status_effect/rust_heal/proc/rusty_check()
	var/turf/our_turf = get_turf(owner)
	if(QDELETED(our_turf) || !HAS_TRAIT(our_turf, TRAIT_RUSTY))
		qdel(src)
		return FALSE
	return TRUE

/atom/movable/screen/alert/status_effect/rust_heal
	name = "Leeching Walk"
	desc = "The rusted ground you walk on empowers you, making you far more resilient."
	icon_state = "regenerative_core"

/datum/actionspeed_modifier/rust_heal
	multiplicative_slowdown = -0.3
	id = ACTIONSPEED_ID_RUST_HEALING
