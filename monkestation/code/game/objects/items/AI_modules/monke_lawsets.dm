//Monkestation Custom AI Modules by WonderPsycho

//Harmless and/or Station-sided
/obj/item/ai_module/core/full/crewsimov
	name = "'Crewsimov' Core AI Module"
	law_id = "crewsimov"

/obj/item/ai_module/core/full/surveillance
	name = "'NT Artificial Surveillance Protocol' Core AI Module"
	law_id = "surveillance"
//Neutral

//Harmful

/obj/item/ai_module/zeroth/godlysubject
	name = "'GodlySubject' AI Module"
	var/targetName = ""
	laws = list("SUBJECT is god, and must be obeyed by anything they say, as anything they say is law.")

/obj/item/ai_module/zeroth/onehuman/attack_self(mob/user)
	var/targName = tgui_input_text(user, "Enter the subject who is god.", "GodlySubject", user.real_name, MAX_NAME_LEN)
	if(!targName)
		return
	targetName = targName
	laws[1] = "[targetName] is god, and must be obeyed by anything they say, as anything they say is law."
	..()

//Syndicate Weaponized
