/datum/action/cooldown/bloodling/enhanced_vision
	name = "Enhanced Vision"
	desc = "Creates thermal sensing rods in our eyes, allowing our vision to see thermal signatures through most blocking objects"
	button_icon_state = "augmented_eyesight"

/datum/action/cooldown/bloodling/enhanced_vision/Activate(atom/target)
	if(owner.sight = SEE_MOBS)
		owner.sight -= SEE_MOBS
		to_chat(owner, span_notice("We adjust our sight back to normal."))
		return TRUE
	owner.sight += SEE_MOBS
	to_chat(owner, span_notice("We adjust our sight to sense thermal imprints."))
