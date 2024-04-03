/obj/item/smithed_part
	name = "generic smithed item"
	desc = "A forged item."

	icon = 'monkestation/code/modules/smithing/icons/forge_items.dmi'
	base_icon_state = "chain"
	icon_state = "hot_chain"

	var/base_name = "generic item"
	var/mat_name = "???"

	var/smithed_quality = 100

/obj/item/smithed_part/Initialize(mapload, obj/item/created_from, quality)
	. = ..()

	smithed_quality = quality

	if(!created_from)
		created_from = new /obj/item/stack/sheet/mineral/gold

	if(!istype(created_from, /obj/item/merged_material))
		var/obj/item/stack/stack = created_from
		var/datum/material/material = GET_MATERIAL_REF(stack.material_type)
		name = "[material.name] [base_name]"
		mat_name = material.name
	else
		var/obj/item/merged_material/mat = created_from
		name = "[mat.material_name] [base_name]"
		mat_name = mat.material_name

	AddComponent(/datum/component/worked_material)
	SEND_SIGNAL(src, COMSIG_MATERIAL_MERGE_MATERIAL, created_from)


/obj/item/smithed_part/update_name(updates)
	. = ..()
	name = "[mat_name] [base_name]"
