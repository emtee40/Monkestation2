/datum/antagonist/bloodling
	name = "\improper Bloodling"
	roundend_category = "Bloodlings"
	antagpanel_category = ANTAG_GROUP_BLOODLING
	job_rank = ROLE_BLOODLING
	antag_moodlet = /datum/mood_event/focused
	antag_hud_name = "changeling"
	hijack_speed = 0.5
	suicide_cry = "CONSUME!! CLAIM!! THERE WILL BE ANOTHER!!"
	show_name_in_check_antagonists = TRUE

	// If this bloodling is ascended or not
	var/is_ascended = FALSE

/datum/antagonist/bloodling/on_gain()
	forge_objectives()
	owner.current.grant_all_languages(FALSE, FALSE, TRUE) //Grants omnitongue. We are a horrific blob of flesh who can manifest a million tongues.
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ling_alert.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	return ..()

/datum/antagonist/bloodling/forge_objectives()
	var/datum/objective/bloodling_ascend/ascend_objective = new
	ascend_objective.owner = owner
	objectives += ascend_objective
