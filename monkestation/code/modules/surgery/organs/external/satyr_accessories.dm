/// Satyr Horns ///

/obj/item/organ/external/satyr_horns
	name = "satyr horns"
	desc = "Some pointy goat-like horns."
	icon_state = "satyr_horns"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'

	preference = "feature_satyr_horns"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HORNS

	use_mob_sprite_as_obj_sprite = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/satyr_horns

/datum/bodypart_overlay/mutant/satyr_horns
	layers = EXTERNAL_FRONT
	feature_key = "satyr_horns"

/datum/bodypart_overlay/mutant/satyr_horns/get_global_feature_list()
	return GLOB.satyr_horns_list

/datum/bodypart_overlay/mutant/satyr_horns/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/satyr_horns/can_draw_on_bodypart(mob/living/carbon/human/human)
	return TRUE

/// Satyr Ears ///

/obj/item/organ/external/satyr_ears
	name = "satyr ears"
	desc = "Some floppy goat-like ears."
	icon_state = "satyr_ears"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'

	preference = "feature_satyr_ears"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_OUTER_EAR

	use_mob_sprite_as_obj_sprite = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/satyr_ears

/datum/bodypart_overlay/mutant/satyr_ears
	layers = EXTERNAL_ADJACENT | EXTERNAL_FRONT
	feature_key = "satyr_ears"

/datum/bodypart_overlay/mutant/satyr_ears/get_global_feature_list()
	return GLOB.satyr_ears_list

/datum/bodypart_overlay/mutant/satyr_ears/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/satyr_ears/can_draw_on_bodypart(mob/living/carbon/human/human)
	return TRUE

/// Satyr Fluff ///

/obj/item/organ/external/satyr_fluff
	name = "satyr fluff"
	desc = "You shouldn't see this"
	icon_state = "satyr_fluff"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'

	preference = "feature_satyr_fluff"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_FUR
	organ_flags = ORGAN_UNREMOVABLE

	use_mob_sprite_as_obj_sprite = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/satyr_fluff

/datum/bodypart_overlay/mutant/satyr_fluff
	layers = EXTERNAL_FRONT
	feature_key = "satyr_fluff"

/datum/bodypart_overlay/mutant/satyr_fluff/get_global_feature_list()
	return GLOB.satyr_fluff_list

/datum/bodypart_overlay/mutant/satyr_fluff/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/satyr_fluff/can_draw_on_bodypart(mob/living/carbon/human/human)
	return TRUE
