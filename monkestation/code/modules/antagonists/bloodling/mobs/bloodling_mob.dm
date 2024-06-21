/mob/living/basic/bloodling
	name = "abstract bloodling"
	desc = "A disgusting mass of code and flesh. Report this as an issue if you see it."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "maint_spider"
	icon_living = "maint_spider"
	icon_dead = "maint_spider_dead"
	gender = NEUTER
	health = 50
	maxHealth = 50
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	obj_damage = 0
	speed = 2.8
	environment_smash = ENVIRONMENT_SMASH_NONE
	mob_biotypes = MOB_ORGANIC
	speak_emote = list("spews")
	basic_mob_flags = FLAMMABLE_MOB | DEL_ON_DEATH
	faction = list(FACTION_BLOODLING)
	pass_flags = PASSTABLE
	attack_sound = 'sound/effects/attackblob.ogg'
	/// Loot this mob drops on death.
	var/list/loot = list(/obj/effect/gibspawner/generic)
	/// The amount of biomass our bloodling has
	var/biomass = 1
	/// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 1
	/// The abilities this bloodling starts with
	var/list/initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
	)

/mob/living/basic/bloodling/Initialize(mapload)
	. = ..()
	create_abilities()
	AddElement(/datum/element/death_drops, loot)

/mob/living/basic/bloodling/get_status_tab_items()
	. = ..()
	. += "Current Biomass: [biomass >= biomass_max ? biomass : "[biomass] / [biomass_max]"] B"

/// Used for adding biomass to every bloodling type
/// ARGUEMENTS:
/// amount-The amount of biomass to be added or subtracted
/mob/living/basic/bloodling/proc/add_biomass(amount)
	if(biomass + amount >= biomass_max)
		biomass = biomass_max
		balloon_alert(src, "already maximum biomass")
		return

	biomass += amount

/// Creates the bloodlings abilities
/mob/living/basic/bloodling/proc/create_abilities()
	for(var/datum/action/path as anything in initial_powers)
		var/datum/action/bloodling_action = new path()
		bloodling_action.Grant(src)

//////////////////// The actual bloodling mob ////////////////////
/mob/living/basic/bloodling/proper
	name = "mass of flesh"
	desc = "An abomination of some spawn. A mess of tendrils, mouths and chitin, whatever created it was not merciful."
	maxHealth = INFINITE // Bloodlings have unlimited health, instead biomass acts as their health
	health = INFINITE
	sight = SEE_SELF|SEE_MOBS
	hud_type = /datum/hud/bloodling

	biomass = 50
	biomass_max = 750
	/// The evolution level our bloodling is on
	var/evolution_level = 0

/mob/living/basic/bloodling/proper/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_damaged))
	// All evolutions over 2 (3,4,5) are spess proof
	if(evolution_level > 2)
		ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/basic/bloodling/proper/adjust_health(amount, updating_health = TRUE, forced = FALSE)
	if(!forced)
		return 0

	. = amount

	add_biomass(amount)
	if(updating_health)
		update_health_hud()

	return .

/mob/living/basic/bloodling/proper/update_health_hud()
	. = ..()
	var/biomass_next_evo

	switch(evolution_level)
		if(1)
			biomass_next_evo = 75
		if(2)
			biomass_next_evo = 125
		if(3)
			biomass_next_evo = 175
		if(4)
			biomass_next_evo = 225
		if(5)
			biomass_next_evo = biomass_max

	if(hud_used?.action_intent)
		hud_used.action_intent.maptext = MAPTEXT("Your biomass: [biomass] / [biomass_next_evo] \n")
		hud_used.action_intent.maptext_height = 400
		hud_used.action_intent.maptext_width = 400
		hud_used.action_intent.maptext_y = 64
		hud_used.action_intent.maptext_x = -64

// Bloodlings health and damage needs updating when biomass is added
/mob/living/basic/bloodling/proper/add_biomass(amount)
	. = ..()
	if(biomass <= 0)
		gib()
	// Damage is based on biomass, and handled here
	obj_damage = biomass * 0.2
	// less than 5 damage would be very bad
	if(biomass > 50)
		melee_damage_lower = biomass * 0.1
		melee_damage_upper = biomass * 0.1
	update_health_hud()
	check_evolution()

/// Checks if we should evolve, and also calls the evolution proc
/mob/living/basic/bloodling/proper/proc/check_evolution()
	if((75 > biomass) && (evolution_level != 1))
		evolution(1)
		return TRUE
	if((125 > biomass >= 75) && (evolution_level != 2))
		evolution(2)
		return TRUE
	if((175 > biomass) >= 125 && (evolution_level != 3))
		evolution(3)
		return TRUE
	if((225 > biomass >= 175) && (evolution_level != 4))
		evolution(4)
		return TRUE
	if((biomass >= 225) && (evolution_level != 5))
		evolution(5)
		return TRUE
	return FALSE

/// Creates the mob for us to then mindswap into
/mob/living/basic/bloodling/proper/proc/evolution(tier)
	/// What bloodling we are going to spawn
	var/new_bloodling = null
	if(evolution_level > tier)
		visible_message(
			span_alertalien("[src] begins to shrink!"),
			span_noticealien("You devolve!"),
		)

	else
		visible_message(
			span_alertalien("[src] begins to grow!"),
			span_noticealien("You evolve!"),
		)

	switch(tier)
		if(1)
			new_bloodling = new /mob/living/basic/bloodling/proper/tier1/(src.loc)
		if(2)
			new_bloodling = new /mob/living/basic/bloodling/proper/tier2(src.loc)
		if(3)
			new_bloodling = new /mob/living/basic/bloodling/proper/tier3(src.loc)
		if(4)
			new_bloodling = new /mob/living/basic/bloodling/proper/tier4(src.loc)
		if(5)
			new_bloodling = new /mob/living/basic/bloodling/proper/tier5(src.loc)
	evolution_mind_change(new_bloodling)


/mob/living/basic/bloodling/proper/proc/evolution_mind_change(mob/living/basic/bloodling/proper/new_bloodling)
	new_bloodling.setDir(dir)
	if(numba)
		new_bloodling.numba = numba
		new_bloodling.set_name()
	new_bloodling.name = name
	new_bloodling.real_name = real_name
	if(mind)
		mind.name = new_bloodling.real_name
		mind.transfer_to(new_bloodling)
	new_bloodling.add_biomass(biomass)
	qdel(src)

/// Checks for damage to update the bloodlings biomass accordingly
/mob/living/basic/bloodling/proper/proc/on_damaged(datum/source, damage, damagetype)
	SIGNAL_HANDLER

	var/damage_amount = damage
	// Stamina damage is fucky, so we'll ignore it
	if(damagetype == STAMINA)
		return

	if(damagetype == BURN)
	// Bloodlings take additional burning damage
		damage_amount *= 1.5

	// Bloodlings take damage through their biomass, not regular damage
	add_biomass(-damage_amount)

/mob/living/basic/bloodling/proper/Destroy()
	UnregisterSignal(src, COMSIG_MOB_APPLY_DAMAGE)

	return ..()

/mob/living/basic/bloodling/proper/tier1
	evolution_level = 1
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/sneak/bloodling,
		/datum/action/cooldown/bloodling_hivespeak,
	)
	speed = 0.5

/mob/living/basic/bloodling/proper/tier1/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/bloodling/proper/tier2
	icon_state = "guard"
	icon_living = "guard"
	evolution_level = 2
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/sneak/bloodling,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/bloodling_hivespeak,
	)
	speed = 1

/mob/living/basic/bloodling/proper/tier3
	icon_state = "scout"
	icon_living = "scout"
	evolution_level = 3
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/mob_cooldown/bloodling/devour,
		/datum/action/cooldown/bloodling_hivespeak,
	)
	speed = 1.5

/mob/living/basic/bloodling/proper/tier4
	icon_state = "ambush"
	icon_living = "ambush"
	evolution_level = 4
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/mob_cooldown/bloodling/devour,
		/datum/action/cooldown/bloodling/dissonant_shriek,
		/datum/action/cooldown/spell/aoe/repulse/bloodling,
		/datum/action/cooldown/mob_cooldown/bloodling/transfer_biomass,
		/datum/action/cooldown/mob_cooldown/bloodling/heal,
		/datum/action/cooldown/mob_cooldown/bloodling/give_life,
		/datum/action/cooldown/bloodling_hivespeak,
	)
	speed = 2

/mob/living/basic/bloodling/proper/tier5
	icon_state = "hunter"
	icon_living = "hunter"
	evolution_level = 5
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/bloodling/ascension,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/mob_cooldown/bloodling/devour,
		/datum/action/cooldown/bloodling/dissonant_shriek,
		/datum/action/cooldown/spell/aoe/repulse/bloodling,
		/datum/action/cooldown/mob_cooldown/bloodling/transfer_biomass,
		/datum/action/cooldown/mob_cooldown/bloodling/heal,
		/datum/action/cooldown/mob_cooldown/bloodling/give_life,
		/datum/action/cooldown/bloodling_hivespeak,
	)
	speed = 2.5
