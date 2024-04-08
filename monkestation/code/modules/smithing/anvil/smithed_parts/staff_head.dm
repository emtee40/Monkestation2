/obj/item/smithed_part/weapon_part/staff_head
	icon_state = "staffhead"
	base_name = "staff head"
	weapon_name = "staff"

	hilt_icon = 'monkestation/code/modules/smithing/icons/forge_items.dmi'
	hilt_icon_state = "staff-hilt"

/obj/item/smithed_part/weapon_part/staff_head/finish_weapon()
	. = ..()
	damtype = STAMINA
	reach = 2
	AddComponent(/datum/component/multi_hit, icon_state = "swipe", width = 3, continues_travel = TRUE)

	var/datum/component/worked_material/material = GetComponent(/datum/component/worked_material)

	force = round(((material.density + material.hardness) / 5) * (smithed_quality * 0.01))
	throwforce = force * 0.1 // good luck whipping a staff at something
	w_class = WEIGHT_CLASS_HUGE
