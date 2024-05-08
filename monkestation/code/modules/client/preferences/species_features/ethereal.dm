/datum/preference/choiced/ethereal_horns
	savefile_key = "feature_ethereal_horns"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal Horns"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_horns/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.ethereal_horns_list,
		"ethereal_horns",
		list("BEHIND", "FRONT"),
	)

/datum/preference/choiced/ethereal_horns/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethereal_horns"] = value
