/obj/machinery/growing_tray
	name = "hydroponics tray"
	icon = 'monkestation/icons/obj/machines/hydroponics.dmi'
	icon_state = "hydrotray"
	density = TRUE
	pass_flags_self = PASSMACHINE | LETPASSTHROW
	pixel_z = 8
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME

/obj/machinery/growing_tray/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/plant_tray_overlay, icon, "hydrotray_gaia", "hydrotray_water_", "hydrotray_pests", "hydrotray_harvest", "hydrotray_nutriment", "hydrotray_health", 0, 8)
	AddComponent(/datum/component/plant_growing)
