/datum/species/vox
	// Bird-like humanoids
	name = "Vox"
	id = SPECIES_VOX
	eyes_icon = 'icons/mob/species/vox/eyes.dmi'
	species_traits = list(
		MUTCOLORS,
		MUTCOLORS_SECONDARY,
		MUTCOLORS_TERTIARY,
		EYECOLOR,
		HAIRCOLOR,
		FACEHAIRCOLOR,
	)
	inherent_traits = list(
		TRAIT_RESISTCOLD,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantlungs = /obj/item/organ/internal/lungs/vox
	mutantbrain = /obj/item/organ/internal/brain/vox
	mutantheart = /obj/item/organ/internal/heart/vox
	mutanteyes = /obj/item/organ/internal/eyes/vox
	mutantliver = /obj/item/organ/internal/liver/vox
	breathid = "n2"
	scream_verb = "shrieks"
	external_organs = list(
		/obj/item/organ/external/snout/vox = "Vox Snout",
		/obj/item/organ/external/vox_hair = "None",
		/obj/item/organ/external/vox_facial_hair = "None",
		/obj/item/organ/external/tail/lizard/vox = "Vox Tail",
		/obj/item/organ/external/spines/vox = "None")
	liked_food = MEAT | FRIED
	payday_modifier = 0.75
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/vox,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/vox,
	)

/datum/species/vox/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features["mcolor"] = "#99FF99"
	human.dna.features["mcolor2"] = "#F0F064"
	human.hair_color = "#FF9966"
	human.facial_hair_color = "#FF9966"
	human.eye_color_right = COLOR_TEAL
	human.eye_color_left = COLOR_TEAL
	human.update_body(TRUE)

/datum/species/vox/pre_equip_species_outfit(datum/outfit/O, mob/living/carbon/human/equipping, visuals_only)
	if(!O)
		give_important_for_life(equipping)
		return

	var/obj/item/clothing/mask = O.mask
	if(!(mask && (initial(mask.clothing_flags) & MASKINTERNALS)))
		equipping.equip_to_slot(new /obj/item/clothing/mask/breath/vox, ITEM_SLOT_MASK, TRUE, FALSE)

	var/obj/item/tank/internals/nitrogen/belt/full/tank = new
	if(!O.r_hand)
		equipping.put_in_r_hand(tank)
	else if(!O.l_hand)
		equipping.put_in_l_hand(tank)
	else
		equipping.put_in_r_hand(tank)

	equipping.open_internals(tank)

/datum/species/vox/give_important_for_life(mob/living/carbon/human/human_to_equip)
	. = ..()
	var/obj/item/I = human_to_equip.get_item_for_held_index(2)
	if(I)
		human_to_equip.open_internals(I)
	else
		var/obj/item/tank/internals/nitrogen/belt/full/new_tank = new(null)
		if(human_to_equip.equip_to_slot_or_del(new_tank, ITEM_SLOT_BELT))
			human_to_equip.internal = human_to_equip.belt
		else
			stack_trace("Vox going without internals. Uhoh.")

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()

	var/randname = vox_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/vox/get_species_description()
	return "The Vox are remnants of an ancient race, that originate from arkships. \
	These bioengineered, reptilian, beaked, and quilled beings have a physiological caste system and follow 'The Inviolate' tenets.<br/><br/> \
	Breathing pure nitrogen, they need specialized masks and tanks for survival outside their arkships. \
	Their insular nature limits their involvement in broader galactic affairs, maintaining a distinct, yet isolated presence away from other species."

/datum/species/vox/get_scream_sound(mob/living/carbon/human/vox)
	return 'sound/voice/vox/shriek1.ogg'

/datum/species/vox/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "temperature-low",
			SPECIES_PERK_NAME = "Cold Resistance",
			SPECIES_PERK_DESC = "Vox have their organs heavily modified to resist the coldness of space",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "EMP Sensitivity",
			SPECIES_PERK_DESC = "Due to their organs being synthetic, they are susceptible to emps.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "Nitrogen Breathing",
			SPECIES_PERK_DESC = "Voxes must breathe nitrogen to survive. You receive a tank when you arrive.",
		),
	)

	return to_add
