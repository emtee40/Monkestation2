GLOBAL_LIST_INIT(rattus_last_names, world.file2list("monkestation/strings/names/rattus_last.txt"))
GLOBAL_LIST_INIT(rattus_names_female, world.file2list("monkestation/strings/names/rattus_female_first.txt"))
GLOBAL_LIST_INIT(rattus_names_male, world.file2list("monkestation/strings/names/rattus_male_first.txt"))

/proc/rattus_name(gender)
	if(gender == MALE)
		return "[pick(GLOB.rattus_names_male)] [pick(GLOB.rattus_last_names)]"
	else
		return "[pick(GLOB.rattus_names_female)] [pick(GLOB.rattus_last_names)]"
