// Handles general fixes for all forms of mobs and species \\
// For modularity purposes, this will load first before all other monkeystation modules \\

/mob/living/carbon/human/dummy/extra_tall/Destroy() //Ensure that dummies are correctly removing extra_bodyparts.
	QDEL_NULL(extra_bodyparts)
	return ..()

/datum/interaction_mode/combat_mode/Destroy(force, ...)
	combat_mode = null
	QDEL_NULL(held_hud) // Monkeystation Edit. Ensure this always qdels the hud in question.
	return ..()
