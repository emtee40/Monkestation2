// fear the øx
// øx means axe for the uncultured

/obj/item/melee/viking
	icon = ""
	lefthand_file = ""
	righthand_file = ""

/obj/item/melee/viking/tenja
	name = "Tenja"
	icon = ""
	icon_state = ""
	desc = "A one handed axe used by vikings."
	force = 20
	throwforce = 45
	embedding = 50

/obj/item/melee/viking/genja
	name = "Genja"
	icon = ""
	icon_state = ""
	desc = "A large 2 handed axe used for raiding."
	base_force = 15
	on_force = 30
	throwforce = 60
	embedding = 50


/obj/itme/melee/viking/genja/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=force_unwielded, force_wielded=force_wielded, icon_wielded="[base_icon_state]1")

/obj/item/melee/viking/skeggox
	name = "Skeggox"
	icon = ""
	icon_state = ""
	desc = "An axe meant to disarm the users opponent"
	force = 18
	throwforce = 40
	embedding = 50



/obj/item/melee/viking/skeggox/afterattack(target, mob/user, proximity_flag)
	. = ..()
	if(ishuman(target) && proximity_flag)
		var/mob/living/carbon/human/human_target = target
		human_target.drop_all_held_items()
		human_target.visible_message(span_danger("[user] disarms [human_target]!"), span_userdanger("[user] disarmed you!"))
