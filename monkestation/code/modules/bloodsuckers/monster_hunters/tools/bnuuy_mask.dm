/obj/item/clothing/mask/cursed_rabbit
	name = "Damned Rabbit Mask"
	desc = "Slip into the wonderland."
	icon =  'monkestation/icons/bloodsuckers/weapons.dmi'
	icon_state = "rabbit_mask"
	worn_icon = 'monkestation/icons/bloodsuckers/worn_mask.dmi'
	worn_icon_state = "rabbit_mask"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING | SNUG_FIT
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
	var/datum/component/glitching_state/wondershift
	var/static/list/granted_traits = list(
		TRAIT_ANALGESIA,
		TRAIT_BATON_RESISTANCE,
		TRAIT_CANT_STAMCRIT,
		TRAIT_HEAR_THROUGH_DARKNESS,
		TRAIT_IGNORESLOWDOWN,
		TRAIT_NOBREATH,
		TRAIT_NODISMEMBER,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_STABLEHEART,
		TRAIT_THERMAL_VISION
	)
	/// When passive regeneration is able kick in fully (normally 10 seconds after the user is hit with any sort of attack)
	COOLDOWN_DECLARE(full_regen_cooldown)

/datum/status_effect/bnuuy_mask/on_apply()
	. = ..()
	if(!ishuman(owner) || !IS_MONSTERHUNTER(owner) || !istype(owner.get_item_by_slot(ITEM_SLOT_MASK), /obj/item/clothing/mask/cursed_rabbit))
		return FALSE
	wondershift = owner.AddComponent(/datum/component/glitching_state)
	if(!HAS_TRAIT(owner, TRAIT_RELAYING_ATTACKER))
		owner.AddElement(/datum/element/relay_attackers)
	RegisterSignal(owner, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))
	give_physiology_buff(owner)
	owner.add_traits(granted_traits, id)
	owner.update_sight()
	COOLDOWN_START(src, full_regen_cooldown, 10 SECONDS)

/datum/status_effect/bnuuy_mask/on_remove()
	. = ..()
	QDEL_NULL(wondershift)
	UnregisterSignal(owner, COMSIG_ATOM_WAS_ATTACKED)
	take_physiology_buff(owner)
	REMOVE_TRAITS_IN(owner, id)
	owner.update_sight()

/datum/status_effect/bnuuy_mask/tick(seconds_per_tick, times_fired)
	. = ..()
	if(!istype(owner.get_item_by_slot(ITEM_SLOT_MASK), /obj/item/clothing/mask/cursed_rabbit))
		qdel(src)
		return
	var/mob/living/carbon/human/human_owner = owner
	var/full_effect = COOLDOWN_FINISHED(src, full_regen_cooldown)
	var/basic_heal_amt = (full_effect ? 5 : 2) * seconds_per_tick
	// stamina/stuns regens more mid-battle, adrenaline from the thrill of the fight empowers you
	var/stamina_regen_amt = (full_effect ? 5 : 15) * seconds_per_tick
	var/immobility_regen_amt = (full_effect ? (0.2 SECONDS) : (0.8 SECONDS)) * seconds_per_tick
	// heal basic damages
	human_owner.heal_overall_damage(brute = basic_heal_amt, burn = basic_heal_amt, updating_health = FALSE)
	human_owner.adjustToxLoss(-basic_heal_amt, updating_health = FALSE, forced = TRUE)
	human_owner.adjustOxyLoss(-basic_heal_amt)
	human_owner.AdjustAllImmobility(-stamina_regen_amt)
	human_owner.stamina?.adjust(stamina_regen_amt, forced = TRUE)
	// heal blood / bleeding
	if(human_owner.blood_volume < BLOOD_VOLUME_SAFE)
		human_owner.blood_volume += basic_heal_amt
	var/datum/wound/bloodiest_wound
	for(var/datum/wound/iter_wound as anything in human_owner.all_wounds)
		if(iter_wound.blood_flow && iter_wound.blood_flow > bloodiest_wound?.blood_flow)
			bloodiest_wound = iter_wound
	bloodiest_wound?.adjust_blood_flow(-3 * seconds_per_tick)

/datum/status_effect/bnuuy_mask/get_examine_text()
	return span_warning("[owner.p_they(TRUE)] seem[owner.p_s()] out-of-place, as if [owner.p_they()] were partially detached from reality.")

/datum/status_effect/bnuuy_mask/proc/on_attacked(datum/source, atom/attacker, attack_flags)
	SIGNAL_HANDLER
	if(attacker != owner && (attack_flags & ATTACKER_DAMAGING_ATTACK))
		COOLDOWN_START(src, full_regen_cooldown, 10 SECONDS)

/datum/status_effect/bnuuy_mask/proc/give_physiology_buff(mob/living/carbon/human/hunter)
	var/datum/physiology/physiology = hunter.physiology
	if(QDELETED(physiology))
		return
	// Silly environmental hazards are nothing compared to the glory of the hunt.
	physiology.damage_resistance += 5
	physiology.stun_mod *= 0.5
	physiology.bleed_mod *= 0.25

/datum/status_effect/bnuuy_mask/proc/take_physiology_buff(mob/living/carbon/human/hunter)
	var/datum/physiology/physiology = hunter.physiology
	if(QDELETED(physiology))
		return
	physiology.damage_resistance -= 5
	physiology.stun_mod /= 0.5
	physiology.bleed_mod /= 0.25
