/datum/mood_event/nanite_sadness
	description = "+++++++HAPPINESS SUPPRESSION+++++++</span>"
	mood_change = -7

/datum/mood_event/nanite_sadness/add_effects(message)
	description = "<span class='warning robot'>+++++++[message]+++++++</span>"

/datum/mood_event/saw_holopara_death
	description = span_warning("Oh god, they just painfully turned to dust... What an horrifying sight...</span>")
	mood_change = -10
	timeout = 15 MINUTES

/datum/mood_event/saw_holopara_death/add_effects(name)
	description = span_warning("Oh god, [name] just painfully turned to dust... What an horrifying sight...")
