/datum/objective/bloodling_ascend
	name = "ascend"
	martyr_compatible = TRUE
	admin_grantable = FALSE
	explanation_text = "Ascend as the ultimate being"

/datum/objective/maroon/check_completion()
	var/datum/antagonist/bloodling/bloodling = owner.mind.has_antag_datum(/datum/antagonist/bloodling,TRUE)
	if (!bloodling.is_ascended)
		return FALSE
	return TRUE
