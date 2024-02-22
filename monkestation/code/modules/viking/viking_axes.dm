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

/obj/item/melee/viking/genja
	name = "Genja"
	icon = ""
	icon_state = ""
	desc = "A large 2 handed axe used for raiding."

/obj/item/melee/viking/skeggox
	name = "Skeggox"
	icon = ""
	icon_state = ""
	desc = "An axe meant to disarm the users opponent"


/obj/item/melee/viking/skeggox/afterattack(target, mob/user, proximity_flag)
	. = ..()
	if(ishuman(target) && proximity_flag)
		var/mob/living/carbon/human/human_target = target
		human_target.drop_all_held_items()
		human_target.visible_message(span_danger("[user] disarms [human_target]!"), span_userdanger("[user] disarmed you!"))
