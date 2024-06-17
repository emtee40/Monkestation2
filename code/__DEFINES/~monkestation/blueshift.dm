#define RESKIN_ICON "reskin_icon"
#define RESKIN_ICON_STATE "reskin_icon_state"
#define RESKIN_WORN_ICON "reskin_worn_icon"
#define RESKIN_WORN_ICON_STATE "reskin_worn_icon_state"
#define RESKIN_SUPPORTS_VARIATIONS_FLAGS "reskin_supports_variations_flags"
#define RESKIN_INHAND_L "reskin_inhand_l"
#define RESKIN_INHAND_R "reskin_inhand_r"
#define RESKIN_INHAND_STATE "reskin_inhand_state"

/// Traits granted by glassblowing
#define TRAIT_GLASSBLOWING "glassblowing"

/// Trait that is applied whenever someone or something is glassblowing
#define TRAIT_CURRENTLY_GLASSBLOWING "currently_glassblowing"

#define TOOL_BILLOW "billow"
#define TOOL_TONG "tong"
#define TOOL_HAMMER "hammer"
#define TOOL_BLOWROD "blowrod"

// Prefix values.
#define QUECTO * 1e-30
#define RONTO * 1e-27
#define YOCTO * 1e-24
#define ZEPTO * 1e-21
#define ATTO * 1e-18
#define FEMPTO * 1e-15
#define PICO * 1e-12
#define NANO * 1e-9
#define MICRO * 1e-6
#define MILLI * 1e-3
#define KILO * 1e3
#define MEGA * 1e6
#define GIGA * 1e9
#define TERA * 1e12
#define PETA * 1e15
#define EXA * 1e18
#define ZETTA * 1e21
#define YOTTA * 1e24
#define RONNA * 1e27
#define QUETTA * 1e30

/// Category for clothing in the organics printer
#define RND_CATEGORY_AKHTER_CLOTHING "Clothing"
/// Category for equipment like belts and bags in the organics printer
#define RND_CATEGORY_AKHTER_EQUIPMENT "Equipment"
/// Category for resources made by the organics printer
#define RND_CATEGORY_AKHTER_RESOURCES "Resources"

/// Category for ingredients in the ration printer
#define RND_CATEGORY_AKHTER_FOODRICATOR_INGREDIENTS "Ingredients"
/// Category for bags and containers of reagents in the ration printer
#define RND_CATEGORY_AKHTER_FOODRICATOR_BAGS "Containers"
/// Category for snacks in the ration printer
#define RND_CATEGORY_AKHTER_FOODRICATOR_SNACKS "Luxuries"
/// Category for utensils and whatnot in the ration printer
#define RND_CATEGORY_AKHTER_FOODRICATOR_UTENSILS "Utensils"
/// Category for the seeds the organics printer can make
#define RND_CATEGORY_AKHTER_SEEDS "Synthesized Seeds"

/// Medical items in the deforest medstation
#define RND_CATEGORY_DEFOREST_MEDICAL "Emergency Medical"
/// Blood and blood bags
#define RND_CATEGORY_DEFOREST_BLOOD "Synthesized Blood"


/// The items the frontier clothing can hold
GLOBAL_LIST_INIT(colonist_suit_allowed, list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun,
	/obj/item/melee,
	/obj/item/tank/internals,
	/obj/item/storage/belt/holster,
	/obj/item/construction,
	/obj/item/fireaxe,
	/obj/item/pipe_dispenser,
	/obj/item/storage/bag,
	/obj/item/pickaxe,
	/obj/item/resonator,
	/obj/item/t_scanner,
	/obj/item/analyzer,
))

/// Trait given to objects with the wallmounted component
#define TRAIT_WALLMOUNTED "wallmounted"

/// BYOND's string procs don't support being used on datum references (as in it doesn't look for a name for stringification)
/// We just use this macro to ensure that we will only pass strings to this BYOND-level function without developers needing to really worry about it.
#define LOWER_TEXT(thing) lowertext(UNLINT("[thing]"))

// Converts cable layer to its human readable name
GLOBAL_LIST_INIT(cable_layer_to_name, list(
	"[CABLE_LAYER_1]" = CABLE_LAYER_1_NAME,
	"[CABLE_LAYER_2]" = CABLE_LAYER_2_NAME,
	"[CABLE_LAYER_3]" = CABLE_LAYER_3_NAME
))

// Converts cable color name to its layer
GLOBAL_LIST_INIT(cable_name_to_layer, list(
	CABLE_LAYER_1_NAME = CABLE_LAYER_1,
	CABLE_LAYER_2_NAME = CABLE_LAYER_2,
	CABLE_LAYER_3_NAME = CABLE_LAYER_3
))


// Zipties, cable cuffs, etc. Can be cut with wirecutters instantly.
#define HANDCUFFS_TYPE_WEAK 0
// Handcuffs... alien handcuffs. Can be cut through only by jaws of life.
#define HANDCUFFS_TYPE_STRONG 1

#define DIVINE_INTERVENTION 3
/// Sent when supermatter begins its delam countdown/when the suppression system is triggered: (var/trigger_reason)
#define COMSIG_MAIN_SM_DELAMINATING "delam_time"

#define ACCOUNT_CMD "CMD"
#define ACCOUNT_CMD_NAME "Command Budget"

#define PLAYTIME_GREEN 6000 // 100 hours

/// Macro to turn a number of laser shots into an energy cost, based on the above define
/// e.g. LASER_SHOTS(12, STANDARD_CELL_CHARGE) means 12 shots
#define LASER_SHOTS(X, MAX_CHARGE) (((100 * MAX_CHARGE) - ((100 * MAX_CHARGE) % X)) / (100 * X)) // I wish I could just use round, but it can't be used in datum members
