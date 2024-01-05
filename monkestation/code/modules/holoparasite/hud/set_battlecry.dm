/datum/action/holoparasite/set_battlecry
	name = "Set Battlecry"
	desc = "Set (or disable) your battlecry - the phrase you shout out whenever you hit something."
	button_icon_state = "ora"

/datum/action/holoparasite/set_battlecry/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/holoparasite/user = usr
	if(!istype(user))
		return FALSE
	//INVOKE_ASYNC(user, TYPE_PROC_REF(/mob/living/basic/holoparasite, set_battlecry_v))
