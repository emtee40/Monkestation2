/datum/objective/bloodling_ascend
	name = "ascend"
	martyr_compatible = TRUE
	admin_grantable = FALSE
	explanation_text = "Ascend as the ultimate being"

/datum/objective/maroon/check_completion()
	if (!owner.antag_datums.bloodling.)
		return FALSE
	return TRUE
