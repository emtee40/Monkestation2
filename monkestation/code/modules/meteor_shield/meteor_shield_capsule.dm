/obj/item/meteor_shield_capsule
	name = "meteor shield satellite capsule"
	desc = "A bluespace capsule which a single unit of meteor shield satellite is compressed within. If you activate this capsule, a meteor shield satellite will pop out. You still need to install these."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/meteor_shield_capsule/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, 5 SECONDS, /obj/machinery/satellite/meteor_shield, delete_on_use = TRUE)
