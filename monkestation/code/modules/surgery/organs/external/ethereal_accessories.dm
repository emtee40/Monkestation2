/obj/item/organ/external/ethereal_horns
	name = "ethereal horns"
	desc = "They don't actually let you hear better."
	icon_state = "ethereal_horns"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'

	preference = "feature_ethereal_horns"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HORNS

	use_mob_sprite_as_obj_sprite = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ethereal_horns

/datum/bodypart_overlay/mutant/ethereal_horns
	layers = EXTERNAL_FRONT|EXTERNAL_ADJACENT
	feature_key = "ethereal_horns"

/datum/bodypart_overlay/mutant/ethereal_horns/get_global_feature_list()
	return GLOB.ethereal_horns_list

/datum/bodypart_overlay/mutant/ethereal_horns/can_draw_on_bodypart(mob/living/carbon/human/human)
	return TRUE
