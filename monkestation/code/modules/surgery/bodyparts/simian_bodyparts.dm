/obj/item/bodypart/head/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM

	dmg_overlay_type = "monkey"

/obj/item/bodypart/chest/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM

	dmg_overlay_type = "monkey"

/obj/item/bodypart/arm/left/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM

	dmg_overlay_type = "monkey"

/obj/item/bodypart/arm/left/simian/Initialize(mapload)// Honestly this is a guess
	held_hand_offset =  new(
		attached_part = src,
		feature_key = OFFSET_HELD,
		offset_y = list("south" = 3),
	)
	return ..()

/obj/item/bodypart/arm/right/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM

	dmg_overlay_type = "monkey"

/obj/item/bodypart/arm/right/simian/Initialize(mapload)// Honestly this is a guess
	held_hand_offset =  new(
		attached_part = src,
		feature_key = OFFSET_HELD,
		offset_y = list("south" = 3),
	)
	return ..()

/obj/item/bodypart/leg/left/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

/obj/item/bodypart/leg/right/simian
	icon_greyscale =  'monkestation/icons/mob/species/simian/bodyparts.dmi'
	husk_type = "simian"
	limb_id = SPECIES_SIMIAN
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	footprint_sprite = FOOTPRINT_SPRITE_PAWS

	dmg_overlay_type = "monkey"
