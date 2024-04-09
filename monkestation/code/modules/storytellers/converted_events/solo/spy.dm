/datum/round_event_control/antagonist/solo/spy/roundstart
	name = "Spy"
	antag_flag = ROLE_SPY
	tags = list(TAG_COMBAT)
	antag_datum = /datum/antagonist/spy
	roundstart = TRUE
	weight = 5
	cost = 8
	base_antags = 7
	maximum_antags = 9
	earliest_start = 0 SECONDS
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
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
