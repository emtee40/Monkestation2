/client/proc/spawn_mixtape()
	set category = "Admin.Game"
	set name = "Spawn Mixtape"
	set desc = "Select an approved mixtape to spawn at your location."

	if(!holder)
		return
	var/list/choices = GLOB.approved_ids
	if(choices.len <= 0)
		return
	var/choice = tgui_input_list(src, "Select which tape to spawn. These are IDs, not names, but the IDs should end with the ckey.", "Select Mixtape to Spawn", choices)
	if(isnull(choice))
		return

	new/obj/item/device/cassette_tape(usr.loc, choice)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Mixtape")
	log_admin("[key_name(usr)] created mixtape [choice] at [usr.loc].")
