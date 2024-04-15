/obj/item/clothing/mask/cursed_rabbit
	name = "Damned Rabbit Mask"
	desc = "Slip into the wonderland."
	icon =  'monkestation/icons/bloodsuckers/weapons.dmi'
	icon_state = "rabbit_mask"
	worn_icon = 'monkestation/icons/bloodsuckers/worn_mask.dmi'
	worn_icon_state = "rabbit_mask"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_WELDER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	///the paradox rabbit ability
	var/datum/action/cooldown/paradox/paradox
	///teleporting to the wonderland
	var/datum/action/cooldown/wonderland_drop/wonderland

/obj/item/clothing/mask/cursed_rabbit/Initialize(mapload)
	. = ..()
	paradox = new
	wonderland = new

/obj/item/clothing/mask/cursed_rabbit/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot & ITEM_SLOT_MASK) || !IS_MONSTERHUNTER(user))
		return
	paradox?.Grant(user)
	wonderland?.Grant(user)
	user.apply_status_effect(/datum/status_effect/bnuuy_mask)

/obj/item/clothing/mask/cursed_rabbit/dropped(mob/living/user)
	. = ..()
	paradox?.Remove(user)
	wonderland?.Remove(user)
	user.remove_status_effect(/datum/status_effect/bnuuy_mask)

/datum/status_effect/bnuuy_mask
	id = "bnuuy_mask"
	alert_type = null
	on_remove_on_mob_delete = TRUE
	var/static/list/granted_traits = list(
		TRAIT_ANALGESIA,
		TRAIT_BATON_RESISTANCE,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_HEAR_THROUGH_DARKNESS,
		TRAIT_NOBREATH,
		TRAIT_NODISMEMBER,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_THERMAL_VISION
	)
	/// When passive regeneration is able to start (normally 10 seconds after the user is hit with any sort of attack)
	COOLDOWN_DECLARE(regen_start)

/datum/status_effect/bnuuy_mask/on_apply()
	. = ..()
	if(!ishuman(owner) || !IS_MONSTERHUNTER(owner) || !istype(owner.get_item_by_slot(ITEM_SLOT_MASK), /obj/item/clothing/mask/cursed_rabbit))
		return FALSE
	owner.AddElement(/datum/element/relay_attackers)
	RegisterSignal(owner, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))
	give_physiology_buff(owner)
	owner.add_traits(granted_traits, id)
	owner.update_sight()
	COOLDOWN_START(src, regen_start, 10 SECONDS)

/datum/status_effect/bnuuy_mask/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_ATOM_WAS_ATTACKED)
	take_physiology_buff(owner)
	REMOVE_TRAITS_IN(owner, id)
	owner.update_sight()

/datum/status_effect/bnuuy_mask/tick(seconds_per_tick, times_fired)
	. = ..()
	if(!IS_MONSTERHUNTER(owner) || !istype(owner.get_item_by_slot(ITEM_SLOT_MASK), /obj/item/clothing/mask/cursed_rabbit))
		qdel(src)
		return
	if(COOLDOWN_FINISHED(src, regen_start))
		owner.heal_overall_damage(brute = 2 * seconds_per_tick, burn = 2 * seconds_per_tick, updating_health = FALSE)
		owner.adjustToxLoss(-2 * seconds_per_tick, updating_health = FALSE, forced = TRUE)
		owner.adjustOxyLoss(-2 * seconds_per_tick)

/datum/status_effect/bnuuy_mask/get_examine_text()
	return span_warning("[owner.p_their(TRUE)] seems to radiate an intimidating, determined aura.")

/datum/status_effect/bnuuy_mask/proc/on_attacked(datum/source, atom/attacker, attack_flags)
	SIGNAL_HANDLER
	if(attacker != owner && (attack_flags & ATTACKER_DAMAGING_ATTACK))
		COOLDOWN_START(src, regen_start, 10 SECONDS)

/datum/status_effect/bnuuy_mask/proc/give_physiology_buff(mob/living/carbon/human/hunter)
	var/datum/physiology/physiology = hunter.physiology
	if(QDELETED(physiology))
		return
	// Silly environmental hazards are nothing compared to the glory of the hunt.
	physiology.damage_resistance += 5
	physiology.pressure_mod *= 0.1
	physiology.heat_mod *= 0.1
	physiology.cold_mod *= 0.1
	physiology.bleed_mod *= 0.25

/datum/status_effect/bnuuy_mask/proc/take_physiology_buff(mob/living/carbon/human/hunter)
	var/datum/physiology/physiology = hunter.physiology
	if(QDELETED(physiology))
		return
	physiology.damage_resistance -= 5
	physiology.pressure_mod /= 0.1
	physiology.heat_mod /= 0.1
	physiology.cold_mod /= 0.1
	physiology.bleed_mod /= 0.25
