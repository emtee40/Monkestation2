/datum/action/cooldown/bloodling/hide
	name = "Hide"
	desc = "Allows you to hide beneath tables and certain objects."
	button_icon_state = "alien_hide"
	/// The layer we are on while hiding
	var/hide_layer = BULLET_HOLE_LAYER

/datum/action/cooldown/bloodling/hide/Activate(atom/target)
	if(owner.layer == hide_layer)
		owner.layer = initial(owner.layer)
		owner.visible_message(
			span_notice("[owner] slowly peeks up from the ground..."),
			span_changeling("You stop hiding."),
		)

	else
		owner.layer = hide_layer
		owner.visible_message(
			span_name("[owner] scurries to the ground!"),
			span_changeling("You are now hiding."),
		)

	return TRUE
