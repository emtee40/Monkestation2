//EXPERIMENTAL DO NOT USE

/*

// Subtype for throat slices
/datum/wound/slash/flesh/critical/artery
	name = "Slashed Artery"
	desc = "Patient has a slashed artery, causing severe and life-threatening bleeding."
	examine_desc = "is ruptured, spraying blood wildly"
	initial_flow = 12
	minimum_flow = 6

/datum/wound/slash/flesh/critical/artery/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "is ruptured"

/datum/wound_pregen_data/flesh_slash/avulsion/artery
	abstract = FALSE
	can_be_randomly_generated = FALSE

	wound_path_to_generate = /datum/wound/slash/flesh/critical/artery

*/
