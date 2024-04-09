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
	if(attacking_item.forceMove(src))
		try_plate()
		return FALSE
	. = ..()

/obj/machinery/electroplater/proc/try_plate()
	if(!stored_material || !plating_item)
		return
	plating = TRUE
	icon_state = "plater1"

	machine_do_after_visable(src, plating_time) // glorified sleep go brrr
	if(!plating_item.material_stats)
		if(isstack(stored_material))
			var/obj/item/stack/stack = stored_material
			plating_item.create_stats_from_material(stack.material_type)
		else
			plating_item.create_stats_from_material_stats(stored_material.material_stats)

	plating_item.forceMove(get_turf(src))
	plating_item.name = "[plating_item.material_stats.material_name] plated [plating_item.name]"

	QDEL_NULL(stored_material)
	plating_item = null
	plating = FALSE
	icon_state = "plater0"
