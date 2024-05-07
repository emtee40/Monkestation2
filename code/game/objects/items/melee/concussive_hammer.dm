/obj/item/melee/concuhammer
	name = "concussive hammer"
	desc = "A pneumatic hammer with a soft rubber head encompassing the front, for syndicate agents who are against murder."
	icon = 'icons/obj/weapons/cleric_mace.dmi' //Placeholder
	icon_state = "default"
	inhand_icon_state = "default"
	attack_verb_continuous = list("strikes")
	attack_verb_simple = list("strike")
	actions = list(/datum/action/cooldown/spell/concuss)

	slot_flags = ITEM_SLOT_BELT + ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE


/obj/item/melee/concuhammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed)

/datum/action/cooldown/spell/concuss
	name = "Concuss"
	desc = "TBD"
