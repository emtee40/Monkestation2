/datum/round_event_control/antagonist/solo/bloodling
	antag_flag = ROLE_BLOODLING
	antag_datum = /datum/antagonist/bloodling
	tags = list(TAG_COMBAT, TAG_TEAM_ANTAG)
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_PERSONNEL,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_RESEARCH_DIRECTOR,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_SECURITY_ASSISTANT,
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG
	)
	enemy_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_DETECTIVE,
		JOB_WARDEN,
		JOB_SECURITY_OFFICER,
		JOB_SECURITY_ASSISTANT,
	)
	required_enemies = 3
	weight = 4
	max_occurrences = 1
	maximum_antags = 2
	denominator = 30

/datum/round_event_control/antagonist/solo/bloodling/roundstart
	name = "Bloodling"
	roundstart = TRUE
	earliest_start = 0 SECONDS
