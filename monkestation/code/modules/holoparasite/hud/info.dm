/datum/action/holoparasite/info
	name = "Info"
	desc = "View information about yourself and your summoner."
	button_icon_state = "info"

/datum/action/holoparasite/info/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/holoparasite/holopara_antag = usr.mind?.has_antag_datum(/datum/antagonist/holoparasite)
	holopara_antag?.ui_interact(owner)
