/*
Lizard subspecies: DRACONIDS
You only get them from a dragon's bottle, they get 10% armor
*/
/datum/species/lizard/draconid
	name = "Draconid"
	id = SPECIES_LIZARD_DRACONID
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
	)
	inherent_traits = list(
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)
	changesource_flags = MIRROR_BADMIN | RACE_SWAP | ERT_SPAWN

	armor = 10
