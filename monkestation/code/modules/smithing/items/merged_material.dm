/obj/item/merged_material
	name = "forged metal"
	desc = "A blend of various metals."

	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "sheet-runite"

	var/material_name = "???"

/obj/item/merged_material/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/worked_material)
