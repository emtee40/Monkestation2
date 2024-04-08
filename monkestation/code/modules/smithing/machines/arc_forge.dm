/obj/machinery/arc_forge
	name = "arc forge"
	desc = "A bulky machine that can smelt practically any material in existence."
	icon = 'monkestation/code/modules/smithing/icons/3x3.dmi'
	icon_state = "arc_forge"
	bound_width = 96
	bound_height = 96
	anchored = TRUE
	max_integrity = 1000
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 3000
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	circuit = null
	light_outer_range = 5
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE

	///the item in our first slot for merging
	var/atom/movable/slot_one_item
	///the item in our second slot for merging
	var/atom/movable/slot_two_item


/obj/machinery/arc_forge/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/arc_forge/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(slot_one_item && slot_two_item)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Alloy Materials."
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/arc_forge/attacked_by(obj/item/attacking_item, mob/living/user)
	if(isstack(attacking_item))
		var/obj/item/stack/stack = attacking_item
		if(!stack.material_type)
			return ..()
		if(try_add_to_buffer(attacking_item))
			return TRUE
	if(istype(attacking_item, /obj/item/merged_material))
		if(try_add_to_buffer(attacking_item))
			return TRUE
	. = ..()

/obj/machinery/arc_forge/proc/try_add_to_buffer(obj/item/adder)
	if(!slot_one_item)
		slot_one_item = adder
		adder.forceMove(src)
		return TRUE
	if(!slot_two_item)
		slot_two_item = adder
		adder.forceMove(src)
		return TRUE
	return FALSE

/obj/machinery/arc_forge/AltClick(mob/user)
	if(attempt_material_forge())
		return TRUE
	. = ..()

/obj/machinery/arc_forge/proc/attempt_material_forge()
	if(!slot_one_item || !slot_two_item)
		return FALSE

	var/obj/item/merged_material/new_material = new(get_turf(src))
	SEND_SIGNAL(new_material, COMSIG_MATERIAL_MERGE_MATERIAL, slot_one_item)
	SEND_SIGNAL(new_material, COMSIG_MATERIAL_MERGE_MATERIAL, slot_two_item)

	new_material.material_name = merge_names()
	new_material.name = "[new_material.material_name] Ingot"

	QDEL_NULL(slot_one_item)
	QDEL_NULL(slot_two_item)
	return TRUE

/obj/machinery/arc_forge/proc/merge_names()
	var/name_1 = ""
	var/name_2 = ""

	if(slot_one_item.GetComponent(/datum/component/worked_material))
		var/obj/item/merged_material/mat = slot_one_item
		name_1 = copytext(mat.material_name, 1, round((length(mat.material_name) * 0.5) + 0.5))
	else
		var/obj/item/stack/stack = slot_one_item
		var/datum/material/material = GET_MATERIAL_REF(stack.material_type)
		name_1 = copytext(material.name, 1, round((length(material.name) * 0.5) + 0.5))

	if(slot_two_item.GetComponent(/datum/component/worked_material))
		var/obj/item/merged_material/mat = slot_two_item
		name_2 = copytext(mat.material_name, round((length(mat.material_name) * 0.5) + 0.5), 0)
	else
		var/obj/item/stack/stack = slot_two_item
		var/datum/material/material = GET_MATERIAL_REF(stack.material_type)
		name_2 = copytext(material.name, round((length(material.name) * 0.5) + 0.5), 0)
	return "[name_1][name_2]"
