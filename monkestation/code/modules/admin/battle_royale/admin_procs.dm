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
	var/input = tgui_alert(usr, "Do you want to quick start a battle royale?", "Battle royale", list("Normal(20 min max duration)", "Fast(10 min max duration)", "The lame option"))
	if(input == "The lame option")
		return

	if(tgui_alert(usr, "Cancel battle royale?", "Battle royale", list("Yes", "No")) != "No")
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
