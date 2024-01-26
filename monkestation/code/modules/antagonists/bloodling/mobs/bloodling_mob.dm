/mob/living/basic/bloodling
	name = "bloodling"
	desc = "A disgusting mass of bone and flesh. It reaches out around it with fleshy tendrils."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "maint_spider"
	icon_living = "maint_spider"
	icon_dead = "maint_spider_dead"
	gender = NEUTER
	health = INFINITY //Bloodlings don't use health, they use biomass instead
	maxHealth = INFINITY
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
	basic_mob_flags = FLAMMABLE_MOB
	sight = SEE_SELF|SEE_MOBS
	faction = list(FACTION_BLOODLING)
	pass_flags = PASSTABLE
	attack_sound = 'sound/effects/attackblob.ogg'

	/// The amount of biomass our bloodling has
	var/biomass = 50
	/// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 500
	/// The evolution level our bloodling is on
	var/evolution_level = 1
	/// The abilities this bloodling starts with
	var/list/initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/bloodling/hide,
	)

/mob/living/basic/bloodling/Initialize(mapload)
	. = ..()
	create_abilities()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	RegisterSignal(src, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(src, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_damaged))

/mob/living/basic/bloodling/get_status_tab_items()
	. = ..()
	. += "Current Biomass: [biomass >= biomass_max ? biomass : "[biomass] / [biomass_max]"] E"

/mob/living/basic/bloodling/adjust_health(amount, updating_health = TRUE, forced = FALSE)
	if(!forced)
		return 0

	. = amount

	add_biomass(amount)
	if(updating_health)
		update_health_hud()

	return .

/// On_life proc that checks their amount of biomass
/mob/living/basic/bloodling/proc/on_life(seconds_per_tick = SSMOBS_DT, times_fired)
	SIGNAL_HANDLER

	if(biomass <= 0)
		gib()
		return

/// Our health hud is based on biomass, since our health is infinite
/mob/living/basic/bloodling/update_health_hud()
	if(isnull(hud_used))
		return

	hud_used.healths.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='red'>[biomass]E</font></div>")

/// Checks for damage to update the bloodlings biomass accordingly
/mob/living/basic/bloodling/proc/on_damaged(datum/source, damage, damagetype)
	SIGNAL_HANDLER

	// Stamina damage is fucky, so we ignore it
	if(damagetype == STAMINA)
		return

	// Bloodlings take damage through their biomass, not regular damage
	add_biomass(-damage)

/// Used for adding biomass to the bloodling since health needs updating accordingly
/// ARGUEMENTS:
/// amount-The amount of biomass to be added or subtracted
/mob/living/basic/bloodling/proc/add_biomass(amount)
	if(biomass + amount >= biomass_max)
		biomass = biomass_max
		balloon_alert(src, "already maximum biomass")
		return

	biomass += amount

	// Damage is based on biomass, and handled here
	obj_damage = biomass * 0.2
	// less than 5 damage would be very bad
	if(biomass > 50)
		melee_damage_lower = biomass * 0.1
		melee_damage_upper = biomass * 0.1
	update_health_hud()
	check_evolution()

/// Creates the bloodlings abilities
/mob/living/basic/bloodling/proc/create_abilities()
	for(var/datum/action/path as anything in initial_powers)
		var/datum/action/bloodling_action = new path()
		bloodling_action.Grant(src)


/// Checks if we should evolve
/mob/living/basic/bloodling/proc/check_evolution()
	if(75 > biomass && evolution_level != 1)
		evolution(1)
		return
	if(125 > biomass >= 75 && evolution_level != 2)
		evolution(2)
		return
	if(175 > biomass >= 125 && evolution_level != 3)
		evolution(3)
		return
	if(225 > biomass >= 175 && evolution_level != 4)
		evolution(4)
		return
	if(biomass >= 225 && evolution_level != 5)
		evolution(5)
		return

/// Creates the mob for us to then mindswap into
/mob/living/basic/bloodling/proc/evolution(tier)
	var/new_bloodling = null
	switch(tier)
		if(1)
			new_bloodling = new /mob/living/basic/bloodling(src.loc)
		if(2)
			new_bloodling = new /mob/living/basic/bloodling/tier2(src.loc)
		if(3)
			new_bloodling = new /mob/living/basic/bloodling/tier3(src.loc)
		if(4)
			new_bloodling = new /mob/living/basic/bloodling/tier4(src.loc)
		if(5)
			new_bloodling = new /mob/living/basic/bloodling/tier5(src.loc)
	evolution_mind_change(new_bloodling)


/mob/living/basic/bloodling/proc/evolution_mind_change(var/mob/living/basic/bloodling/new_bloodling)
	visible_message(
		span_alertalien("[src] begins to grow!"),
		span_noticealien("You evolve!"),
	)
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

/mob/living/basic/bloodling/tier2
	icon_state = "guard"
	icon_living = "guard"
	evolution_level = 2
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/bloodling/hide,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
	)

/mob/living/basic/bloodling/tier3
	icon_state = "scout"
	icon_living = "scout"
	evolution_level = 3
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/mob_cooldown/bloodling/devour,
	)

/mob/living/basic/bloodling/tier4
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
	)

/mob/living/basic/bloodling/tier5
	icon_state = "hunter"
	icon_living = "hunter"
	evolution_level = 5
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
		/datum/action/cooldown/mob_cooldown/bloodling/infest,
		/datum/action/cooldown/bloodling/build,
		/datum/action/cooldown/mob_cooldown/bloodling/devour,
		/datum/action/cooldown/bloodling/dissonant_shriek,
		/datum/action/cooldown/spell/aoe/repulse/bloodling,
	)
