/// Satyr Horns ///

/datum/preference/choiced/satyr_horns
	savefile_key = "feature_satyr_horns"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Satyr Horns"
	should_generate_icons = TRUE

/datum/preference/choiced/satyr_horns/init_possible_values()
	var/list/values = list()

	var/icon/satyr_head = icon('monkestation/icons/mob/species/satyr/bodyparts.dmi', "satyr_head_m")

	for (var/horn_name in GLOB.satyr_horns_list)
		var/datum/sprite_accessory/horns = GLOB.satyr_horns_list[horn_name]
		if(horns.locked)
			continue

		var/icon/icon_with_horns = new(satyr_head)
		icon_with_horns.Blend(icon(horns.icon, "m_satyr_horns_[horns.icon_state]_FRONT"), ICON_OVERLAY)
		icon_with_horns.Scale(64, 64)
		icon_with_horns.Crop(15, 64, 15 + 31, 64 - 31)

		values[horns.name] = icon_with_horns

	return values

/datum/preference/choiced/satyr_horns/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["satyr_horns"] = value

/// Satyr Ears ///

/datum/preference/choiced/satyr_ears
	savefile_key = "feature_satyr_ears"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Satyr Ears"
	should_generate_icons = TRUE

/datum/preference/choiced/satyr_ears/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.satyr_ears_list,
		"satyr_ears",
		list("ADJ", "FRONT"),
	)

/datum/preference/choiced/satyr_ears/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["satyr_ears"] = value

/// Satyr Tail ///

/datum/preference/choiced/satyr_tail
	savefile_key = "feature_satyr_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Satyr Tail"
	should_generate_icons = TRUE

/datum/preference/choiced/satyr_tail/init_possible_values()
 	return possible_values_for_sprite_accessory_list_for_body_part(
 		GLOB.tails_list_satyr,
 		"satyr_tail",
 		list("ADJ", "FRONT"),
 	)

/datum/preference/choiced/satyr_tail/apply_to_human(mob/living/carbon/human/target, value)
 	target.dna.features["satyr_tail"] = value

/// Satyr Fluff ///

/datum/preference/choiced/satyr_fluff
	savefile_key = "feature_satyr_fluff"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Satyr Fluff"
	should_generate_icons = TRUE

/datum/preference/choiced/satyr_fluff/init_possible_values()
	var/icon/lower_half = icon('icons/blanks/32x32.dmi', "nothing")

	for (var/icon in list("human_r_leg", "human_l_leg"))
		lower_half.Blend(icon('icons/mob/species/human/bodyparts_greyscale.dmi', icon), ICON_OVERLAY)

	var/list/values = list()

	for (var/accessory_name in GLOB.satyr_fluff_list)
		var/icon/icon_with_socks = new(lower_half)

		if (accessory_name != "Nude")
			var/datum/sprite_accessory/accessory = GLOB.satyr_fluff_list[accessory_name]

			var/icon/accessory_icon = icon('monkestation/icons/mob/species/satyr/satyr_fluff.dmi', "[accessory.icon_state]_preview")
			icon_with_socks.Blend(accessory_icon, ICON_OVERLAY)

		icon_with_socks.Crop(10, 1, 22, 13)
		icon_with_socks.Scale(32, 32)

		values[accessory_name] = icon_with_socks

	return values

/datum/preference/choiced/satyr_fluff/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["satyr_fluff"] = value
