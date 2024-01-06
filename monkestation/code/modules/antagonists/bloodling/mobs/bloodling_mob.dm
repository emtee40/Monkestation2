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
	basic_mob_flags = FLAMMABLE_MOB
	sight = SEE_SELF|SEE_MOBS
	faction = list(FACTION_BLOODLING)
	pass_flags = PASSTABLE
	attack_sound = 'sound/effects/attackblob.ogg'

	/// The amount of biomass our bloodling has
	var/biomass = 1
	/// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 500
	/// The evolution level our bloodling is on
	var/evolution_level = 1

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

	add_biomass(-damage)
	// Heals up their damage
	heal_and_revive(0)

/// Used for adding biomass to the bloodling since health needs updating accordingly
/// ARGUEMENTS:
/// amount-The amount of biomass to be added or subtracted
/mob/living/basic/bloodling/proc/add_biomass(amount)
	if(biomass + amount <= 0)
		gib()
	if(biomass + amount >= biomass_max)
		biomass = biomass_max
		balloon_alert(src, "already maximum biomass")
		return
	biomass += amount
	maxHealth = biomass
	obj_damage = biomass * 0.2
	// less than 5 damage would be very bad
	if(biomass > 50)
		melee_damage_lower = biomass * 0.1
		melee_damage_upper = biomass * 0.1
	update_health_hud()
	check_evolution()
	// Health needs to be updated to our biomass levels, this does NOT heal up damage
	health = biomass

/// Creates the bloodlings abilities
/mob/living/basic/bloodling/proc/create_abilities()
	var/datum/action/cooldown/bloodling/hide/hide = new(src)
	hide.Grant(src)
	var/datum/action/cooldown/bloodling/absorb/absorb = new(src)
	absorb.Grant(src)
	return

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
			new_bloodling = new /mob/living/basic/bloodling/tier2(src.loc)
		if(4)
			new_bloodling = new /mob/living/basic/bloodling/tier2(src.loc)
		if(5)
			new_bloodling = new /mob/living/basic/bloodling/tier2(src.loc)
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

/mob/living/basic/bloodling/tier2/create_abilities()
	..()
