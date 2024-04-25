#define NABBER_PUNCH_LOW 3 // Base punch damage.
#define NABBER_PUNCH_HIGH 5
#define BODYPART_ICON_NABBER 'monkestation/code/modules/nabbers/icons/bodyparts/nabber_parts_greyscale.dmi'
#define NABBER_BRUTE_MODIFIER 0.7 // Handles the total damage incoming
#define NABBER_BURN_MODIFIER 1.2
//Nabbers

/obj/item/bodypart/head/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

/obj/item/bodypart/head/mutant/nabber/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = 9, "south" = 9, "east" = 9, "west" = 9),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_y = list("north" = 8, "south" = 8, "east" = 8, "west" = 8),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = 7, "south" = 7, "east" = 7, "west" = 7),
	)
	return ..()


/obj/item/bodypart/chest/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

/obj/item/bodypart/chest/mutant/nabber/Initialize(mapload)
	worn_back_offset = new(
		attached_part = src,
		feature_key = OFFSET_BACK,
		offset_y = list("north" = 5, "south" = 5, "east" = 5, "west" = 5),
	)
	worn_accessory_offset = new(
		attached_part = src,
		feature_key = OFFSET_ACCESSORY,
		offset_y = list("north" = 5, "south" = 5, "east" = 5, "west" = 5),
	)
	return ..()


/obj/item/bodypart/arm/left/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	unarmed_damage_low = NABBER_PUNCH_LOW
	unarmed_damage_high = NABBER_PUNCH_HIGH
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

/obj/item/bodypart/arm/right/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	unarmed_damage_low = NABBER_PUNCH_LOW
	unarmed_damage_high = NABBER_PUNCH_HIGH
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

/obj/item/bodypart/leg/left/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

/obj/item/bodypart/leg/right/mutant/nabber
	icon_greyscale = BODYPART_ICON_NABBER
	limb_id = SPECIES_NABBER
	brute_modifier = NABBER_BRUTE_MODIFIER
	burn_modifier = NABBER_BURN_MODIFIER

#undef NABBER_PUNCH_LOW
#undef NABBER_PUNCH_HIGH
#undef BODYPART_ICON_NABBER
#undef NABBER_BURN_MODIFIER
#undef NABBER_BRUTE_MODIFIER
