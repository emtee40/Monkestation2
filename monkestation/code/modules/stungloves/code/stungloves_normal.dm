//Add any and all powergloves/stungloves to this file!\\

/obj/item/melee/baton/security/stungloves //Compatible with species with chunky fingers.
	name = "MK.III PSG"
	desc = "The Mark-Three Powered Stun Gloves. For re-educating the Clown with your fists, now in legally-correct flavors! Wearable - Leftclick to Stun, Rightclick to beat. Combat intent to stun AND beat while leftclicking."
	force = 3 // These are gloves meant to stun targets. They're not meant to be used to beat the clown to death. Hopefully.
	icon = 'monkestation/code/modules/stungloves/icons/stunglove_item.dmi'
	worn_icon = 'monkestation/code/modules/stungloves/icons/stunglove_item.dmi'
	worn_icon_nabber = 'monkestation/code/modules/nabbers/icons/mob/clothing/hands.dmi'
	icon_state = "stunglove"
	inhand_icon_state = "stunglove"
	worn_icon_state = "stunglove_onmob"
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_GLOVES
	chunky_finger_usable = TRUE
	preload_cell_type = /obj/item/stock_parts/cell/high

	cooldown = 2 SECONDS //Longer.
	stamina_damage = 95
	knockdown_time = 2.5 SECONDS //Half
	clumsy_knockdown_time = 6 SECONDS //Lower power batong

/obj/item/melee/baton/security/stungloves/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_GLOVES)
		RegisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(punch_to_stun))

/obj/item/melee/baton/security/stungloves/dropped(mob/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		UnregisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)

/obj/item/melee/baton/security/stungloves/proc/punch_to_stun(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	if(!proximity)
		return NONE
	if(ishuman(target))
		return src.attack(target, source, BATON_ATTACKING) //Make sure we stun them, or at worst case, just prod them if no cell
	if(ismob(target))
		return src.attack(target,source) //Default to attacking otherwise
	return NONE
