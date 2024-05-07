/// Blacklist of limb IDs which should not appear when bioscrambled, mostly because they looks awful and buggy.
GLOBAL_LIST_INIT(bioscrambler_limb_id_blacklist, list(
	BODYPART_ID_PSYKER,
	SPECIES_SIMIAN,
	SPECIES_MONKEY,
	SPECIES_GOBLIN
))
