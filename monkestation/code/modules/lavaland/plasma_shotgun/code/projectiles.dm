/// Projectiles

/obj/projectile/plasma/scatter
	damage = 2
	range = 5
	mine_range = 2
	dismemberment = 0


/// Used for auto-defusing (currently un-used)
/obj/projectile/plasma/scatter/adv

/obj/projectile/plasma/scatter/adv/on_hit(atom/target)
	if(istype(target, /turf/closed/mineral/gibtonite))
		var/turf/closed/mineral/gibtonite/gib = target
		gib.defuse()
	. = ..()

/// Casings

/obj/item/ammo_casing/energy/plasma/scatter
	projectile_type = /obj/projectile/plasma/scatter
	delay = 15
	e_cost = 35
	pellets = 6
	variance = 30

/obj/item/ammo_casing/energy/plasma/scatter/adv
	projectile_type = /obj/projectile/plasma/scatter/adv
