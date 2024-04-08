/obj/item/smithed_part/weapon_part/rapier_blade
	icon_state = "rapier_blade"
	base_name = "rapier blade"
	weapon_name = "rapier"

	hilt_icon = 'monkestation/code/modules/smithing/icons/forge_items.dmi'
	hilt_icon_state = "rapier-hilt"

/obj/item/smithed_part/weapon_part/rapier_blade/finish_weapon()
	. = ..()
	sharpness = SHARP_POINTY
	wound_bonus = 10
	bare_wound_bonus = 25
	armour_penetration = -5
	AddComponent(/datum/component/multi_hit, icon_state = "stab", height = 2)

	var/datum/component/worked_material/material = GetComponent(/datum/component/worked_material)

	force = round(((material.density + material.hardness) / 6.25) * (smithed_quality * 0.01))
	throwforce = force * 1.5
	w_class = WEIGHT_CLASS_NORMAL
