/datum/action/holoparasite/communicate
	name = "Communicate"
	desc = "Communicate telepathically with your summoner. Nobody except yourself, your summoner, and any other holoparasites linked to your summoner can hear this communication.\nYou can also use :p / .p in order to communicate."
	button_icon_state = "communicate"

/datum/action/holoparasite/communicate/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/holoparasite/user = usr
	if(!istype(user))
		return FALSE
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob/living/basic/holoparasite, communicate))
