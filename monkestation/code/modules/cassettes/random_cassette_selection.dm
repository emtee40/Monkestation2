GLOBAL_LIST_INIT(approved_cassettes, initialize_approved_cassettes())

/proc/unique_random_tapes(amt = 1)
	. = list()
	if(!length(GLOB.approved_cassettes))
		GLOB.approved_cassettes = initialize_approved_cassettes()
		if(!length(GLOB.approved_cassettes))
			return
	var/list/cassettes_to_choose = GLOB.approved_cassettes.Copy()
	amt = min(amt, length(cassettes_to_choose))
	for(var/i in 1 to amt)
		var/datum/cassette/cassette_tape/cassette = pick_n_take(cassettes_to_choose)
		. += cassette.id

/proc/initialize_approved_cassettes()
	var/ids_exist = file("data/cassette_storage/ids.json")
	if(!fexists(ids_exist))
		return list()
	var/approved_ids = json_decode(file2text(ids_exist))
	var/list/cassettes = list()
	for (var/id in approved_ids)
		cassettes += new /datum/cassette/cassette_tape(id)
	return cassettes


/obj/item/device/cassette_tape/random
	name = "Not Correctly Created Random Cassette"
	desc = "How did this happen?"
	random = TRUE
	id = "not_randomized"
