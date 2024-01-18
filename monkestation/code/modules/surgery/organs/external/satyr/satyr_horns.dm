/obj/item/organ/external/satyr_horns
	name = "satyr horns"
	desc = "You shouldn't see this"
	icon_state = ""
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'

	preference = "feature_satyr_horns"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HORNS

	use_mob_sprite_as_obj_sprite = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/satyr_horns

/datum/bodypart_overlay/mutant/satyr_horns
	layers = EXTERNAL_ADJACENT | EXTERNAL_FRONT
	feature_key = "satyr_horns"

/datum/bodypart_overlay/mutant/satyr_horns/get_global_feature_list()
	return GLOB.satyr_horns_list

/datum/bodypart_overlay/mutant/satyr_horns/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/satyr_horns/can_draw_on_bodypart(mob/living/carbon/human/human)
	return TRUE
