/client/proc/spawn_mixtape()
	set category = "Admin.Game"
	set name = "Spawn Mixtape"
	set desc = "Select an approved mixtape to spawn at your location."

	/*
	TODO: TGUI SHIT (RPD has a good baseline for what i want iirc)
	*/

	if(!holder)
		return
	if(!length(GLOB.approved_cassettes))
		GLOB.approved_cassettes = initialize_approved_cassettes()
	var/list/choices = list()
	for (var/datum/cassette/cassette_tape/tape as anything in GLOB.approved_cassettes)
		choices += tape.id
	if(choices.len <= 0)
		return
	var/choice = tgui_input_list(src, "Select which tape to spawn. These are IDs, not names, but the IDs should end with the ckey.", "Select Mixtape to Spawn", choices)
	if(isnull(choice))
		return

	new/obj/item/device/cassette_tape(usr.loc, choice)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Mixtape")
	log_admin("[key_name(usr)] created mixtape [choice] at [usr.loc].")
