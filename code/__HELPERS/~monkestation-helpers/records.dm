/proc/get_crew_record(name, rank)
	if(!istext(name))
		return
	for(var/datum/record/crew/crew_record as anything in GLOB.manifest.general)
		if(QDELETED(crew_record))
			continue
		if(crew_record.name != name)
			continue
		if(istext(rank) && rank != "N/A" && crew_record.trim != rank)
			continue
		return crew_record

/proc/purge_crew_record(name, rank, save_record = FALSE)
	var/datum/record/crew/crew_record = get_crew_record(name, rank)
	if(QDELETED(crew_record))
		return
	GLOB.manifest.general -= crew_record
	if(save_record)
		return crew_record
	else
		qdel(crew_record)

