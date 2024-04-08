/obj/machinery/electroplater
	name = "arc electroplater"
	desc = "An industrial electroplater, using electricity it can coat basically anything in the given materials."

	icon_state = "plater0"
	icon = 'goon/icons/matsci.dmi'

	anchored = TRUE
	density = TRUE

	idle_power_usage = 10
	active_power_usage = 3000
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	circuit = null

	light_outer_range = 2
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE

	///this can either be a worked material or a stack item
	var/obj/item/stored_material
	///this is the item we are plating
	var/obj/item/plating_item
	///this is the max weight class it can be upped to depending on stats
	var/max_weight_increase = WEIGHT_CLASS_BULKY
	///how long it takes to bake
	var/plating_time = 10 SECONDS
	///are we plating right now?
	var/plating = FALSE

/obj/machinery/electroplater/attacked_by(obj/item/attacking_item, mob/living/user)
	if(isstack(attacking_item))
		if(stored_material)
			return FALSE
		var/obj/item/stack/stack = attacking_item
		if(!stack.material_type)
			return FALSE
		if(stack.amount == 1)
			attacking_item.forceMove(src)
			stored_material = attacking_item
			return FALSE
		else
			var/obj/item/stack/new_stack = stack.split_stack(user, 1)
			new_stack.forceMove(src)
			stored_material = new_stack
			return FALSE

	else if(istype(attacking_item, /obj/item/merged_material))
		if(stored_material)
			return TRUE
		attacking_item.forceMove(src)
		stored_material = attacking_item
		return FALSE

	if(!stored_material || plating_item || plating)
		return TRUE

	if(HAS_TRAIT(attacking_item, TRAIT_NODROP))
		return TRUE

	plating_item = attacking_item
	attacking_item.forceMove(src)
	try_plate()
	. = ..()

/obj/machinery/electroplater/proc/try_plate()
	if(!stored_material || !plating_item)
		return
	plating = TRUE
	icon_state = "plater1"

	machine_do_after_visable(src, plating_time) // glorified sleep go brrr
	if(!plating_item.GetComponent(/datum/component/worked_material))
		plating_item.AddComponent(/datum/component/worked_material)
	SEND_SIGNAL(plating_item, COMSIG_MATERIAL_MERGE_MATERIAL, stored_material)
	plating_item.forceMove(get_turf(src))

	var/material_name = "???"
	if(isstack(stored_material))
		var/obj/item/stack/stack = plating_item
		var/datum/material/material = GET_MATERIAL_REF(stack.material_type)
		material_name = material.name
	else if(istype(stored_material, /obj/item/merged_material))
		var/obj/item/merged_material/mat = stored_material
		material_name = mat.material_name
	plating_item.name = "[material_name] plated [name]"

	QDEL_NULL(stored_material)
	plating_item = null
	plating = FALSE
	icon_state = "plater0"
