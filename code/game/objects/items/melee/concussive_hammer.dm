/obj/item/melee/concuhammer
	name = "concussive hammer"
	desc = "A pneumatic hammer with a soft rubber head encompassing the front, for syndicate agents who are against murder."
	icon = 'icons/obj/weapons/cleric_mace.dmi' //Placeholder
	icon_state = "default"
	inhand_icon_state = "default"
	attack_verb_continuous = list("strikes")
	attack_verb_simple = list("strike")
	slot_flags = ITEM_SLOT_BELT + ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	var/datum/action/cooldown/spell/touch/concuss = new

/datum/action/cooldown/spell/touch/concuss
	name = "Concuss"
	desc = "TBD"
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	overlay_icon_state = "bg_default_border"

/obj/item/melee/concuhammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed)

/obj/item/melee/concuhammer/equipped(mob/living/owner, slot)
	. = ..()
	if(slot & ITEM_SLOT_HANDS)
		concuss.Grant(owner)

/obj/item/melee/concuhammer/dropped(mob/living/owner, slot)
	. = ..()
	if(owner.get_item_by_slot(ITEM_SLOT_HANDS) == src)
		concuss.Remove(owner)

