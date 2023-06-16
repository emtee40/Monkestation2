/obj/projectile/plasma
	name = "plasma blast"
	icon_state = "plasmacutter"
	damage_type = BURN
	damage = 5
	range = 4
	dismemberment = 20
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	var/mine_range = 3 //mines this many additional tiles of rock
	tracer_type = /obj/effect/projectile/tracer/plasma_cutter
	muzzle_type = /obj/effect/projectile/muzzle/plasma_cutter
	impact_type = /obj/effect/projectile/impact/plasma_cutter

/obj/projectile/plasma/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
		if(mine_range)
			mine_range--
			range++
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE

/obj/projectile/plasma/adv
	damage = 7
	range = 5
	mine_range = 5

/obj/projectile/plasma/adv/mech
	damage = 10
	range = 9
	mine_range = 3

/obj/projectile/plasma/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 24
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

// monkestation change begins, plasma shotguns

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

// Same as the scatter but with automatic defusing
/obj/projectile/plasma/scatter/adv
