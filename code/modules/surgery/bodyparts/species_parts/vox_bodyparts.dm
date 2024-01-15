// voxs!
/obj/item/bodypart/head/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_BEAK
	limb_id = SPECIES_VOX
	is_dimorphic = FALSE
	has_icon_variants = TRUE
	has_static_sprite_part = TRUE
	limb_icon_variant = "green"
	should_draw_greyscale = FALSE

/obj/item/bodypart/chest/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_OTHER
	limb_id = SPECIES_VOX
	is_dimorphic = FALSE
	has_icon_variants = TRUE
	limb_icon_variant = "green"
	should_draw_greyscale = FALSE
	has_static_sprite_part = TRUE

/obj/item/bodypart/arm/left/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_OTHER
	limb_id = SPECIES_VOX
	has_icon_variants = TRUE
	limb_icon_variant = "green"
	unarmed_attack_verb = "slash"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/weapons/slashmiss.ogg'
	should_draw_greyscale = FALSE
	has_static_sprite_part = TRUE

/obj/item/bodypart/arm/right/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_OTHER
	limb_id = SPECIES_VOX
	has_icon_variants = TRUE
	limb_icon_variant = "green"
	unarmed_attack_verb = "slash"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/weapons/slashmiss.ogg'
	should_draw_greyscale = FALSE
	has_static_sprite_part = TRUE

/obj/item/bodypart/leg/left/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_LEGS
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	has_icon_variants = TRUE
	limb_icon_variant = "green"
	should_draw_greyscale = FALSE
	has_static_sprite_part = TRUE

/obj/item/bodypart/leg/right/vox
	icon = 'icons/mob/species/vox/bodyparts.dmi'
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_VOX_LEGS
	icon_static = 'icons/mob/species/vox/bodyparts.dmi'
	limb_id = SPECIES_VOX
	should_draw_greyscale = FALSE
	has_icon_variants = TRUE
	limb_icon_variant = "green"
	has_static_sprite_part = TRUE
