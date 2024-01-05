/datum/holoparasite_ability/major/healing
	name = "Healing"
	desc = "Allows the $theme to heal anything, living or inanimate, by touch."
	ui_icon = FA_ICON_MEDKIT
	cost = 3
	thresholds = list(
		list(
			"stat" = "Potential",
			"desc" = "Increases the amount of damage that is healed with each hit."
		),
		list(
			"stat" = "Defense",
			"minimum" = 3,
			"desc" = "Purges small amounts of toxic and overdosed reagents with each hit."
		),
		list(
			"stat" = "Potential",
			"minimum" = 3,
			"desc" = "Reduces the duration of temporary ailments such as blindness, blurry vision, deafness, disgust, dizziness, confusion, and hallucinations with each hit."
		),
		list(
			"stat" = "Potential",
			"minimum" = 5,
			"desc" = "Heals cellular damage with each hit, albeit at a lesser rate than normal damage."
		)
	)
	traits = list(TRAIT_MEDICAL_HUD)
	/// Heal clone damage when healing mobs.
	var/heal_clone = TRUE
	/// Heal temporary debuffs when healing mobs.
	var/heal_debuffs = TRUE
	/// Purge toxins when healing mobs.
	var/purge_toxins = TRUE
	/// The amount of damage to heal with each hit.
	var/heal_amt = 0
	/// The amount of effect time to reduce with each hit.
	var/effect_heal_amt = 0
	/// The amount of toxins to purge with each hit.
	var/purge_amt = 0

/datum/holoparasite_ability/major/healing/apply()
	..()
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	medsensor.show_to(owner)
	heal_clone = (master_stats.potential >= 5)
	heal_debuffs = (master_stats.potential >= 3)
	purge_toxins = (master_stats.defense >= 3)
	heal_amt = CEILING(max(master_stats.potential * 0.8, 2) + 3, 0.5)
	effect_heal_amt = CEILING(max(master_stats.potential * 0.85, 1), 1)
	purge_amt = CEILING((master_stats.potential + master_stats.defense) * 0.55 * REAGENTS_EFFECT_MULTIPLIER, 0.5)
	//owner.possible_a_intents = list(INTENT_HELP, INTENT_HARM)

/datum/holoparasite_ability/major/healing/remove()
	..()
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	medsensor.hide_from(owner)
	//owner.possible_a_intents = null

/datum/holoparasite_ability/major/healing/register_signals()
	..()
	RegisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_attack))

/datum/holoparasite_ability/major/healing/unregister_signals()
	..()
	UnregisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK)

/**
 * Handles healing a target whenever attacking them.
 */
/datum/holoparasite_ability/major/healing/proc/on_attack(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	if(!proximity || !LAZYACCESS(modifiers, RIGHT_CLICK) || CHECK_BITFIELD(owner.istate, ISTATE_HARM))
		return
	ASSERT_ABILITY_USABILITY
	if(owner.has_matching_summoner(target, include_summoner = FALSE))
		owner.balloon_alert(owner, "can't heal yourself!")
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(heal(target))
		owner.changeNext_move(CLICK_CD_MELEE)
		owner.do_attack_animation(target)
		spawn_heal_effect(target)
		playsound(owner, 'sound/magic/staff_healing.ogg', vol = 25, vary = TRUE, frequency = 2.5)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/**
 * Checks to see if the target is healable, and heals it if it is.
 * Returns TRUE if the target was healable, FALSE otherwise.
 */
/datum/holoparasite_ability/major/healing/proc/heal(atom/target)
	if(!istype(target))
		return FALSE
	if(isliving(target))
		heal_living(target)
		return TRUE
	else if(target.uses_integrity)
		heal_atom(target)
		return TRUE
	return FALSE

/**
 * Heals a living mob.
 */
/datum/holoparasite_ability/major/healing/proc/heal_living(mob/living/target)
	var/actual_heal_amt = heal_amt
	var/actual_effect_heal_amt = effect_heal_amt
	var/actual_purge_amt = purge_amt
	if(!owner.is_manifested())
		actual_heal_amt = CEILING(max(heal_amt * 0.5, 2), 0.5)
		actual_effect_heal_amt = CEILING(max(effect_heal_amt * 0.45, 1), 1)
		actual_purge_amt = CEILING(max(purge_amt * 0.5, 1), 0.5)
	else if(target.stat && !owner.has_matching_summoner(target))
		actual_heal_amt = CEILING(heal_amt * 1.25, 0.5)
		actual_effect_heal_amt = CEILING(heal_amt * 1.25, 1)
		actual_purge_amt = CEILING(purge_amt * 1.25, 0.5)
	target.heal_overall_damage(brute = actual_heal_amt, burn = actual_heal_amt, updating_health = FALSE)
	target.adjustOxyLoss(-actual_heal_amt, updating_health = FALSE)
	target.adjustToxLoss(-actual_heal_amt, updating_health = FALSE, forced = TRUE)

	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		if(!HAS_TRAIT(carbon_target, TRAIT_NOBLOOD))
			carbon_target.blood_volume = min(carbon_target.blood_volume + actual_heal_amt, HOLOPARA_MAX_BLOOD_VOLUME_HEAL)
			for(var/obj/item/bodypart/bodypart in carbon_target.bodyparts)
				bodypart.adjustBleedStacks(-actual_heal_amt)

	if(purge_toxins)
		var/list/reagents_purged = list()
		for(var/datum/reagent/reagent in target.reagents.reagent_list)
			var/remove = FALSE
			if(istype(reagent, /datum/reagent/toxin))
				var/datum/reagent/toxin/toxin_reagent = reagent
				// Don't remove toxins from toxin lovers.
				if(toxin_reagent.toxpwr > 0 && HAS_TRAIT(target, TRAIT_TOXINLOVER))
					continue
				remove = TRUE
			if(reagent.overdosed)
				remove = TRUE
			if(remove)
				reagents_purged |= "[reagent.type]"
				target.reagents.remove_reagent(reagent.type, actual_purge_amt)
	if(heal_clone)
		target.adjustCloneLoss(-max(CEILING(actual_heal_amt * 0.75, 0.5), 1), updating_health = FALSE)
	target.updatehealth()

/**
 * Heals an object.
 */
/datum/holoparasite_ability/major/healing/proc/heal_atom(atom/target)
	var/repair_amt = target.repair_damage(CEILING(target.max_integrity * 0.1, 5))
	if(repair_amt)
		SSblackbox.record_feedback("associative", "holoparasite_atom_damage_healed", 1, list(
			"target" = "[target.type]",
			"amount" = repair_amt
		))

/**
 * Spawns a visual effect for the heal at the location of the target.
 */
/datum/holoparasite_ability/major/healing/proc/spawn_heal_effect(atom/target)
	new /obj/effect/temp_visual/heal(get_turf(target), owner.accent_color)

/atom/movable/screen/act_intent/holopara_healer/MouseEntered(location, control, params)
	if(!QDELETED(src))
		openToolTip(usr, src, params, title = "Healing Intent", content = "<font color='green'><b>HELP</b></font> intent to heal.<br><font color='red'><b>HARM</b></font> intent to attack normally.")

/atom/movable/screen/act_intent/holopara_healer/MouseExited(location, control, params)
	closeToolTip(usr)
