/datum/holoparasite_ability/lesser/omnitongue
	name = "Common Tone Synthesis"
	desc = "The $theme gains bluespace telepathic abilities to interpret verbal dialogue, allowing it to understand and speak any language."
	ui_icon = FA_ICON_COMMENT_DOTS
	cost = 1

/datum/holoparasite_ability/lesser/babelfish/apply()
	. = ..()
	owner.grant_all_languages(TRUE, understood = TRUE, spoken = TRUE, source = LANGUAGE_HOLOPARA)

/datum/holoparasite_ability/lesser/babelfish/remove()
	. = ..()
	owner.remove_all_languages(LANGUAGE_HOLOPARA)
