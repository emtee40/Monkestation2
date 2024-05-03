/*
	Le' Lore

	How did the rattus come to be?
	A cargo ship crashed into the dessert plannet of Voltaire.
	This cargo ship was full of cheese, wine, and french personel.
	The rattus being in a state of savagery, scamper into the cargo ship and eat the remaining french that are alive obsorbing thier dna!
	This turns the rattus french and civilized.
	The rattus later over DECADES (two weeks) develop space travel and eventally get discovered by nanotraseen!
	The rattus get hired by Nanotrasen for thier excellent enthusiasm ~~and resilience~~.
	This is where the story continues, onboard the newest Nanotraseen project.. Space Station 13!
*/

#define SPECIES_RATTUS "rattus"

/datum/species/rattus
	name = "\improper Rattus Norvegicus"
	plural_form = "Ratti"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP
	id = SPECIES_RATTUS
	species_traits = list(
		NOEYESPRITES,
		MUTCOLORS,
		NO_UNDERWEAR,
		NOTRANSSTING,
		NOBLOODOVERLAY,
		NOAUGMENTS, //No icons for augments on rattus currently and that would look so cursed, also how would they even FIT on a rat?
	)
	inherent_traits = list(
		TRAIT_NO_JUMPSUIT,
		TRAIT_VAULTING,
		TRAIT_VENTCRAWLER_NUDE,
		VENTCRAWLING_TRAIT,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	species_cookie = /obj/item/food/cheese/wedge
	meat = /obj/item/food/meat/slab/mouse
	liked_food = DAIRY | SUGAR | ALCOHOL | GROSS
	toxic_food = VEGETABLES //Veggies?! YUCK!!
	mutanttongue = /obj/item/organ/internal/tongue/rattus
	species_language_holder = /datum/language_holder/rattus
	fire_overlay = "human_small_fire"
	speedmod = -0.27
	stunmod = 1.1
	brutemod = 2.0
	burnmod = 3.5
	siemens_coeff = 1.75
	no_equip_flags = ITEM_SLOT_GLOVES | ITEM_SLOT_ICLOTHING | ITEM_SLOT_FEET
	death_sound = "monkestation/sound/voice/rattus/rattusdeath.ogg"
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/rattus,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/rattus,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/rattus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/rattus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/rattus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/rattus,
	)
	offset_features = list(
		OFFSET_HANDS = list(0,-6),
		OFFSET_BELT = list(0,-8), //need unique sprites later [they look fine already, just a few oddities]
		OFFSET_BACK = list(0,-10), //need unique sprites later [backpacks look almost correct, still wierd]
		OFFSET_NECK = list(0,-11), //need unique sprites later [cloaks are VERY wonky]
		OFFSET_ID = list(0,-11),
		OFFSET_GLASSES = list(0,-11),
		OFFSET_EARS = list(0,-11),
		OFFSET_FACEMASK = list(0,-11),
		OFFSET_HEAD = list(0,-11),
		OFFSET_FACE = list(0,-11),
		OFFSET_S_STORE = list(0,-8),
		OFFSET_SUIT = list(0,-11), //need unique sprites later [they just don't look good on rattus]
		OFFSET_UNIFORM = list(0,-11),
		OFFSET_SHOES = list(0,-11),
		OFFSET_GLOVES = list(0,-11),
	)
	family_heirlooms = list(
		/obj/item/assembly/mousetrap/armed,
		/obj/item/trash/raisins,
		/obj/item/trash/cheesie,
		/obj/item/trash/chips,
		/obj/item/trash/sosjerky,
		/obj/item/trash/pistachios,
		/obj/item/trash/popcorn,
		/obj/item/trash/energybar,
		/obj/item/trash/can,
		)

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
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

/obj/item/bodypart/leg/right/rattus
	icon_greyscale =  'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	husk_type = "rattus"
	icon_husk = 'monkestation/icons/mob/species/rattus/bodyparts.dmi'
	limb_id = SPECIES_RATTUS
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	dmg_overlay_type = "monkey"
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

/obj/item/organ/internal/tongue/rattus
	name = "rattus tongue"
	desc = "A fleshy muscle mostly used for the consuming of alcohol and cheese."
	say_mod = "squeaks"

/obj/item/organ/internal/tongue/rattus/get_possible_languages()
	return ..() + /datum/language/rattus

/datum/language_holder/rattus
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM), /datum/language/rattus = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM), /datum/language/rattus = list(LANGUAGE_ATOM))

/datum/language/rattus
	name = "Rattus ''traditional'' French"
	desc = "The traditional lanugage of the Rattus peoples."
	key = "f"
	space_chance = 100
	default_priority = 90
	syllables = list(
		//alcohol
		"lager","absinthe","amaro","amaretto","aperol","armagnac","baileys","beer","bellini","bitters","bourbon","brandy","bulleit","cachaça","calvados","campari","cava","champagne","chardonnay","chartreuse","chianti","cider","cognac","cosmopolitan","cynar","daquiri","genever","gin","grand-marnier","grappa","grenadine","irish-coffee","jägermeister","kahlúa","kir-royale","lager","limoncello","mai-tai","manhattan","margarita","martini","mead","merlot","mezcal","mojito","moscato","negroni","pilsner","pinot-grigio","pinot-noir","port","prosecco","raki","rum","sake","sangria","sazerac","scotch","sherry","smirnoff","sour","sparkling-wine","tequila","vodka","whisky","wine","zinfandel",
		//cheese
		"cheese","fontina","roquefort","limburger","jarlsberg","emmental","taleggio","pecorino","cheddar","edam","asiago","stilton","munster","swis","feta","gruyere","colby","pepper-jack","gouda","manchego","blue-cheese","parmesan","mozzarella","ricotta","brie","camembert","provolone","gorgonzola","muenster","mascarpone","monterey","havarti","fromage","omelette-du-fromage",
		//misc
		"andouille","blaireau","squeak","le","hon","hun","honhonhon","baugette","cigarette","viva","fuck","tete-de-noeud","casse-toi","tabarnak","accoutrement","eiffel-tower","emmanuel-macron"
		)
	icon = 'monkestation/icons/misc/language.dmi'
	icon_state = "rattus"

/datum/species/rattus/get_species_description()
	return "Rats, rats, we're the rats. We prey at night, we stalk at night, we're the rats. I'm the giant rat that makes all of the rules. Let's see what kind of trouble we can get ourselves into."

/datum/species/rattus/get_scream_sound(mob/living/carbon/human/human)
	return 'monkestation/sound/voice/rattus/rattusscream.ogg'

/datum/species/rattus/get_laugh_sound(mob/living/carbon/human/human)
	return 'monkestation/sound/voice/rattus/rattuslaugh.ogg'

/datum/species/rattus/random_name(gender,unique,lastname)
	var/rattusname = "Rattus Norvegicus"
	if(gender == MALE)
		rattusname = "[pick(world.file2list("monkestation/strings/names/rattus_male_first.txt"))] [pick(world.file2list("monkestation/strings/names/rattus_last.txt"))]"
	else
		rattusname = "[pick(world.file2list("monkestation/strings/names/rattus_female_first.txt"))] [pick(world.file2list("monkestation/strings/names/rattus_last.txt"))]"
	return rattusname
