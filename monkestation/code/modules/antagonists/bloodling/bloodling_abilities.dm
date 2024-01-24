/datum/action/cooldown/mob_cooldown/bloodling
	name = "debug"
	desc = "Yell at coders if you see this"
	/// The biomass cost of the ability
	var/biomass_cost = 0

/datum/action/cooldown/mob_cooldown/bloodling/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	// Basically we only want bloodlings to have this
	if(!istype(owner, /mob/living/basic/bloodling))
		return FALSE
	var/mob/living/basic/bloodling/our_mob = owner
	if(our_mob.biomass <= biomass_cost)
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/bloodling/PreActivate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	// Parent calls Activate(), so if parent returns TRUE,
	// it means the activation happened successfuly by this point
	. = ..()
	if(!.)
		return FALSE
	// Since bloodlings evolve it may result in them or their abilities going away
	// so we can just return true here
	if(QDELETED(src) || QDELETED(owner))
		return TRUE

	our_mob.add_biomass(-biomass_cost)

	return TRUE

// A non mob version for certain abilities (mainly hide, build, slam, shriek, whiplash)
/datum/action/cooldown/bloodling
	name = "debug"
	desc = "Yell at coders if you see this"
	// The biomass cost of the ability
	var/biomass_cost = 0

/datum/action/cooldown/bloodling/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	// Basically we only want bloodlings to have this
	if(!istype(owner, /mob/living/basic/bloodling))
		return FALSE
	var/mob/living/basic/bloodling/our_mob = owner
	if(our_mob.biomass <= biomass_cost)
		return FALSE
	return TRUE

/datum/action/cooldown/bloodling/PreActivate(atom/target)
	var/mob/living/basic/bloodling/our_mob = owner
	// Parent calls Activate(), so if parent returns TRUE,
	// it means the activation happened successfuly by this point
	. = ..()
	if(!.)
		return FALSE
	// Since bloodlings evolve it may result in them or their abilities going away
	// so we can just return true here
	if(QDELETED(src) || QDELETED(owner))
		return TRUE

	our_mob.add_biomass(-biomass_cost)

	return TRUE
