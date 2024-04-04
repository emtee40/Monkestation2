/obj/structure/anvil
	name = "anvil"
	desc = "Great for forging."

	density = TRUE
	anchored = TRUE

	icon = 'monkestation/code/modules/smithing/icons/forge_structures.dmi'
	icon_state = "anvil_empty"

	var/datum/anvil_recipe/chosen_recipe = /datum/anvil_recipe/sword_blade

	var/obj/item/working_material
	var/smithing = FALSE

/obj/structure/anvil/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!smithing && working_material)
		var/datum/component/worked_material/component = working_material.GetComponent(/datum/component/worked_material)
		var/density_hardness = 0

		if(!component)
			var/obj/item/stack/stack = working_material
			var/datum/material/material = GET_MATERIAL_REF(stack.material_type)
			density_hardness = material.hardness + material.density
		else
			density_hardness = component.hardness + component.density

		var/difficulty_modifier = density_hardness / 40

		new /datum/anvil_challenge(src, new chosen_recipe, user, difficulty_modifier)
		smithing = TRUE

/obj/structure/anvil/proc/generate_item(quality)
	var/obj/item/smithed_part/new_part = chosen_recipe.output
	new new_part (get_turf(src), working_material, quality)
	QDEL_NULL(working_material)

/obj/structure/anvil/attacked_by(obj/item/attacking_item, mob/living/user)
	if(isstack(attacking_item) || istype(attacking_item, /obj/item/merged_material))
		if(try_place_item(attacking_item, user))
			return TRUE

	. = ..()

/obj/structure/anvil/proc/try_place_item(obj/item/item, mob/living/user)
	if(working_material)
		working_material.forceMove(get_turf(src))
		working_material = null

	working_material = item
	item.forceMove(src)
	visible_message("[user] replaces the ingot on the anvil.")
	return TRUE
