/mob/living/basic/bloodling/harvester
	name = "harvester"
	desc = "A mass of flesh in a vague shape, it has two large talons for harvesting."
	health = 100
	maxHealth = 100
	melee_damage_lower = 15
	melee_damage_upper = 15
	speed = 0.5

	biomass = 0
	biomass_max = 200
	initial_powers = list(
		/datum/action/cooldown/mob_cooldown/bloodling/absorb,
	)

/mob/living/basic/bloodling/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
