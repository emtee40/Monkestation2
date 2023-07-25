/**
 * File that contains all projectiles used by the stalwart, and his minions
 */

/obj/projectile/stalpike
	name = "energy pike"
	icon = 'monkestation/code/modules/lavaland/megafauna/stalwart/icons/projectiles.dmi'
	icon_state = "arcane_barrage_greyscale"
	damage = 30
	armour_penetration = 50
	speed = 4
	eyeblur = 0
	damage_type = BRUTE
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	color = "#00e1ff"
	light_outer_range = 2
	light_power = 6
	light_color = "#00e1ff"

/obj/projectile/stalpike/spiral
	name = "resonant energy pike"
	armour_penetration = 60
	speed = 6
	color = "#4851ce"
	light_color = "#4851ce"

/obj/projectile/stalpike/weak
	name = "lesser energy pike"
	damage = 10
	armour_penetration = 50
	speed = 5
	color = "#9a9fdb"
	light_color = "#9a9fdb"

/obj/projectile/stalnade
	name = "volatile orb"
	icon_state = "wipe"
	damage = 40
	armour_penetration = 60
	speed = 10
	eyeblur = 0
	damage_type = BRUTE
	pass_flags = PASSTABLE
	light_outer_range = 6
	light_power = 10
	light_color = "#0077ff"

/obj/projectile/stalnade/on_hit(target)
	if(!iscarbon(target))
		return BULLET_ACT_FORCE_PIERCE
	. = ..()
