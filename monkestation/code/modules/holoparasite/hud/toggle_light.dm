/datum/action/innate/holoparasite/toggle_light
	name = "Enable Light"
	desc = "Turn on your internal crystalline light, allowing you to glow like star dust. This light will even work while recalled to your summoner."
	button_icon_state = "light"
	var/static/off_name = "Turn Off Light"
	var/static/off_desc = "Disable your internal crystalline light, allowing you to more easily hide amongst the darkness."

/datum/action/innate/holoparasite/toggle_light/Grant(mob/living/basic/holoparasite/owner)
	. = ..()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_LIGHT_RANGE, PROC_REF(update_light_status))

/datum/action/innate/holoparasite/toggle_light/Remove(mob/living/basic/holoparasite/owner)
	. = ..()
	UnregisterSignal(owner, COMSIG_ATOM_UPDATE_LIGHT_RANGE)

/datum/action/innate/holoparasite/toggle_light/Activate()
	// ... turn on light

/datum/action/innate/holoparasite/toggle_light/Deactivate()
	// ... turn off light

/datum/action/innate/holoparasite/toggle_light/proc/update_light_status(mob/living/basic/holoparasite/owner)
	SIGNAL_HANDLER
	if(owner.light_outer_range > 1)
		active = TRUE
		name = off_name
		desc = off_desc
	else
		active = FALSE
		name = initial(name)
		desc = initial(desc)
	build_all_button_icons(UPDATE_BUTTON_NAME | UPDATE_BUTTON_STATUS)
