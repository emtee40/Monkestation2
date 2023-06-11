/// Deals extra damage to mobs of a certain type, species, or biotype.
/// This doesn't directly modify the normal damage of the weapon, instead it applies it's own damage seperatedly ON TOP of normal damage
/// ie. a sword that does 10 damage with a bane elment attacthed that has a 0.5 damage_multiplier will do:
/// 10 damage from the swords normal attack + 5 damage (50%) from the bane element
/datum/element/bane
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// can be a mob or a species.
	var/target_type
	/// multiplier of the extra damage based on the force of the item.
	var/damage_multiplier
	/// Added after the above.
	var/added_damage
	/// If it requires combat mode on to deal the extra damage or not.
	var/requires_combat_mode
	/// if we want it to only affect a certain mob biotype
	var/mob_biotypes

/datum/element/bane/Attach(datum/target, target_type = /mob/living, mob_biotypes = NONE, damage_multiplier=1, added_damage = 0, requires_combat_mode = TRUE)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	if(ispath(target_type, /mob/living))
		RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, PROC_REF(mob_check))
	else if(ispath(target_type, /datum/species))
		RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, PROC_REF(species_check))
	else
		return ELEMENT_INCOMPATIBLE

	src.target_type = target_type
	src.damage_multiplier = damage_multiplier
	src.added_damage = added_damage
	src.requires_combat_mode = requires_combat_mode
	src.mob_biotypes = mob_biotypes

/datum/element/bane/Detach(datum/source)
	UnregisterSignal(source, COMSIG_ITEM_AFTERATTACK)
	return ..()

/datum/element/bane/proc/check_bane(bane_applier, target, bane_weapon)
	if(!check_biotype_path(bane_applier, target))
		return
	var/atom/movable/atom_owner = bane_weapon
	if(SEND_SIGNAL(atom_owner, COMSIG_OBJECT_PRE_BANING, target) & COMPONENT_CANCEL_BANING)
		return
	return TRUE

/**
 * Checks typepaths and the mob's biotype, returning TRUE if correct and FALSE if wrong.
 * Additionally checks if combat mode is required, and if so whether it's enabled or not.
 */
/datum/element/bane/proc/check_biotype_path(mob/living/bane_applier, atom/target)
	if(!isliving(target))
		return FALSE
	var/mob/living/living_target = target
	if(bane_applier)
		if(requires_combat_mode && !bane_applier.combat_mode)
			return FALSE
	var/is_correct_biotype = living_target.mob_biotypes & mob_biotypes
	if(mob_biotypes && !(is_correct_biotype))
		return FALSE

	var/extra_damage = max(0, (force_boosted * damage_multiplier) + added_damage)
	baned_target.apply_damage(extra_damage, applied_dam_type, hit_zone)
	SEND_SIGNAL(baned_target, COMSIG_LIVING_BANED, bane_applier, baned_target) // for extra effects when baned.
	SEND_SIGNAL(element_owner, COMSIG_OBJECT_ON_BANING, baned_target)
