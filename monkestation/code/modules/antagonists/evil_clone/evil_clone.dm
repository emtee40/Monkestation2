/datum/antagonist/evil_clone
	name = "\improper Evil Clone"
	show_in_antagpanel = TRUE
	roundend_category = "evil clones"
	antagpanel_category = "Evil Clones"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE

/datum/antagonist/evil_clone/greet()
	. = ..()
	owner.announce_objectives()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/revolutionary_tide.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/antagonist/evil_clone/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/evil_clone/forge_objectives()
	var/datum/objective/evil_clone/objective = new
	objective.owner = owner
	objectives += objective
