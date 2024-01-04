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

/datum/antagonist/bloodling/on_gain()
	generate_name()
	create_innate_actions()
	forge_objectives()

/datum/antagonist/bloodling/proc/generate_name()
	var/name = "bloodling"
	if(!lenght(bloodling_names))
		return
	name = [pick_n_take(bloodling_names)] [rand(1,999)]

/datum/antagonist/bloodling/forge_objectives()
	var/datum/objective/maroon/maroon_objective = new
	maroon_objective.owner = owner
	objectives += maroon_objective
