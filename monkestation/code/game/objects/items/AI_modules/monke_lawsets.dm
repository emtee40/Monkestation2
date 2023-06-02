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


