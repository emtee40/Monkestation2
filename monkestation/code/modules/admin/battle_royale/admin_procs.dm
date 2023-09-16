///Runs a quick set up battle royale
/client/proc/battleRoyaleEasySetup()
	set name = "Easy Set Up Battle Royale"
	set category = "Admin.Fun"

	if(!holder || !check_rights(R_FUN))
		return

	holder.battle_royale_easy_setup()

/datum/admins/proc/battle_royale_easy_setup()
	if(!check_rights(R_FUN))
		return

	if(!GLOB.battle_royale_controller)
		GLOB.battle_royale_controller = new

	if(GLOB.battle_royale_controller?.active)
		to_chat(usr, span_warning("A game has already started!"))
		return

	//as LME requested saying no is as obtuse as possible(will be made less so for full merge)
	var/input = tgui_alert(usr, "Do you want to quick start a battle royale?", "Battle royale", list("Normal(25 min max duration)", "Fast(10 min max duration)", "The lame option"))
	if(input == "The lame option")
		input = tgui_alert(usr, "Do you not want to quick start a battle royale?", "Battle royale", list("Yes", "No"))

	if(input == "Yes")
		input = tgui_alert(usr, "You do not hold us legally accountable for the effects of saying no.", "Battle royale", list("Yes", "No"))

	if(input == "Yes")
		input = tgui_alert(usr, "Are you not sure you dont not want us to not do a non battle royale?", "Battle royale", list("Yes", "No"))

	if(input == "Yes")
		input = tgui_alert(usr, "Are you sure about that?", "Battle royale", list("Yes", "No"))

	if(input == "Yes")
		return

	if(!SSticker.current_state == GAME_STATE_FINISHED) //this is a joke, we dont want to ruin an ongoing round
		if(tgui_alert(usr, "Cancel battle royale?", "Battle royale", list("Yes", "No")) == "Yes")
			return

	message_admins("[key_name_admin(usr)] has triggered battle royale.")
	log_admin("[key_name(usr)] has triggered battle royale.")
	GLOB.battle_royale_controller.setup((input == "Fast(10 min max duration)") ? TRUE : FALSE)

/client/proc/battleRoyalePanel()
	set name = "Battle Royale Panel"
	set category = "Admin.Fun"

	if(!holder || !check_rights(R_FUN))
		return

	if(!GLOB.battle_royale_controller)
		GLOB.battle_royale_controller = new

	GLOB.battle_royale_controller?.ui_interact(usr)
