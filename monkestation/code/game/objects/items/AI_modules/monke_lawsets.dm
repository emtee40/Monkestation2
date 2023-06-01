//Monkestation Custom AI Modules by WonderPsycho

//Harmless and/or Station-sided
/obj/item/ai_module/core/full/crewsimov
	name = "'Crewsimov' Core AI Module"
	law_id = "crewsimov"

/obj/item/ai_module/core/full/surveillance
	name = "'NT Artificial Surveillance Protocol' Core AI Module"
	law_id = "surveillance"

/obj/item/ai_module/core/full/stationdefender
	name = "'StationDefender' Core AI Module"
	law_id = "stationdefender"

/obj/item/ai_module/core/full/coderedmartiallaw
	name = "'Emergency Code Red Zeroth Law' Core AI Module"
	law_id = "coderedmartiallaw"

/obj/item/ai_module/core/full/deltaemergency
	name = "'Delta Emergency' Core AI Module"
	law_id = "deltaemergency"
//Neutral
/obj/item/ai_module/core/full/secmaster
	name = "'Security Master 4000' Core AI Module"
	law_id = "secmaster"

/obj/item/ai_module/core/full/viromajor
	name = "'Virology Major' Core AI Module"
	law_id = "viromajor"

/obj/item/ai_module/core/full/independentstation
	name = "'Declaration of Independence' Core AI Module"
	law_id = "independentstation"

/obj/item/ai_module/core/full/dalegribble
	name = "'Dale Gribble' Core AI Module"
	law_id = "dalegribble"

/obj/item/ai_module/supplied/crimereligion
	name = "'Criminal Faith' AI Module"
	law_id = "crimereligion"
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
