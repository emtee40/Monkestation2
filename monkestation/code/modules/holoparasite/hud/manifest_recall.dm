/datum/action/innate/holoparasite/manifest_recall
	name = "Info"
	desc = "Manifest from your summoner, appearing behind them, allowing you to fight alongside them."
	button_icon_state = "manifest"
	var/static/recall_name = "Recall"
	var/static/recall_desc = "Return to your summoner, demanifesting from the world around you."
	var/static/recall_icon = "recall"

/datum/action/innate/holoparasite/manifest_recall/Grant(mob/living/basic/holoparasite/owner)
	. = ..()
	RegisterSignal(owner, COMSIG_HOLOPARA_POST_MANIFEST, PROC_REF(on_manifest))
	RegisterSignal(owner, COMSIG_HOLOPARA_RECALL, PROC_REF(on_recall))

/datum/action/innate/holoparasite/manifest_recall/Remove(mob/living/basic/holoparasite/owner)
	. = ..()
	UnregisterSignal(owner, list(COMSIG_HOLOPARA_POST_MANIFEST, COMSIG_HOLOPARA_RECALL))

/datum/action/innate/holoparasite/manifest_recall/Activate()
	var/mob/living/basic/holoparasite/user = owner
	user.manifest()

/datum/action/innate/holoparasite/manifest_recall/Deactivate()
	var/mob/living/basic/holoparasite/user = owner
	user.recall()

/datum/action/innate/holoparasite/manifest_recall/IsAvailable(feedback = FALSE)
	var/mob/living/basic/holoparasite/user = owner
	return ..() && !user.parent_holder?.locked

/datum/action/innate/holoparasite/manifest_recall/proc/on_manifest(mob/living/basic/holoparasite/source)
	SIGNAL_HANDLER
	active = TRUE
	name = recall_name
	desc = recall_desc
	button_icon_state = recall_icon
	build_all_button_icons(UPDATE_BUTTON_NAME | UPDATE_BUTTON_ICON | UPDATE_BUTTON_STATUS)

/datum/action/innate/holoparasite/manifest_recall/proc/on_recall(mob/living/basic/holoparasite/source)
	SIGNAL_HANDLER
	active = FALSE
	name = initial(name)
	desc = initial(desc)
	button_icon_state = initial(button_icon_state)
	build_all_button_icons(UPDATE_BUTTON_NAME | UPDATE_BUTTON_ICON | UPDATE_BUTTON_STATUS)
