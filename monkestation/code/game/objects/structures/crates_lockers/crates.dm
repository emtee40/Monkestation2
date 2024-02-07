#define CRATE_COLOR_BLOOD_FREEZER		"#fe3435"
// should be a darker, metallic gray
#define CRATE_COLOR_SURPLUS_LIMBS		"#3c3c3c"

/obj/structure/closet/crate/freezer/blood/Initialize(mapload)
	. = ..()
	add_atom_colour(CRATE_COLOR_BLOOD_FREEZER, FIXED_COLOUR_PRIORITY)

/obj/structure/closet/crate/freezer/surplus_limbs/Initialize(mapload)
	. = ..()
	add_atom_colour(CRATE_COLOR_SURPLUS_LIMBS, FIXED_COLOUR_PRIORITY)

#undef CRATE_COLOR_SURPLUS_LIMBS
#undef CRATE_COLOR_BLOOD_FREEZER
