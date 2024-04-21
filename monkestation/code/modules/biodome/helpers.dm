///Applies BROKEN flag to the first found machine on a tile
/obj/effect/mapping_helpers/broken_machine
	name = "broken machine helper"
	icon_state = "broken_machine"
	late = TRUE

/obj/effect/mapping_helpers/broken_machine/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL

	var/obj/machinery/target = locate(/obj/machinery) in loc
	if(isnull(target))
		var/area/target_area = get_area(src)
		log_mapping("[src] failed to find a machine at [AREACOORD(src)] ([target_area.type]).")
	else
		payload(target)

	return INITIALIZE_HINT_LATELOAD

/obj/effect/mapping_helpers/broken_machine/LateInitialize()
	. = ..()
	var/obj/machinery/target = locate(/obj/machinery) in loc

	if(isnull(target))
		qdel(src)
		return

	target.update_appearance()
	qdel(src)

/obj/effect/mapping_helpers/broken_machine/proc/payload(obj/machinery/airalarm/target)
	if(target.machine_stat & BROKEN)
		var/area/area = get_area(target)
		log_mapping("[src] at [AREACOORD(src)] [(area.type)] tried to break [target] but it's already broken!")
	target.set_machine_stat(target.machine_stat | BROKEN)

///Deals random damage to the first window found on a tile to appear cracked
/obj/effect/mapping_helpers/damaged_window
	name = "damaged window helper"
	icon_state = "damaged_window"
	late = TRUE
	/// Minimum roll of integrity damage in percents needed to show cracks
	var/integrity_damage_min = 0.25
	/// Maximum roll of integrity damage in percents needed to show cracks
	var/integrity_damage_max = 0.85

/obj/effect/mapping_helpers/damaged_window/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL
	return INITIALIZE_HINT_LATELOAD

/obj/effect/mapping_helpers/damaged_window/LateInitialize()
	. = ..()
	var/obj/structure/window/target = locate(/obj/structure/window) in loc

	if(isnull(target))
		var/area/target_area = get_area(src)
		log_mapping("[src] failed to find a window at [AREACOORD(src)] ([target_area.type]).")
		qdel(src)
		return
	else
		payload(target)

	target.update_appearance()
	qdel(src)

/obj/effect/mapping_helpers/damaged_window/proc/payload(obj/structure/window/target)
	if(target.get_integrity() < target.max_integrity)
		var/area/area = get_area(target)
		log_mapping("[src] at [AREACOORD(src)] [(area.type)] tried to damage [target] but it's already damaged!")
	target.take_damage(rand(target.max_integrity * integrity_damage_min, target.max_integrity * integrity_damage_max))

//requests console helpers
/obj/effect/mapping_helpers/requests_console
	desc = "You shouldn't see this. Report it please."
	late = TRUE

/obj/effect/mapping_helpers/requests_console/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL

	return INITIALIZE_HINT_LATELOAD

/obj/effect/mapping_helpers/requests_console/LateInitialize(mapload)
	var/obj/machinery/target = locate(/obj/machinery/requests_console) in loc
	if(isnull(target))
		var/area/target_area = get_area(target)
		log_mapping("[src] failed to find a requests console at [AREACOORD(src)] ([target_area.type]).")
	else
		payload(target)

	qdel(src)

/// Fills out the request console's variables
/obj/effect/mapping_helpers/requests_console/proc/payload(obj/machinery/requests_console/console)
	return

/obj/effect/mapping_helpers/requests_console/announcement
	name = "request console announcement helper"
	icon_state = "requests_console_announcement_helper"

/obj/effect/mapping_helpers/requests_console/announcement/payload(obj/machinery/requests_console/console)
	console.can_send_announcements = TRUE

/obj/effect/mapping_helpers/requests_console/assistance
	name = "request console assistance requestable helper"
	icon_state = "requests_console_assistance_helper"

/obj/effect/mapping_helpers/requests_console/assistance/payload(obj/machinery/requests_console/console)
	GLOB.req_console_assistance |= console.department

/obj/effect/mapping_helpers/requests_console/supplies
	name = "request console supplies requestable helper"
	icon_state = "requests_console_supplies_helper"

/obj/effect/mapping_helpers/requests_console/supplies/payload(obj/machinery/requests_console/console)
	GLOB.req_console_supplies |= console.department

/obj/effect/mapping_helpers/requests_console/information
	name = "request console information relayable helper"
	icon_state = "requests_console_information_helper"

/obj/effect/mapping_helpers/requests_console/information/payload(obj/machinery/requests_console/console)
	GLOB.req_console_information |= console.department

/obj/effect/mapping_helpers/requests_console/ore_update
	name = "request console ore update helper"
	icon_state = "requests_console_ore_update_helper"

/obj/effect/mapping_helpers/requests_console/ore_update/payload(obj/machinery/requests_console/console)
	console.receive_ore_updates = TRUE

//Used to turn off lights with lightswitch in areas.
/obj/effect/mapping_helpers/turn_off_lights_with_lightswitch
	name = "area turned off lights helper"
	icon_state = "lights_off"

/obj/effect/mapping_helpers/turn_off_lights_with_lightswitch/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL
	check_validity()
	return INITIALIZE_HINT_QDEL

/obj/effect/mapping_helpers/turn_off_lights_with_lightswitch/proc/check_validity()
	var/area/needed_area = get_area(src)
	if(!needed_area.lightswitch)
		stack_trace("[src] at [AREACOORD(src)] [(needed_area.type)] tried to turn lights off but they are already off!")
	var/obj/machinery/light_switch/light_switch = locate(/obj/machinery/light_switch) in needed_area
	if(!light_switch)
		stack_trace("Trying to turn off lights with lightswitch in area without lightswitches. In [(needed_area.type)] to be precise.")
	needed_area.lightswitch = FALSE
