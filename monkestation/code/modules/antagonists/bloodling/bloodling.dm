/datum/antagonist/bloodling
	name = "\improper Bloodling"
	roundend_category = "changelings"
	antagpanel_category = "Bloodling"
	job_rank = ROLE_BLOODLING
	antag_moodlet = /datum/mood_event/focused
	antag_hud_name = "changeling"
	hijack_speed = 0.5
	suicide_cry = "CONSUME!! CLAIM!! THERE WILL BE ANOTHER!!"

	// The amount of biomass our bloodling has
	var/biomass = 0
	// The maximum amount of biomass a bloodling can gain
	var/biomass_max = 500
	// If this bloodling is ascended or not
	var/is_ascended = FALSE
	// Possible names for our bloodling
	var/static/list/bloodling_names = list(
		"biohazard",
		"fleshy mass",
		"spiny mess",
		"blob of flesh",
		"malign blood",
		"carrion",
	)
	var/static/list/bloodling_starting_abilities = list(
		/datum/action/cooldown/alien/hide,
	)

/datum/antagonist/bloodling/on_gain()
	generate_name()
	create_innate_actions()
	forge_objectives()
	owner.current.grant_all_languages(FALSE, FALSE, TRUE) //Grants omnitongue. We are a horrific blob of flesh who can manifest a million tongues.
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ling_alert.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	return ..()

/datum/antagonist/bloodling/proc/generate_name()
	var/name = "bloodling"
	if(!lenght(bloodling_names))
		return
	name = "[pick_n_take(bloodling_names)] [rand(1,999)]"

/datum/antagonist/bloodling/forge_objectives()
	var/datum/objective/bloodling_ascend/ascend_objective = new
	ascend_objective.owner = owner
	objectives += ascend_objective

/datum/antagonist/bloodling/proc/create_innate_actions()
	for var/datum/action/cooldown/spell/created_action in bloodling_starting_abilities:
		created_action.Grant(user)
