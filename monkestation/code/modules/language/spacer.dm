/datum/language/spacer
	name = "Spacer"
	desc = "When in deep space, humans sometimes use this rudimentary language as an emergency form of communication when nothing else can be used."
	key = "="
	space_chance = 40
	syllables = list(
		"est", "ma", "ter", "aes", "au", "la", "ter", "zen", "tius","cere", "ire",
		"in", "icio", "pe", "ius", "con", "fer", "mag", "am", "nus", "ant", "cio",
		"tu", "ego", "vos", "nos", "ea", "ille", "idem", "ipse", "dex", "re", "vi",
		"fe", "min", "stra", "tum", "iter", "vol", "kris", "vol", "ex"
	)						//Uses the most common latin syllables.
	icon_state = "spacer"
	default_priority = 90

// Humans really need their own language

/datum/language_holder/human
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/spacer = list(LANGUAGE_ATOM),
								/datum/language/uncommon = list(LANGUAGE_ATOM))		//Foreigner humans have it ROUGH. This makes it a little less rough on them.

	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/spacer = list(LANGUAGE_ATOM))

