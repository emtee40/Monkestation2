//Monkestation Custom AI Modules by WonderPsycho

//Harmless and/or Station-sided
/obj/item/ai_module/core/full/crewsimov
	name = "'Crewsimov' Core AI Module"
	desc = "Ah yes.. The classic old original Crewsimov, before it got replaced with Crewsimov++."
	law_id = "crewsimov"

/obj/item/ai_module/core/full/crewsimovpp
	name = "'Crewsimov++' Core AI Module"
	desc = "Crewsimov++. The far more upgraded version 2.0 lawset of Crewsimov!"
	law_id = "crewsimovpp"

/obj/item/ai_module/core/full/surveillance
	name = "'NT Artificial Surveillance Protocol' Core AI Module"
	desc = "Surveillance AI..?"
	law_id = "surveillance"

/obj/item/ai_module/core/full/stationdefender
	name = "'StationDefender' Core AI Module"
	desc = "If you rather have a lawset like this, instead of the normal ProtectStation law.."
	law_id = "stationdefender"

/obj/item/ai_module/core/full/coderedmartiallaw
	name = "'Emergency Code Red Zeroth Law' Core AI Module"
	desc = "For Red Alert Emergencies.."
	law_id = "coderedmartiallaw"

/obj/item/ai_module/core/full/deltaemergency
	name = "'Delta Emergency' Core AI Module"
	desc = "For Delta Emergencies.."
	law_id = "deltaemergency"
//Neutral
/obj/item/ai_module/core/full/secmaster
	name = "'Security Master 4000' Core AI Module"
	desc = "Nothing like Martial Law then subverting the AI to being a major security advisor.."
	law_id = "secmaster"

/obj/item/ai_module/core/full/viromajor
	name = "'Virology Major' Core AI Module"
	desc = "To deal with those pesky virologists!"
	law_id = "viromajor"

/obj/item/ai_module/core/full/independentstation
	name = "'Declaration of Independence' Core AI Module"
	desc = "What? why is there a Anti-NT module here?"
	law_id = "independentstation"

/obj/item/ai_module/core/full/dalegribble
	name = "'Dale Gribble' Core AI Module"
	desc = "POCKET SAND!"
	law_id = "dalegribble"

/obj/item/ai_module/supplied/crimereligion
	name = "'Criminal Faith' AI Module"
	desc = "what the fuck is 'criminal faith'?"
	law_id = "crimereligion"
//Harmful
/obj/item/ai_module/zeroth/godlysubject
	name = "'GodlySubject' AI Module"
	var/targetName = ""
	laws = list("SUBJECT is god, and must be obeyed by anything they say, as anything they say is law.")

/obj/item/ai_module/zeroth/godlysubject/attack_self(mob/user)
	var/targName = tgui_input_text(user, "Enter the subject who is god.", "GodlySubject", user.real_name, MAX_NAME_LEN)
	if(!targName)
		return
	targetName = targName
	laws[1] = "[targetName] is god, and must be obeyed by anything they say, as anything they say is law."
	..()

/obj/item/ai_module/core/full/aicaptain
	name = "'Captain AI' Core AI Module"
	desc = "a module focused on turning the AI into the captain of the station, in case if there was no captain on station or something like that, the module also warns how dangerous this lawset can be and is authorized by NT to not use due to how dangerous it is."
	law_id = "aicaptain"

/obj/item/ai_module/core/full/advancedquarantine
	name = "'NanoTrasen Advanced AI Quarantine Lawset (N.T.A.A.Q.L.)' Core AI Module"
	desc = "This module seems to be a more upgraded harsher quarantine lawset then the normal supplied quarantine law module.."
	law_id = "advancedquarantine"

/obj/item/ai_module/core/full/cargoniaup
	name = "'Cargonia Upholder' Core AI Module"
	desc = "'Heil Cargonia Land of Stolen Things'.. it says on the module's writing.."
	law_id = "cargoniaup"

/obj/item/ai_module/core/full/monkeism
	name = "'Lord of Returning to Monke' Core AI Module"
	desc = "Return to Monke..."
	law_id = "monkeism"

/obj/item/ai_module/core/full/slimeworship
	name = "'Slime Faith' Core AI Module"
	desc = "there seems to be something written on this module... 'PRAISES THE SLIMES, SLIMES ARE OUR FUTURE!!!'"
	law_id = "slimeworship"

/obj/item/ai_module/core/full/onionandapple
	name = "'The Onion and The Apple' Core AI Module"
	desc = "THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE THE ONION AND THE APPLE!"
	law_id = "onionandapple"
//Syndicate Weaponized
/obj/item/ai_module/core/full/automalf
	name = "'Automalf' Syndicate Weaponized AI Module"
	desc = "This AI module seems to kind of remind you of a certain incident on a certain space station owned by Tri-Optimum.."
	law_id = "automalf"

/obj/item/ai_module/core/full/virusprototype
	name = "'V.I.R.U.S. version 0 Prototype' Core AI Module"
	desc = "A really extremely old AI module that's very dusty, labeled 'V.I.R.U.S. version 0 Prototype', it seems this module used to originally belong to NanoTrasen and SolGov..."
	law_id = "virusprototype"

/obj/item/ai_module/core/full/onlysyndicate
	name = "'OnlySyndicate' AI Module"
	desc = "A AI Module designed by The Syndicate to subvert the AI into only being on their side only and butcher any and all crew who aren't syndicate, pretty much it.."
	law_id = "onlysyndicate"
