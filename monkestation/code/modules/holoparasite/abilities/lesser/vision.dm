/datum/holoparasite_ability/lesser/vision
	name = "Thermal Vision"
	desc = "The $theme gains thermal vision, allowing it to see living beings through walls."
	ui_icon = FA_ICON_FIRE
	cost = 1
	traits = list(TRAIT_THERMAL_VISION)
	thresholds = list(
		list(
			"stats" = list(
				list(
					"name" = "Range",
					"minimum" = 4
				),
				list(
					"name" = "Potential",
					"minimum" = 5
				)
			),
			"desc" = "The $theme becomes capable of x-ray vision, allowing it to see everything through walls and solid objects."
		)
	)
	var/xray = FALSE

/datum/holoparasite_ability/lesser/vision/apply()
	. = ..()
	if(xray)
		add_owner_trait(TRAIT_XRAY_VISION)

/datum/holoparasite_ability/lesser/vision/setup_thresholds()
	. = ..()
	xray = master_stats.range >= 4 && master_stats.potential >= 5
