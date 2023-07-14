/obj/item/gun/energy/plasmacutter/scatter
	name = "plasma cutter shotgun"
	icon_state = "mining_shotgun"
	inhand_icon_state = "mining_shotgun"
	desc = "An industrial-grade heavy-duty mining shotgun"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/scatter)

/obj/item/gun/energy/plasmacutter/attackby(obj/item/I, mob/user)
	. = ..()
	if(try_upgrade(I))
		to_chat(user, "<span class='notice'>You install [I] into [src]</span>")
		playsound(loc, 'sound/items/screwdriver.ogg', 100, 1)
		qdel(I)

/obj/item/gun/energy/plasmacutter/scatter/stalwart
	name = "ancient focusing crystal"
	icon_state = "stalwart_mining_shotgun"
	inhand_icon_state = "stalwart_mining_shotgun"
	desc = "A humming crystaline weapon, firing scattered blasts of focused energy."
	usesound = list('sound/weapons/taserhit.ogg')
	toolspeed = 0.33
	selfcharge = 1
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/upgrade/plasmacutter
	name = "generic upgrade kit"
	desc = "An upgrade for plasma shotguns."
	icon = 'icons/obj/objects.dmi'
	icon_state = "modkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/upgrade/plasmacutter/defuser
	name = "plasma cutter defusal kit"
	desc = "An upgrade for plasma shotguns that allows it to automatically defuse gibtonite."

/obj/item/gun/energy/plasmacutter/proc/try_upgrade(obj/item/I)
	return // no upgrades for the plasmacutter

/obj/item/gun/energy/plasmacutter/scatter/try_upgrade(obj/item/I)
	if(.)
		return
	if(istype(I, /obj/item/upgrade/plasmacutter/defuser))
		var/kaboom = new/obj/item/ammo_casing/energy/plasma/scatter/adv
		ammo_type = list(kaboom)
		return TRUE
	return FALSE
