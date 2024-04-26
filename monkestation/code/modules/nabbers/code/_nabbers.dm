#define NABBER_DAMAGE_ONBURNING 5
//Handles species
/datum/species/nabber
	name = "Giant Armored Serpentid"
	id = SPECIES_NABBER
	eyes_icon = 'monkestation/code/modules/nabbers/icons/organs/nabber_eyes.dmi'
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_PUSHIMMUNE, //You aint pushing it, chief.
		TRAIT_LIGHT_STEP,	//Can't wear shoes
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE //Flavor
	)
	visual_gender = FALSE
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		NO_UNDERWEAR,
		NOZOMBIE, //Breaks things majorly if they get zombified
		NO_DNA_COPY //Cannot be cloned, body too big.
	)
	digitigrade_customization = DIGITIGRADE_NEVER
	blood_colours = "#30498f" //Haemolyph is typically a deep blue.
	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE | ITEM_SLOT_EYES
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	uses_offsets = TRUE
	mutanttongue = /obj/item/organ/internal/tongue/nabber
	hair_alpha = 0
	payday_modifier = 0.50 //Lore accurate.
	coldmod = 0.3 //Very very resistant to cold
	heatmod = 2.5 // IT BURNS
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytype = BODYTYPE_CUSTOM
	mutantbrain = /obj/item/organ/internal/brain/nabber
	mutanteyes = /obj/item/organ/internal/eyes/robotic/nabber
	mutantlungs = /obj/item/organ/internal/lungs/nabber
	mutantheart = /obj/item/organ/internal/heart/nabber
	mutantliver = /obj/item/organ/internal/liver/nabber
	mutantears = /obj/item/organ/internal/ears/nabber
	mutantappendix = null
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/nabber,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/nabber,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/nabber,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/nabber,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/nabber,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/nabber,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = NABBER_HEAD_ICON,
		LOADOUT_ITEM_MASK = NABBER_MASK_ICON,
		LOADOUT_ITEM_UNIFORM = NABBER_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  NABBER_HANDS_ICON,
		LOADOUT_ITEM_BELT = NABBER_BELT_ICON,
		LOADOUT_ITEM_MISC = NABBER_BACK_ICON,
		LOADOUT_ITEM_EARS = NABBER_EARS_ICON
	)
	var/datum/action/cooldown/toggle_arms/arms
	var/datum/action/cooldown/optical_camouflage/camouflage
	//var/datum/action/cooldown/nabber_threat/threat_mod -Disabled pending balance and re-spriting.

/datum/species/nabber/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	arms = new(C)
	arms.Grant(C)
	camouflage = new(C)
	camouflage.Grant(C)
	//threat_mod = new(C)
	//threat_mod.Grant(C)

/datum/species/nabber/get_species_description()
	return "Large and in-charge, these large mantid-insect-snake hybrids stand at a massive height, easily towering over all but the tallest of Saurian races, and equipped with two deadly blade-arms and the ability to lift massive weights, these insectoids are valuable workers to Nanotrasen; if also appended with 'TERMINATE ON VIOLENT ACTION' tags."

/datum/species/nabber/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	arms.Destroy()
	camouflage.Destroy()
	//threat_mod.Destroy()

/datum/species/nabber/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(isdead(H))
		return
	//Handles bonus burn damage
	if(H.on_fire)
		H.apply_damage(NABBER_DAMAGE_ONBURNING, OXY)

/datum/species/nabber/prepare_human_for_preview(mob/living/carbon/human/nabber)
	var/nabber_color = "#00ac1d"
	nabber.dna.features["mcolor"] = nabber_color
	nabber.dna.features["mcolor2"] = nabber_color
	nabber.dna.features["mcolor3"] = nabber_color
	regenerate_organs(nabber, src, visual_only = TRUE)
	nabber.update_body(TRUE)

/datum/species/nabber/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Inhuman Proportions",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids are, unfortunately, too different to wear normal clothing."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Robust Chitin",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids have a robust external chitin layer that protects them from damage, but leaves them flammable."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "EXTREME Fire Vulnerability",
		SPECIES_PERK_DESC = "Due to Giant Armoured Serpentids method of 'breathing', being set on fire will also suffocate them."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Nictating Membrane",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids have a secondary membrane in their eyes that allows them to shield their sensitive vision from bright lights."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Mantid Bladearms",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids have two sets of arms - with the upper Bladearms requiring a majority of their haemolyph to remain active and mobile. These are dangerous weapons, and are treated by Security as such!"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Natural Chameleon",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids have photoreflective chitin, that makes them difficult to detect in darkness."
	))

	return perk_descriptions

/datum/species/nabber/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_name(gender)

	var/random_name
	random_name += (pick("Alpha","Delta","Dzetta","Phi","Epsilon","Gamma","Tau","Omega") + " [rand(1, 199)]") //Stolen from elsewhere.
	return random_name

/datum/species/nabber/randomize_features(mob/living/carbon/human_mob) //NEVER randomise features. This causes runtimes.
	return FALSE

/mob/living/carbon/human/species/nabber
	race = /datum/species/nabber
