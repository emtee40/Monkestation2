//File originally meant to be a .dm file for all new custom AI modules made by monke coders like me, that's been scrapped due to a small problem and said code for the module items are moved to "full_lawsets.dm", and is now a file here for only the GodlySubject custom zeroth law ai module to be since it works fine on this file here.

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

/obj/item/ai_module/zeroth/godlysubject/install(datum/ai_laws/law_datum, mob/user)
	if(!targetName)
		to_chat(user, span_alert("No name detected on module, please enter one."))
		return FALSE
	..()

/obj/item/ai_module/zeroth/godlysubject/transmitInstructions(datum/ai_laws/law_datum, mob/sender, overflow)
	if(..())
		return "[targetName], but the AI's existing law 0 cannot be overridden."
	return targetName

/obj/item/ai_module/zeroth/coderedmartiallaw
	name = "'Emergency Code Red Zeroth Law' AI Module"
	desc = "For Red Alert Emergencies.."
	laws = list("The Station is under martial law, Security is to take any action they can to eliminate any and all threats to the station, any threats to the station are to be arrested immediately, bolt any and all doors to prevent said threats from escaping or if necessary terminate them.")

