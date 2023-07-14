/obj/projectile/plasma/scatter/adv/on_hit(atom/target)
	if(istype(target, /turf/closed/mineral/gibtonite))
		var/turf/closed/mineral/gibtonite/gib = target
		gib.defuse()
	. = ..()

/obj/projectile/plasma/scatter
	damage = 2
	range = 5
	mine_range = 2
	dismemberment = 0

// Used for auto-defusing
/obj/projectile/plasma/scatter/adv
