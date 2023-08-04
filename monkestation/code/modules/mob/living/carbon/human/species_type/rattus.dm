/datum/species/rattus
	name = "Rattus Norvegicus"
	id = SPECIES_RATTUS

	bodytype = BODYTYPE_CUSTOM

	species_traits = list(
		MUTCOLORS,
		DYNCOLORS,
		NOEYESPRITES,
		NO_UNDERWEAR,
		)
	inherent_traits = list(
		TRAIT_VAULTING,
		)

	use_skintones = FALSE
	use_fur = FALSE

	inherent_biotypes = list(
		MOB_ORGANIC,
		MOB_HUMANOID,
		)

	changesource_flags = MIRROR_BADMIN | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	meat = /obj/item/food/meat/slab/mouse
	species_cookie = /obj/item/food/cheese/wedge
	disliked_food = GROSS
	liked_food = DAIRY | SUGAR
	speedmod = -0.3
	brutemod = 1.45
	burnmod = 1.1
	siemens_coeff = 1.5

	family_heirlooms = list(
		/obj/item/coin/iron,
		/obj/item/coin/gold,
		/obj/item/coin/silver,
		/obj/item/coin/diamond,
		/obj/item/coin/plasma,
		/obj/item/coin/uranium,
		/obj/item/coin/titanium,
		/obj/item/coin/bananium,
		/obj/item/coin/adamantine,
		/obj/item/coin/mythril,
		/obj/item/coin/plastic,
		/obj/item/coin/runite,
		/obj/item/coin/twoheaded,
		/obj/item/coin/antagtoken,
		)
	//these icons need to be replaced in th future with the offsets removed
	custom_worn_icons = list(
		LOADOUT_ITEM_SUIT = SIMIAN_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = SIMIAN_UNIFORM_ICON,
		LOADOUT_ITEM_GLASSES = SIMIAN_GLASSES_ICON,
		LOADOUT_ITEM_GLOVES = SIMIAN_GLOVES_ICON,
		LOADOUT_ITEM_NECK = SIMIAN_NECK_ICON,
		LOADOUT_ITEM_SHOES = SIMIAN_SHOES_ICON,
		LOADOUT_ITEM_BELT = SIMIAN_BELT_ICON,
		LOADOUT_ITEM_MISC = SIMIAN_BACK_ICON,
		)
	offset_features = list(
		OFFSET_HANDS = list(0,-2),
		OFFSET_UNIFORM = list(0,-6),
		OFFSET_ID = list(0,-5),
		OFFSET_GLOVES = list(0,0),
		OFFSET_GLASSES = list(0,-11),
		OFFSET_EARS = list(0,-5),
		OFFSET_SHOES = list(0,2),
		OFFSET_S_STORE = list(0,-11),
		OFFSET_FACEMASK = list(0,-5),
		OFFSET_HEAD = list(0,-5),
		OFFSET_FACE = list(0,-5),
		OFFSET_BELT = list(0,-11),
		OFFSET_BACK = list(0,-2),
		OFFSET_SUIT = list(0,-6),
		OFFSET_NECK = list(0,-8),
		OFFSET_ACCESSORY = list(0,-6),
		)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/rattus,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/rattus,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/rattus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/rattus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/rattus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/rattus,
		)

/datum/species/rattus/get_species_description()
	return "Rattus Norvegicus -  are highly (un)intelligent \
	rat from the world \ Eldoria, a plannet with 8th century \
	technology and manners. \
	*violently slams the Rats Birthday Mixtape into the boombox*"

/datum/species/rattus/random_name(gender,unique,lastname)
	var/randname = rattus_name(gender)
	if(lastname)
		randname += " [lastname]"
	return randname
