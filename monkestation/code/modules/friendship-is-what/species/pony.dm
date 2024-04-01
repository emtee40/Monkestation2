/mob/living/carbon/human/species/pony
	race = /datum/species/pony

/datum/species/pony // /mlp/
	name = "Pony"
	id = SPECIES_PONY
	bodytype = BODYTYPE_PONY

	eyes_icon = 'monkestation/code/modules/friendship-is-what/icons/hair_styles.dmi'
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/pony,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/pony,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/pony,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/pony,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/pony,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/pony,
	)

	mutanteyes = /obj/item/organ/internal/eyes/pony

	offset_features = list(
		OFFSET_HEAD = list(0,0),
		OFFSET_GLASSES = list(0,0),
		OFFSET_HANDS = list(0,-3),
		OFFSET_FACEMASK = list(0,0),
	)
	external_organs = list(
		/obj/item/organ/external/tail/pony = "pony_pinkiepie",
		/obj/item/organ/external/pony_hair = "pony_pinkiepie",
	)

	visual_gender = FALSE
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		NO_UNDERWEAR,
		MUTCOLORS_SECONDARY,
	)
