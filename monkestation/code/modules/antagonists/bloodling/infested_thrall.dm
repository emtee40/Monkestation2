/datum/antagonist/changeling/bloodling_thrall
	name = "\improper Changeling"
	roundend_category = "bloodling thralls"
	antagpanel_category = ANTAG_GROUP_BLOODLING
	job_rank = ROLE_BLOODLING_THRALL
	antag_moodlet = /datum/mood_event/focused
	antag_hud_name = "changeling"
	hijack_speed = 0
	suicide_cry = "FOR THE MASTER!!"
	genetic_points = 5
	total_genetic_points = 5

/datum/antagonist/changeling/bloodling_thrall/purchase_power(datum/action/changeling/sting_path)
	if(istype(sting_path, /datum/action/changeling/fakedeath))
		to_chat(owner.current, span_warning("We are unable to evolve that ability"))
		return FALSE
	..()

/datum/antagonist/changeling/bloodling_thrall/create_innate_actions()
	for(var/datum/action/changeling/path as anything in all_powers)
		if(initial(path.dna_cost) != 0)
			continue
		var/datum/action/changeling/innate_ability = new path()
		if(istype(innate_ability, /datum/action/changeling/fakedeath))
			continue
		innate_powers += innate_ability
		innate_ability.on_purchase(owner.current, TRUE)
