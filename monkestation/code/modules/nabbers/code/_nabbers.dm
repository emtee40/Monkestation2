#define NABBER_DAMAGE_ONBURNING 10 //Temporary change. If it's too dangerous, I'll nerf it.
#ifdef TRAIT_HARD_SOLES //Checks to see if this trait exists.
/datum/species/nabber //If Hard_soles is detected, apply it to their inherent_traits. Cross-Testmerge compatability!
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_PUSHIMMUNE, //You aint pushing it, chief.
		TRAIT_LIGHT_STEP,	//Can't wear shoes
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_HARD_SOLES,
		TRAIT_RADIMMUNE //Flavor
	)
#else
/datum/species/nabber //If hard soles does not exist (Satyrs not merged/Testmerged)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_PUSHIMMUNE, //You aint pushing it, chief.
		TRAIT_LIGHT_STEP,	//Can't wear shoes
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE //Flavor
	)
#endif
//Handles species

//Nabbers armor datum. Change this to change their resistances. Is now affected by armor piercing/etc
//By default, this is a way easier method of balancing a species rather than directly affecting burn/brute_mod, as this takes into account AP.
//Currently Nabbers also recieve a 5% brute damage reduction atop of this, and a 1.8x burn modifier, atop of their pre-existing heat modifiers.
//Whenever you adjust these variables, make sure to adjust their damage reduction, heat modifiers, and burn vulnerability to prevent scaling issues.
//All values are currently temporary and will require further balancing as eye protection, and nabber nukie modsuits are added.

/datum/armor/nabbers
	melee = 45 //Massively reduce incoming melee damage
	bullet = 25 //Reduce incoming bullet damage, too
	wound = 25 //Bare wound chance reduction
	acid = 15 // Acid reduction

/datum/species/nabber
	name = "Giant Armored Serpentid"
	id = SPECIES_NABBER
	eyes_icon = 'monkestation/code/modules/nabbers/icons/organs/nabber_eyes_new.dmi'
	held_accessory = null
	held_accessory_path = 'monkestation/code/modules/nabbers/icons/bodyparts/bodypart_overlays.dmi'
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
	coldmod = 0.3 //Very very resistant to cold
	heatmod = 2.5 // IT BURNS
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 5) //-10 was a bit too high, as it already does damage to their lungs
	bodytype = BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
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

	C.set_armor(C.get_armor().add_other_armor(/datum/armor/nabbers)) //Assign the armor

/datum/species/nabber/get_species_description()
	return "Large, bulky - impressively armoured and chitinous, these ambush predators are a recent acquisition by NanoTrasen. Loyal workers, not the brightest bulb in the pack - and physically impressive, they're perfect for all forms of menial, unimportant labor. Known to be extremely flammable."

/mob/living/carbon/human/proc/destroy_anime() //HATE. LET ME TELL YOU HOW MUCH I HAVE COME TO HATE.
	var/obj/item/organ/external/anime_head/removing1 = src.get_organ_slot(ORGAN_SLOT_EXTERNAL_ANIME_HEAD)
	var/obj/item/organ/external/anime_middle/removing2 = src.get_organ_slot(ORGAN_SLOT_EXTERNAL_ANIME_CHEST)
	var/obj/item/organ/external/anime_bottom/removing3 = src.get_organ_slot(ORGAN_SLOT_EXTERNAL_ANIME_BOTTOM)
	if(removing1) //Fugly-ass code but it works for ensuring we don't get sprite/code issues.
		qdel(removing1)
	if(removing2)
		qdel(removing2)
	if(removing3)
		qdel(removing3)


/datum/species/nabber/after_equip_job(datum/job/J, mob/living/carbon/human/C, visualsOnly = FALSE, client/preference_source = null) //Handle things such as post_spawn timers here. In this case, prepare to evaporate anime.
	..()
	addtimer(CALLBACK(C, TYPE_PROC_REF(/mob/living/carbon/human, destroy_anime), TRUE), 2.5 SECONDS) //Enough time to ensure that we don't get any runtimes.

/datum/species/nabber/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	qdel(arms)
	qdel(camouflage)
	C.set_armor(C.get_armor().subtract_other_armor(/datum/armor/nabbers)) //Make sure to remove it, to stop people abusing lings/etc to gain infinite melee armor
	//threat_mod.Destroy()

/datum/species/nabber/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(H.stat == DEAD) //Should never allow for them to keep burning forever
		return
	//Handles bonus burn damage
	if(H.on_fire)
		H.apply_damage(NABBER_DAMAGE_ONBURNING, OXY)
	if(H.fire_stacks <= 5 && !H.on_fire) //Never give more than 15 firestacks... Normally.
		H.adjust_fire_stacks(10)

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
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
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
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Flammable Chitin",
		SPECIES_PERK_DESC = "Due to the photoreflective layer on their chitin, Giant Armoured Serpentids are known to combust when exposed to sufficient heat or flame, very, very easily."
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
		SPECIES_PERK_NAME = "Natural Electrochromic Chitin",
		SPECIES_PERK_DESC = "Giant Armoured Serpentids have naturally-electrochromic chitin. Easily disrupted by grounding to any object they touch, they can remain mostly invisible, so long as they are not disturbed nor interact with their surroundings."
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
