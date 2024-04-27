/datum/species/satyr
	name = "\improper Satyr"
	plural_form = "Satyrs"
	id = SPECIES_SATYR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	no_equip_flags = ITEM_SLOT_FEET
	sexes = TRUE
	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		NO_UNDERWEAR,
	)
	inherent_traits = list(
		TRAIT_ALCOHOL_TOLERANCE,
		TRAIT_HARD_SOLES
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	use_skintones = TRUE
	external_organs = list(
		/obj/item/organ/external/satyr_fluff = "normal",
		/obj/item/organ/external/satyr_tail = "short",
		/obj/item/organ/external/satyr_horns = "back",
	)
	meat = /obj/item/food/meat/steak
	liked_food = GROSS | VEGETABLES | FRUIT
	disliked_food = MEAT | DAIRY
	maxhealthmod = 0.8
	stunmod = 1.2
	//speedmod = 1
	payday_modifier = 1
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/satyr,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/satyr,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/satyr,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/satyr,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/satyr,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/satyr,
	)

/datum/species/satyr/get_species_description()
	return "Mythical goat-people. The clacking of hooves and smell of beer follow them around."

/mob/living/carbon/human/species/satyr
    race = /datum/species/satyr

/datum/species/satyr/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "",
			SPECIES_PERK_NAME = "Hooves",
			SPECIES_PERK_DESC = "Cloven feet prevent wearing of shoes, but also protect as a shoe would.",
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
	bodytype = BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/satyr
	icon_greyscale = 'monkestation/icons/mob/species/satyr/bodyparts.dmi'
	limb_id = SPECIES_SATYR
	bodytype = BODYTYPE_DIGITIGRADE
