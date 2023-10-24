/// HORNS ///
/datum/sprite_accessory/satyr_horns
	icon = 'monkestation/icons/mob/species/satyr/satyr_horns.dmi'
	color_src = MUTCOLORS_SECONDARY

/datum/sprite_accessory/satyr_horns/tall
	name = "Tall"
	icon_state = "tall"

/datum/sprite_accessory/satyr_horns/thick
	name = "Thick"
	icon_state = "thick"

/datum/sprite_accessory/satyr_horns/back
	name = "Back"
	icon_state = "back"

/// EARS ///

/datum/sprite_accessory/satyr_ears
	color_src = MUTCOLORS_SECONDARY
	icon = 'monkestation/icons/mob/species/satyr/satyr_ears.dmi'

/datum/sprite_accessory/satyr_ears/floppy
	name = "Floppy"
	icon_state = "floppy"

/datum/sprite_accessory/satyr_ears/flat
	name = "Flat"
	icon_state = "flat"

/datum/sprite_accessory/satyr_ears/pointy
	name = "Pointy"
	icon_state = "pointy"
/// TAIL ///

/datum/sprite_accessory/tails/satyr
	icon = 'monkestation/icons/mob/species/satyr/satyr_tail.dmi'
	color_src = MUTCOLORS_SECONDARY

/datum/sprite_accessory/tails/satyr/short
	name = "Short"
	icon_state = "short"

/// FLUFF ///

/datum/sprite_accessory/satyr_fluff
	icon = 'monkestation/icons/mob/species/satyr/satyr_fluff.dmi'
	color_src = MUTCOLORS_SECONDARY
	body_slots = list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/datum/sprite_accessory/satyr_fluff/normal
	name = "Normal"
	icon_state = "normal"
	gender_specific = TRUE
