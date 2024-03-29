/// Ensures that all runnable events have a valid, non-blank name.
/datum/unit_test/event_names

/datum/unit_test/event_names/Run()
	for(var/datum/round_event_control/event as anything in subtypesof(/datum/round_event_control))
		if(!ispath(event::typepath, /datum/round_event))
			continue
		if(!istext(event::name) || !length(trim(event::name)))
			TEST_FAIL("[event] does not have a proper name set!")
