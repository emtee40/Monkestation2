/datum/action/cooldown/bloodling
	name = "debug"
	desc = "Yell at coders if you see this"
	// The biomass cost of the ability
	var/biomass_cost = 0

/datum/action/cooldown/bloodling/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/bloodling/bloodling = IS_BLOODLING(owner)
	if(!bloodling)
		return FALSE
	if(bloodling.biomass < biomass_cost)
		return FALSE
	return TRUE

/datum/action/cooldown/bloodling/PreActivate(atom/target)
	// Parent calls Activate(), so if parent returns TRUE,
	// it means the activation happened successfuly by this point
	. = ..()
	if(!.)
		return FALSE
	// Since bloodlings evolve it may result in them or their abilities going away
	// so we can just return true here
	if(QDELETED(src) || QDELETED(owner))
		return TRUE

	var/datum/antagonist/bloodling/bloodling = IS_BLOODLING(owner)
	bloodling.biomass -= biomass_cost
	if(click_to_activate && bloodling.biomass < biomass_cost)
		unset_click_ability(owner, refund_cooldown = FALSE)

	return TRUE
