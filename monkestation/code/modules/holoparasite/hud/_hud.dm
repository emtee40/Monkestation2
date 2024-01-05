/datum/hud/holoparasite
	ui_style = 'icons/hud/guardian.dmi'
	has_interaction_ui = TRUE
	var/mob/living/basic/holoparasite/owner

/datum/hud/holoparasite/New(mob/living/basic/holoparasite/owner)
	. = ..()
	if(!istype(owner))
		CRASH("Attempted to initialize holoparasite HUD on non-holoparasite!")
	src.owner = owner
	healths = new /atom/movable/screen/healths
	healths.hud = src
	infodisplay += healths

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_appearance()
	pull_icon.screen_loc = ui_living_pull
	pull_icon.hud = src
	static_inventory += pull_icon

