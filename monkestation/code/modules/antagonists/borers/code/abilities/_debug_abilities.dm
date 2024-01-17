/datum/action/cooldown/borer/gain_evolution_point
	name = "DEBUG: Gain an evolution point"
	button_icon_state = "level"

/datum/action/cooldown/borer/gain_evolution_point/Trigger(trigger_flags, atom/target)
	. = ..()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	cortical_owner.stat_evolution++
	to_chat(src, span_notice("You gain a stat evolution point. Spend it to become stronger!"))

/datum/action/cooldown/borer/gain_chemical_point
	name = "DEBUG: Gain maximum possible chemicals"
	button_icon_state = "level"

/datum/action/cooldown/borer/gain_chemical_point/Trigger(trigger_flags, atom/target)
	. = ..()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	cortical_owner.chemical_evolution++
	to_chat(src, span_notice("You gain a chemical evolution point. Spend it to learn a new chemical!"))
