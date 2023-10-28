/datum/uplink_item/role_restricted/minibible
	name = "Miniature Bible"
	desc = "We understand it can be difficult to carry out some of our missions. Here is some spiritual counsel in a small package."
	progression_minimum = 5 MINUTES
	cost = 1
	item = /obj/item/storage/book/bible/mini
	restricted_roles = list(JOB_CHAPLAIN, JOB_CLOWN)

/datum/uplink_item/role_restricted/mayhem
	name = "Bottle Of Mayhem"
	desc = "This fragile relic was found within a bloody, flesh covered ruin within the depths of lavaland.\
	After careful analysis, we have determined that it will induce a murderous psycosis within anyone around it when it is smashed.\
	Beware, you have to smash it in your hands, and you will be caught in the psycosis, you will not be safe... use with extreme caution."
	progression_minimum = 0 MINUTES
	cost = 20
	item = /obj/item/mayhem
	restricted_roles = list(JOB_CURATOR)
