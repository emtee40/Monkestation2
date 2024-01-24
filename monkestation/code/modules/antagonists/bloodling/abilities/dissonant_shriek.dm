/datum/action/cooldown/bloodling/dissonant_shriek
	name = "Dissonant Shriek"
	desc = "We release a sound that disrupts nearby electronics. Costs 20 biomass."
	button_icon_state = "dissonant_shriek"
	biomass_cost = 20
	cooldowns = 20 SECONDS

/datum/action/cooldown/bloodling/dissonant_shriek/Activate(atom/target)
	..()
	if(owner.movement_type & VENTCRAWLING)
		owner.balloon_alert(owner, "can't shriek in pipes!")
		return FALSE
	empulse(get_turf(owner), 2, 5, 1)
	for(var/obj/machinery/light/L in range(5, usr))
		L.on = TRUE
		L.break_light_tube()
		stoplag()

	return TRUE
