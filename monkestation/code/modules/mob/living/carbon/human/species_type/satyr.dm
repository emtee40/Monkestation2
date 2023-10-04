/datum/species/satyr
	name = "\improper Satyr"
	plural_form = "Satyrs"
	id = SPECIES_SATYR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	sexes = TRUE
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAIR,
		FACEHAIR,
		SKINTONES
	)
	inherent_traits = list(
		TRAIT_NIGHT_VISION,
		TRAIT_FREERUNNING,
		TRAIT_ALCOHOL_TOLERANCE,
		TRAIT_HARD_SOLES
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	external_organs = list(
		/obj/item/organ/external/satyr_horns = "tall",
		/obj/item/organ/external/satyr_ears = "flat",
		/obj/item/organ/external/satyr_tail = "short",
		/obj/item/organ/external/satyr_fluff = "normal"
		)
	meat = /obj/item/food/meat/steak
	liked_food = MEAT | GROSS | VEGETABLES | FRUIT
	species_language_holder = /datum/language_holder/satyr
	maxhealthmod = 1
	stunmod = 1
	speedmod = 1
	payday_modifier = 1
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/satyr,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/satyr,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/satyr,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/satyr,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/satyr,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/satyr,
	)

/mob/living/carbon/human/species/satyr
    race = /datum/species/satyr

/datum/language_holder/satyr
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/satyr = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/satyr = list(LANGUAGE_ATOM))

/datum/language/satyr
	name = "Gotin"
	desc = "The language of the satyrs, very similar to an old Terran language called latin."
	space_chance = 50
	key = "S"

	syllables = list("beh, bah, buh, be, ba, bu, baa")

	default_priority = 90
	icon_state = "satyr"
	icon = 'monkestation/icons/misc/language.dmi'

/datum/species/satyr/get_species_description()
	return "Goat-like humanoids, seemingly identical to the once in ancient Greek mythology."

/datum/species/satyr/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "",
			SPECIES_PERK_NAME = "",
			SPECIES_PERK_DESC = "",
		)
	)

	return to_add

/obj/item/bodypart/head/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR
	is_dimorphic = TRUE

/obj/item/bodypart/chest/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR
	is_dimorphic = TRUE

/obj/item/bodypart/arm/left/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR

/obj/item/bodypart/arm/right/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR

/obj/item/bodypart/leg/left/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR

/obj/item/bodypart/leg/right/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR

/datum/quirk/hard_soles //Stolen from Skyrat
	name = "Hardened Soles"
	mob_trait = TRAIT_HARD_SOLES
