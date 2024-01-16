#define VOX_HAIR_COLOR "#FF9966"

/proc/generate_vox_side_shots(list/sprite_accessories, key, accessory_color = VOX_HAIR_COLOR)
	var/list/values = list()

	var/icon/vox_head = icon('icons/mob/species/vox/bodyparts.dmi', "vox_head_green")
	var/icon/eyes = icon('icons/mob/species/vox/eyes.dmi', "eyes_l")
	var/icon/eyes_r = icon('icons/mob/species/vox/eyes.dmi', "eyes_r")


	eyes.Blend(COLOR_CYAN, ICON_MULTIPLY)
	eyes_r.Blend(COLOR_CYAN, ICON_MULTIPLY)
	eyes.Blend(eyes_r, ICON_OVERLAY)
	vox_head.Blend(eyes, ICON_OVERLAY)

	var/icon/beak = icon('icons/mob/species/vox/beaks.dmi', "m_beak_vox_ADJ")
	vox_head.Blend(beak, ICON_OVERLAY)

	for(var/name in sprite_accessories)
		var/datum/sprite_accessory/sprite_accessory = sprite_accessories[name]

		var/icon/final_icon = icon(vox_head)

		var/icon/accessory_icon = icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ")
		accessory_icon.Blend(accessory_color, ICON_MULTIPLY)
		final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(10, 19, 22, 31)
		final_icon.Scale(32, 32)

		values[name] = final_icon

	return values

/datum/preference/choiced/vox_skin_tone
	savefile_key = "feature_vox_skin_tone"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_bodyparts = list(/obj/item/bodypart/head/vox, /obj/item/bodypart/chest/vox, /obj/item/bodypart/arm/left/vox, \
							/obj/item/bodypart/arm/right/vox, /obj/item/bodypart/leg/left/vox, /obj/item/bodypart/leg/right/vox)

/datum/preference/choiced/vox_skin_tone/init_possible_values()
	return GLOB.vox_skin_tones

/datum/preference/choiced/vox_skin_tone/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_skin_tone"] = value

/datum/preference/choiced/vox_spines
	savefile_key = "feature_vox_spines"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/spines/vox

/datum/preference/choiced/vox_spines/init_possible_values()
	return assoc_to_keys(GLOB.spines_list_vox)

/datum/preference/choiced/vox_spines/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["spines_vox"] = value

/datum/preference/choiced/vox_body_markings
	savefile_key = "feature_vox_body_markings"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "vox_body_markings"
	main_feature_name = "Body markings"

/datum/preference/choiced/vox_body_markings/init_possible_values()
	return assoc_to_keys(GLOB.vox_body_markings_list)

/datum/preference/choiced/vox_body_markings/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_body_markings"] = value

/datum/preference/choiced/vox_hair
	savefile_key = "feature_vox_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	should_generate_icons = TRUE
	main_feature_name = "Hairstyle"
	relevant_external_organ = /obj/item/organ/external/vox_hair

/datum/preference/choiced/vox_hair/init_possible_values()
	return generate_vox_side_shots(GLOB.vox_hair_list, "vox_hair")

/datum/preference/choiced/vox_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_hair"] = value

/datum/preference/choiced/vox_hair/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = "hair_color"
	return data

/datum/preference/choiced/vox_facial_hair
	savefile_key = "feature_vox_facial_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Facial Hairstyle"
	should_generate_icons = TRUE
	relevant_external_organ = /obj/item/organ/external/vox_facial_hair

/datum/preference/choiced/vox_facial_hair/init_possible_values()
	return generate_vox_side_shots(GLOB.vox_facial_hair_list, "vox_facial_hair")

/datum/preference/choiced/vox_facial_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_facial_hair"] = value

/datum/preference/choiced/vox_facial_hair/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = "facial_hair_color"
	return data
