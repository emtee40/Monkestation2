/datum/round_event_control/cloner_corruption
	name = "Experimental Cloner Corruption"
	typepath = /datum/round_event/cloner_corruption
	max_occurrences = 1
	weight = 3
	category = EVENT_CATEGORY_ENTITIES //Kinda, evil clones ARE entities.
	track = EVENT_TRACK_MODERATE //What do I set this to? Evil clones start with no gear and are obvious, they'll get slaughtered the moment they get found out. (Which will probably be soon as cloners tend to be made in public areas.)
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT)

/datum/round_event/cloner_corruption/start()
	for(var/obj/machinery/clonepod/experimental/cloner in GLOB.machines)
		if(!cloner.locked)
			cloner.evil_objective = pick(subtypesof(/datum/objective/evil_clone))
			cloner.RefreshParts()
