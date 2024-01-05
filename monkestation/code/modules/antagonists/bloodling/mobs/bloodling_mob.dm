/mob/living/basic/bloodling
	name = "bloodling"
	desc = "A disgusting mass of bone and flesh. It reaches out around it with fleshy tendrils."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "maint_spider"
	icon_living = "maint_spider"
	icon_dead = "maint_spider_dead"
	gender = NEUTER
	health = 1
	maxHealth = 1
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	faction = list(FACTION_CREATURE)
	obj_damage = 0
	speed = 2.8
	environment_smash = ENVIRONMENT_SMASH_NONE
	mob_biotypes = MOB_ORGANIC
	speak_emote = list("spews")
	damage_coeff = list(BRUTE = 1, BURN = 1.25, TOX = 1, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	sight = SEE_SELF|SEE_MOBS
	faction = list(FACTION_BLOODLING)
	pass_flags = PASSTABLE
	attack_sound = 'sound/effects/attackblob.ogg'

	// The amount of biomass our bloodling has
	var/biomass = 1
	// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 500

/mob/living/basic/bloodling/Initialize(mapload)
	. = ..()
	create_abilities()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	RegisterSignal(src, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_damaged))

/// Checks for damage to update the bloodlings biomass accordingly
/mob/living/basic/bloodling/proc/on_damaged(datum/source, damage, damagetype)
	SIGNAL_HANDLER

	// Stamina damage is fucky, so we ignore it
	if(damagetype == STAMINA)
		return

	src.add_biomass(-damage)

/// Used for adding biomass to the bloodling since health needs updating accordingly
/// ARGUEMENTS:
/// amount-The amount of biomass to be added or subtracted
/mob/living/basic/bloodling/proc/add_biomass(amount)
	if(biomass > biomass_max)
		src.biomass = biomass_max
		balloon_alert(src, "already maximum biomass")
		return
	src.biomass += amount
	src.maxHealth = biomass
	src.health = biomass
	update_health_hud()

/// Creates the bloodlings abilities
/mob/living/basic/bloodling/proc/create_abilities()
	var/datum/action/cooldown/bloodling/hide/hide = new(src)
	hide.Grant(src)
	var/datum/action/cooldown/bloodling/absorb/absorb = new(src)
	absorb.Grant(src)

