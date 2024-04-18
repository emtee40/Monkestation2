/obj/machinery/growing
	name = "hydroponics tray"
	icon = 'monkestation/icons/obj/machines/hydroponics.dmi'
	icon_state = "hydrotray"
	density = TRUE
	pass_flags_self = PASSMACHINE | LETPASSTHROW
	pixel_z = 8
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME

/obj/machinery/growing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/plant_growing)

/obj/machinery/growing/tray
	circuit = /obj/item/circuitboard/machine/hydroponics

/obj/machinery/growing/tray/Initialize(mapload)
	AddComponent(/datum/component/plant_tray_overlay, icon, "hydrotray_gaia", "hydrotray_water_", "hydrotray_pests", "hydrotray_harvest", "hydrotray_nutriment", "hydrotray_health", 0, 0)
	. = ..()

/obj/machinery/growing/soil
	name = "soil"
	desc = "A patch of dirt."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "soil"

/obj/machinery/growing/soil/Initialize(mapload)
	AddComponent(/datum/component/plant_tray_overlay, icon, null, null, null, null, null, null, 0, 0)
	. = ..()
