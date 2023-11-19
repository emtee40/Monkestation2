#define SPECIES_RATTUS "rattus"

#define RATTUS_BELT_ICON 'monkestation/icons/mob/clothing/species/rattus/belts.dmi'
#define RATTUS_BACK_ICON 'monkestation/icons/mob/clothing/species/rattus/back.dmi'

/*
	LORE (also called the bullshit i made up with pizza and kitsune)
	A cargo ship crashed into the dessert plannet of Voltaire
	This cargo ship was full of cheese, wine, and french personel (all of which died)

	the rattus being savage cannibals they are go into the cargo ship and eat the fench obsorbing thier dna, turning all of the rattus french.
	they later developed space travel and said to NanoTrasen "Bonjour, je suis maintenant là pour voler tout votre fromage !"
*/

/datum/species/rattus
	name = "Rattus Norvegicus"
	plural_form = "Ratti"
	id = SPECIES_RATTUS
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	species_traits = list(
		NO_UNDERWEAR,
		NOEYESPRITES,
		SPECIES_FUR,
		NOAUGMENTS,
		NOTRANSSTING,
		)
	inherent_traits = list(
		TRAIT_NO_JUMPSUIT,
		TRAIT_VAULTING,
		TRAIT_NIGHT_VISION,
		TRAIT_POOR_AIM,
		)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	species_cookie = /obj/item/food/cheese/wedge
	meat = /obj/item/food/meat/slab/mouse
	liked_food = DAIRY | SUGAR | ALCOHOL | GROSS //("Sad European" -MechaDH)
	disliked_food = VEGETABLES
	maxhealthmod = 1
	stunmod = 1.1
	speedmod = -0.2
	brutemod = 1.75
	burnmod = 2.5
	siemens_coeff = 4
	payday_modifier = 0.75
	uses_fur = TRUE
	mutanttongue = /obj/item/organ/internal/tongue/rattus
	species_language_holder = /datum/language_holder/rattus
	death_sound = "monkestation/sound/voice/rattus/rattusdeath.ogg"
	no_equip_flags = ITEM_SLOT_ICLOTHING | ITEM_SLOT_NECK | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_BACKPACK | ITEM_SLOT_BACK
	custom_worn_icons = list(
		LOADOUT_ITEM_BELT = RATTUS_BELT_ICON,
		LOADOUT_ITEM_MISC = RATTUS_BACK_ICON,
		)
	offset_features = list(
		OFFSET_HANDS = list(0,-3),
		OFFSET_HEAD = list(0,-5),
		OFFSET_SUIT = list(0,-5),
		OFFSET_EARS = list(0,-5),
		OFFSET_BELT = list(0,-6),
		OFFSET_EYES = list(0,-6),
		OFFSET_FACE = list(0,-6),
		OFFSET_ACCESSORY = list(0,-6),
		OFFSET_S_STORE = list(0,-6),
		OFFSET_FACEMASK = list(0,-5),
		OFFSET_GLASSES = list(0,-6),
		)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/rattus,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/rattus,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/rattus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/rattus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/rattus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/rattus,
		)
	family_heirlooms = list(
		/obj/item/trash/raisins,
		/obj/item/trash/cheesie,
		/obj/item/trash/candy,
		/obj/item/trash/chips,
		/obj/item/trash/sosjerky,
		/obj/item/trash/pistachios,
		/obj/item/trash/peanuts,
		/obj/item/trash/boritos,
		/obj/item/trash/boritos/green,
		/obj/item/trash/boritos/purple,
		/obj/item/trash/boritos/red,
		/obj/item/trash/popcorn,
		/obj/item/trash/energybar,
		/obj/item/trash/semki,
		/obj/item/trash/cnds,
		/obj/item/trash/syndi_cakes,
		/obj/item/trash/shrimp_chips,
		/obj/item/trash/waffles,
		/obj/item/trash/tray,
		/obj/item/trash/can,
		/obj/item/shard,
		/obj/item/broken_bottle,
		/obj/item/light/tube/broken,
		/obj/item/light/bulb/broken,
		/obj/item/assembly/mousetrap/armed,
		/obj/item/popsicle_stick,
		/obj/item/shard/plasma,
		)

/datum/species/rattus/get_species_description()
	return "Rats, rats, we're the rats. \
		We prey at night, we stalk at night, we're the rats. \
		I'm the giant rat that makes all of the rules. \
		Let's see what kind of trouble we can get ourselves into."

/datum/species/rattus/random_name(gender,unique,lastname)
	var/randname = rattus_name(gender)
	if(lastname)
		randname += " [lastname]"
	return randname

/datum/species/rattus/get_scream_sound(mob/living/carbon/human/human)
	return 'monkestation/sound/voice/rattus/rattusscream.ogg'

/datum/species/rattus/get_laugh_sound(mob/living/carbon/human/human)
	return 'monkestation/sound/voice/rattus/rattuslaugh.ogg'

/datum/language_holder/rattus
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM), /datum/language/rattus = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM), /datum/language/rattus = list(LANGUAGE_ATOM))

/datum/language/rattus
	name = "Rattus French"
	desc = "The traditional lanugage of the Rattus peoples."
	key = "r"
	space_chance = 100
	default_priority = 90
	syllables = list("lager","maotai","bulleit","cognac","raki","mojito","smirnoff","brandy","sazerac","wine","calvados","chambord","liqueur","whisky","gin","scotch","cheese","fontina","roquefort","limburger","jarlsberg","emmental","taleggio","pecorino","cheddar","edam","asiago","stilton","munster","swis","feta","gruyere",,"colby","pepper-jack","gouda","manchego","blue-cheese","parmesan","mozzarella","ricotta","brie","camembert","provolone","gorgonzola","muenster","mascarpone","monterey","havarti","fromage","omelette-du-fromage","(RAT SOUNDS)","(INCOHERENT YELLING)","squeak","le","hon","hun","honhonhon","baugete","baugette","cigarette","viva","fuck","tete-de-noeud","andouille","blaireau","casse-toi","tabarnak","accoutrement","eiffel-tower")
	icon = 'monkestation/icons/misc/language.dmi'
	icon_state = "rattus"

/obj/item/bodypart/head/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/bodypart/head/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/bodypart/chest/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/bodypart/arm/left/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/bodypart/arm/right/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/bodypart/leg/left/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"


/obj/item/bodypart/leg/right/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"

/obj/item/organ/internal/tongue/rattus
	name = "rattus tongue"
	desc = "A fleshy muscle mostly used for lying. Reaks of alcohol and cheese."
	say_mod = "squeaks"

/obj/item/organ/internal/tongue/rattus/get_possible_languages()
	return ..() + /datum/language/rattus
