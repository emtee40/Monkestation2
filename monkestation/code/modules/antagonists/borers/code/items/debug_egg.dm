/obj/effect/mob_spawn/ghost_role/borer_egg/debug
	name = "debug cortical borer egg"
	desc = "An egg of a creature that is known to crawl inside of you. This one looks REALLY DANGEROUS. Consider calling nuclear operatives."
	mob_type = /mob/living/basic/cortical_borer/debug

/mob/living/basic/cortical_borer/debug
	known_abilities = list(
		/datum/action/cooldown/borer/toggle_hiding,
		/datum/action/cooldown/borer/choosing_host,
		/datum/action/cooldown/borer/evolution_tree,
		/datum/action/cooldown/borer/inject_chemical,
		/datum/action/cooldown/borer/upgrade_chemical,
		/datum/action/cooldown/borer/learn_focus,
		/datum/action/cooldown/borer/upgrade_stat,
		/datum/action/cooldown/borer/force_speak,
		/datum/action/cooldown/borer/fear_human,
		/datum/action/cooldown/borer/check_blood,

		/datum/action/cooldown/borer/gain_evolution_point,
		/datum/action/cooldown/borer/gain_chemical_point,
	)
