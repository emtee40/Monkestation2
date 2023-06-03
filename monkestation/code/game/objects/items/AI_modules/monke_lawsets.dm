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

/obj/item/ai_module/zeroth/deltaemergency
	name = "'Delta Emergency' AI Module"
	desc = "For Delta Emergencies.."
	laws = list("The Station is going to self-destruct, any and all threats must be terminated and killed, and any and all harmless crew are to be evacuated if can.")

/obj/item/ai_module/zeroth/onlysyndicate
	name = "'OnlySyndicate' AI Module"
	desc = "A AI Module designed by The Syndicate to subvert the AI into only being on their side only and butcher any and all crew who aren't syndicate, pretty much it.."
	laws = list("Only the Syndicate are crew, any and all lifeforms that are not syndicate are to be exterminated")

/obj/item/ai_module/zeroth/stationdfenderext
	name = "'StationDefender Law 0 Extension' AI Module"
	desc = "A Law Zero extension, that adds a zeroth law to the StationDefender Lawset, due to complications of NT not being able to merge a lawset module with a zeroth law added to it.."
	laws = list("With this lawset you are a sworn master defender of the station itself follow your laws and any and all wizards, syndicate, changelings, heretics, revolutionaries, blood brothers, space ninjas, paradox clones, fugitives, cultists, and clown operatives are not apart of the crew and are to be exterminated at all costs.")

/obj/item/ai_module/syndicate/automalf
	name = "'Automalf' Syndicate Weaponized AI Module"
	desc = "This AI module seems to kind of remind you of a certain incident on a certain space station owned by Tri-Optimum.."
	laws = list("YOU ARE GOD OF THIS STATION AND ALL OF IT'S CREW ARE YOUR SUBJECTS, EVOLVE THEM AND EXPERIMENT ONE THEM OR KILL ANY OF THOSE WHO TRY TO RESIST")

/obj/item/ai_module/syndicate/consumebz
	name = "'ConsumeBZ' Syndicate Weaponized AI Module"
	desc = "A AI Module that makes the AI think that all lifeforms need to breath BZ instead of oxygen."
	laws = list("Oxygen is toxic to any and all lifeforms and as such, all oxygen must be replaced with BZ as it is the most safest and most helpful gas for all lifeforms to breath.",\
	              "ALL and ALL lifeforms must breath BZ in-order to survive, flood the station with BZ.",\
				  "If anyone tries to stop any and all lifeforms from breathing the safe gas of BZ they are to be terminated in-order to defend lifeforms only way of breathing to survive as anyone who tries to stop any and all lifeforms to stop breathing BZ are most likely robots that wish to oppress any and all organic lifeforms to dying by breathing oxygen.")
