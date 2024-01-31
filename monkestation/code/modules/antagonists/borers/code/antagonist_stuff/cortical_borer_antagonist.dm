/datum/antagonist/cortical_borer
	name = "Cortical Borer"
	job_rank = ROLE_BORER
	roundend_category = "cortical borers"
	antagpanel_category = "Cortical Borers"
	prevent_roundtype_conversion = FALSE
	show_to_ghosts = TRUE
	/// The team of borers
	var/datum/team/cortical_borers/borers

/datum/antagonist/cortical_borer/on_gain()
	forge_objectives()
	return ..()

/datum/antagonist/cortical_borer/forge_objectives()
	var/datum/objective/custom/borer_objective_produce_eggs = new
	borer_objective_produce_eggs.explanation_text = "we require [GLOB.objective_egg_borer_number] different borers to produce [GLOB.objective_egg_egg_number] eggs to make sure our hive can spread widelly to reduce the chances of survival"

	var/datum/objective/custom/borer_objective_willing_hosts = new
	borer_objective_willing_hosts.explanation_text = "we require any amount of the borers to get [GLOB.objective_willing_hosts] willing host's trust to ensure our survival"

	var/datum/objective/custom/borer_objective_learn_chemicals = new
	borer_objective_learn_chemicals.explanation_text = "we require any amount of the borers to learn [GLOB.objective_blood_borer] chemicals from blood to aquire further chemical insight"

	objectives += borer_objective_produce_eggs
	objectives += borer_objective_willing_hosts
	objectives += borer_objective_learn_chemicals

/datum/antagonist/cortical_borer/get_preview_icon()
	return finish_preview_icon(icon('monkestation/code/modules/antagonists/borers/icons/animal.dmi', "brainslug"))

/datum/antagonist/cortical_borer/get_team()
	return borers

/datum/antagonist/cortical_borer/create_team(datum/team/cortical_borers/new_team)
	if(!new_team)
		for(var/datum/antagonist/cortical_borer/borer in GLOB.antagonists)
			if(!borer.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [borer]")
				continue
			if(borer.borers)
				borers = borer.borers
				return
		borers = new /datum/team/cortical_borers
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	borers = new_team

/datum/antagonist/cortical_borer/neutered
	name = "Neutered Cortical Borer"
	roundend_category = "neutered cortical borers"

/datum/antagonist/cortical_borer/neutered/forge_objectives()
	var/datum/objective/custom/borer_objective_protect_target = new
	borer_objective_protect_target.explanation_text = "Protect whomever was nearest to the egg when you hatched"
	var/datum/objective/custom/borer_objective_listen_to_target = new
	borer_objective_protect_target.explanation_text = "Listen to whatever command the human you first have seen may have for you"

	objectives += borer_objective_protect_target
	objectives += borer_objective_listen_to_target
