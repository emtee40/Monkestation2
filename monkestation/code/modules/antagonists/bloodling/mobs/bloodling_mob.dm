/mob/living/basic/bloodling
	name = "bloodling"
	desc = "A disgusting mass of bone and flesh. It reaches out around it with fleshy tendrils."
	icon = 'icons/mob/simple/arachnoid.dmi'
	mob_biotypes = MOB_ORGANIC
	speak_emote = list("spews")
	butcher_results = list(/obj/item/food/meat/slab = 2)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	melee_attack_cooldown = CLICK_CD_MELEE
	damage_coeff = list(BRUTE = 1, BURN = 1.25, TOX = 1, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	status_flags = NONE
	sight = SEE_SELF|SEE_MOBS
	unsuitable_cold_damage = 1
	unsuitable_heat_damage = 1
	faction = list(FACTION_BLOODLING)
	pass_flags = PASSTABLE
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/effects/attackblob.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	lighting_cutoff_red = 22
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 5
	health = 100
	maxHealth = 100
	speed = 5

	/// The abilities the bloodling start with
	var/static/list/abilities = list(
		/datum/action/cooldown/bloodling/hide,
	)
	// The amount of biomass our bloodling has
	var/biomass = 0
	// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 500

/mob/living/basic/bloodling/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	for (var/datum/action/cooldown/created_action in abilities)
		new created_action ()
		created_action.Grant(src)
