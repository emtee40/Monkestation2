/obj/item/stack/cable_coil/monitoring
	max_amount = 1
	amount = 1
	merge_type = /obj/item/stack/cable_coil/monitoring
	target_type = /obj/structure/cable/monitoring

/obj/item/stack/cable_coil/update_name()
	. = ..()
	name = "a wire with an electronic display"

/obj/item/stack/cable_coil/monitoring/update_desc()
	. = ..()
	desc = "A piece of insulated power cable with an attached electronic display, allowing for quick and safe network power checking."

/obj/structure/cable/monitoring
	name = "cable with an attached electronic display"
	desc = "A flexible, superconducting insulated cable for heavy-duty power transfer with an attached electronic display that is displaying its current power amount."
	cable_color = CABLE_COLOR_CYAN
	color = CABLE_COLOR_CYAN

/obj/structure/cable/monitoring/examine(mob/user)
	. = ..()
	if(!isobserver(user)) // check if they are an observer, we dont want to double-dip
		. += get_power_info()

/obj/structure/cable/monitoring/update_overlays()
	. = ..()
	. += "power_monitor"

/obj/structure/cable/monitoring/attackby(obj/item/W, mob/user, params)
	var/turf/T = get_turf(src)
	if(T.underfloor_accessibility >= UNDERFLOOR_INTERACTABLE && (W.tool_behaviour == TOOL_WIRECUTTER || W.tool_behaviour == TOOL_MULTITOOL))
		handlecable(W, user, params)
		return

	to_chat(user, get_power_info())

/obj/structure/cable/monitoring/deconstruct(disassembled = TRUE)
	to_chat(usr, span_notice("You start to carefully snip the electronic monitoring equipment..."))
	if(!do_after(usr, 5 SECONDS, src))
		to_chat(usr, span_warning("Your hand slips, and the monitoring equipment is destroyed!"))
		do_sparks(5, TRUE, src)
		playsound(usr, 'sound/effects/sparks2.ogg', 100, TRUE)
		new /obj/item/stack/cable_coil(drop_location(), 1)
		qdel(src) // those electronics are fragile
		return

	if(!(flags_1 & NODECONSTRUCT_1))
		to_chat(usr, span_notice("You manage to free the monitoring equipment and cable free from the network."))
		var/obj/item/stack/cable_coil/monitoring/cable = new(drop_location(), 1)
		cable.set_cable_color(cable_color)

	qdel(src)
