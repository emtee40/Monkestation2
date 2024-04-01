/obj/item/bodypart/head/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	is_dimorphic = FALSE
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID

	dmg_overlay_type = ""

/obj/item/bodypart/chest/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	is_dimorphic = FALSE
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID

	dmg_overlay_type = ""

/obj/item/bodypart/arm/left/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID

	dmg_overlay_type = ""

/obj/item/bodypart/arm/right/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID

	dmg_overlay_type = ""

/obj/item/bodypart/leg/left/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

/obj/item/bodypart/leg/right/pony
	icon_greyscale =  'monkestation/code/modules/friendship-is-what/icons/pony.dmi'
	husk_type = "pony"
	limb_id = SPECIES_PONY
	bodytype = BODYTYPE_PONY | BODYTYPE_ORGANIC | BODYTYPE_HUMANOID
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

	dmg_overlay_type = ""


/obj/item/organ/internal/eyes/moth
	name = "moth eyes"
	desc = "These eyes seem to have increased sensitivity to bright light, with no improvement to low light vision."
	eye_icon_state = "motheyes"
	icon_state = "eyeballs-moth"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	overlay_ignore_lighting = TRUE

/obj/item/organ/external/tail/pony
	name = "pony tail"
	desc = "A severed pony tail. Somewhere, no doubt, a pony hater is very pleased with themselves."
	preference = "feature_tail_pony"

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/pony

/datum/bodypart_overlay/mutant/tail/pony
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND
	feature_key = "tail_pony"
	color_source = ORGAN_COLOR_MUTSECONDARY

/datum/bodypart_overlay/mutant/tail/simian/get_global_feature_list()
	return GLOB.tails_list_pony

/datum/bodypart_overlay/mutant/tail/simian/get_base_icon_state()
	return sprite_datum.icon_state


/obj/item/organ/external/pony_hair
	name = "pony hair"
	desc = "A severed pony hair. Somewhere, no doubt, a pony hater is very pleased with themselves."
	preference = "feature_pony_hair"

	bodypart_overlay = /datum/bodypart_overlay/mutant/pony_hair

/datum/bodypart_overlay/mutant/pony_hair
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND
	feature_key = "pony_hair"
	color_source = ORGAN_COLOR_MUTSECONDARY

/datum/bodypart_overlay/mutant/pony_hair/get_global_feature_list()
	return GLOB.pony_hair

/datum/bodypart_overlay/mutant/pony_hair/get_base_icon_state()
	return sprite_datum.icon_state

/datum/sprite_accessory/tails/pony
	icon = 'monkestation/code/modules/friendship-is-what/icons/tail_styles.dmi'
	color_src = MUTCOLORS_SECONDARY

/datum/sprite_accessory/tails/pony/pinkypie
	name = "pony_pinkiepie"
	icon_state = "pony_pinkiepie"

/datum/sprite_accessory/pony_hair
	icon = 'monkestation/code/modules/friendship-is-what/icons/hair_styles.dmi'
	color_src = MUTCOLORS_SECONDARY

/datum/sprite_accessory/pony_hair/pinkypie
	name = "pony_pinkiepie"
	icon_state = "pony_pinkiepie"


/obj/item/organ/internal/eyes/pony
	name = "pony eyes"
	desc = "These eyes seem to have increased sensitivity to bright light, with no improvement to low light vision."
	eye_icon_state = "pony_eyes"
	icon_state = "eyeballs-moth"


/datum/preference/choiced/pony_hair
	savefile_key = "feature_pony_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Pony Hair"
	should_generate_icons = TRUE

/datum/preference/choiced/pony_hair/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.pony_hair,
		"pony_hair",
		list("BEHIND", "FRONT"),
	)

/datum/preference/choiced/pony_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["pony_hair"] = value


/datum/preference/choiced/pony_tail
	savefile_key = "feature_tail_pony"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Pony Tail"
	should_generate_icons = TRUE

/datum/preference/choiced/pony_tail/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.tails_list_pony,
		"tail_pony",
		list("BEHIND", "FRONT"),
	)

/datum/preference/choiced/pony_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_pony"] = value
