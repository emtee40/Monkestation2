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

/obj/item/ai_module/core/full/aicaptain
	name = "'Captain AI' Core AI Module"
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
	desc = "a really extremely old AI module that's very dusty, labeled 'V.I.R.U.S. version 0 Prototype', it seems this module used to originally belong to NanoTrasen and SolGov..."
	law_id = "virusprototype"
