/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench?
	var/can_be_printed = TRUE
	/// If it can be printed, does this casing require an advanced ammunition datadisk? Mainly for specialized ammo.
	/// Rubbers aren't advanced. Standard ammo (or FMJ if you're particularly pedantic) isn't advanced.
	/// Think more specialized or weird, niche ammo, like armor-piercing, incendiary, hollowpoint, or God forbid, phasic.
	var/advanced_print_req = FALSE

// whatever goblin decided to spread out bullets over like 3 files and god knows however many overrides i wish you a very stubbed toe

/*
*	.460 Ceres (renamed tgcode .45)
*/

/obj/item/ammo_casing/c45/rubber
	name = ".460 Ceres rubber bullet casing"
	desc = "A .460 bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c45/rubber
	harmful = FALSE

/obj/projectile/bullet/c45/rubber
	name = ".460 Ceres rubber bullet"
	damage = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/c45/hp
	name = ".460 Ceres hollow-point bullet casing"
	desc = "A .460 hollow-point bullet casing. Very lethal against unarmored opponents. Suffers against armor."
	projectile_type = /obj/projectile/bullet/c45/hp
	advanced_print_req = TRUE

/obj/projectile/bullet/c45/hp
	name = ".460 Ceres hollow-point bullet"
	damage = 40
	weak_against_armour = TRUE

/*
*	8mm Usurpator (renamed tg c46x30mm, used in the WT550)
*/

/obj/projectile/bullet/c46x30mm_rubber
	name = "8mm Usurpator rubber bullet"
	damage = 3
	stamina = 17
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/c46x30mm/rubber
	name = "8mm Usurpator rubber bullet casing"
	desc = "An 8mm Usurpator rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber
	harmful = FALSE

/*
*	.277 Aestus (renamed tgcode .223, used in the M-90gl)
*/

/obj/item/ammo_casing/a223/rubber
	name = ".277 rubber bullet casing"
	desc = "A .277 rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/a223/rubber
	harmful = FALSE

/obj/projectile/bullet/a223/rubber
	name = ".277 rubber bullet"
	damage = 10
	armour_penetration = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/a223/ap
	name = ".277 Aestus armor-piercing bullet casing"
	desc = "A .277 armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR PIERCING: Increased armor piercing capabilities. What did you expect?"
	projectile_type = /obj/projectile/bullet/a223/ap
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a223/ap
	name = ".277 armor-piercing bullet"
	armour_penetration = 60

/*
*	.34 ACP
*/

// Why? Blame CFA, they want their bullets to be *proprietary*
/obj/item/ammo_casing/c34
	name = ".34 bullet casing"
	desc = "A .34 bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34

/obj/projectile/bullet/c34
	name = ".34 bullet"
	damage = 15
	wound_bonus = 0

/obj/item/ammo_casing/c34/rubber
	name = ".34 rubber bullet casing"
	desc = "A .34 rubber bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34/rubber
	harmful = FALSE

/obj/projectile/bullet/c34/rubber
	name = ".34 rubber bullet"
	damage = 5
	stamina = 20
	wound_bonus = -75
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/c34/ap
	name = ".34 armor-piercing bullet casing"
	desc = "A .34 armor-piercing bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/c34/ap
	name = ".34 armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	wound_bonus = -75

/obj/item/ammo_casing/c34_incendiary
	name = ".34 incendiary bullet casing"
	desc = "A .34 incendiary bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/incendiary/c34_incendiary
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/projectile/bullet/incendiary/c34_incendiary
	name = ".34 incendiary bullet"
	damage = 8
	fire_stacks = 1
	wound_bonus = -90

/obj/item/ammo_casing/a40mm/rubber
	name = "40mm rubber shell"
	desc = "A cased rubber slug. The big brother of the beanbag slug, this thing will knock someone out in one. Doesn't do so great against anyone in armor."
	projectile_type = /obj/projectile/bullet/shotgun_beanbag/a40mm

/obj/item/ammo_casing/rocket
	name = "\improper Dardo HE rocket"
	desc = "An 84mm High Explosive rocket. Fire at people and pray."
	caliber = CALIBER_84MM
	icon_state = "srm-8"
	base_icon_state = "srm-8"
	projectile_type = /obj/projectile/bullet/rocket

/obj/item/ammo_casing/rocket/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/rocket/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]"

/obj/item/ammo_casing/rocket/heap
	name = "\improper Dardo HE-AP rocket"
	desc = "An 84mm High Explosive All Purpose rocket. For when you just need something to not exist anymore."
	icon_state = "84mm-heap"
	base_icon_state = "84mm-heap"
	projectile_type = /obj/projectile/bullet/rocket/heap

/obj/item/ammo_casing/rocket/weak
	name = "\improper Dardo HE Low-Yield rocket"
	desc = "An 84mm High Explosive rocket. This one isn't quite as devastating."
	icon_state = "low_yield_rocket"
	base_icon_state = "low_yield_rocket"
	projectile_type = /obj/projectile/bullet/rocket/weak

/obj/item/ammo_casing/strilka310
	name = ".310 Strilka bullet casing"
	desc = "A .310 Strilka bullet casing. Casing is a bit of a fib, there is no case, its just a block of red powder."
	icon_state = "310-casing"
	caliber = CALIBER_STRILKA310
	projectile_type = /obj/projectile/bullet/strilka310

/obj/item/ammo_casing/strilka310/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/strilka310/surplus
	name = ".310 Strilka surplus bullet casing"
	desc = "A surplus .310 Strilka bullet casing. Casing is a bit of a fib, there is no case, its just a block of red powder. Damp red powder at that."
	projectile_type = /obj/projectile/bullet/strilka310/surplus

/obj/projectile/bullet/strilka310
	name = ".310 Strilka bullet"
	damage = 60
	armour_penetration = 10
	wound_bonus = -45
	wound_falloff_tile = 0

/obj/projectile/bullet/strilka310/surplus
	name = ".310 Strilka surplus bullet"
	weak_against_armour = TRUE //this is specifically more important for fighting carbons than fighting noncarbons. Against a simple mob, this is still a full force bullet
	armour_penetration = 0

/*
*	9x25mm Mk.12
*/

/obj/item/ammo_casing/c9mm
	name = "9x25mm Mk.12 bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing."

/obj/item/ammo_casing/c9mm/ap
	name = "9x25mm Mk.12 armor-piercing bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires an armor-piercing projectile."
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/hp
	name = "9x25mm Mk.12 hollow-point bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a hollow-point projectile. Very lethal to unarmored opponents."
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/fire
	name = "9x25mm Mk.12 incendiary bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This incendiary round leaves a trail of fire and ignites its target."
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/ihdf
	name = "9x25mm Mk.12 IHDF casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a bullet of 'Intelligent High-Impact Dispersal Foam', which is best compared to a riot-grade foam dart."
	projectile_type = /obj/projectile/bullet/c9mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/c9mm/ihdf
	name = "9x25mm IHDF bullet"
	damage = 30
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/item/ammo_casing/c9mm/rubber
	name = "9x25mm Mk.12 rubber casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This less than lethal round sure hurts to get shot by, but causes little physical harm."
	projectile_type = /obj/projectile/bullet/c9mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c9mm/rubber
	name = "9x25mm rubber bullet"
	icon_state = "pellet"
	damage = 5
	stamina = 25
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/*
*	10mm Auto
*/

/obj/item/ammo_casing/c10mm/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/hp
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/fire
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/reaper
	can_be_printed = FALSE
	// it's a hitscan 50 damage 40 AP bullet designed to be fired out of a gun with a 2rnd burst and 1.25x damage multiplier
	// Let's Not

/obj/item/ammo_casing/c10mm/rubber
	name = "10mm rubber bullet casing"
	desc = "A 10mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = 10
	stamina = 35
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/c10mm/ihdf
	name = "10mm IHDF bullet casing"
	desc = "A 10mm intelligent high-impact dispersal foam bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/c10mm/ihdf
	name = "10mm IHDF bullet"
	damage = 40
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/projectile/bullet/shotgun_beanbag/a40mm
	name = "rubber slug"
	icon_state = "cannonball"
	damage = 20
	stamina = 160 //BONK
	wound_bonus = 30
	weak_against_armour = TRUE
