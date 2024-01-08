GLOBAL_VAR_INIT(looc_allowed, TRUE) //used with admin verbs to disable/enable looc

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	VALIDATE_CLIENT(src)

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, span_danger("LOOC is globally muted."))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("You cannot use OOC (muted)."))
			return
		if(is_banned_from(ckey, "OOC"))
			to_chat(src, span_danger("You have been banned from OOC."))
			return
	if(istype(mob, /mob/dead))
		to_chat(src, span_danger("You cannot use LOOC as a ghost!"))
		return
	if(mob.stat == DEAD)
		to_chat(src, span_danger("You cannot use LOOC as a dead mob!"))
		return

	msg = trim(copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN))
	log_ooc("(LOCAL) [mob.name]/[key] : [msg]")
	mob.log_message("(LOCAL): [msg]", INDIVIDUAL_OOC_LOG)

	var/list/heard = get_hearers_in_view(7, (src.mob))
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client
		if(C.prefs.toggles & CHAT_OOC)
			to_chat(C, "<span class='oocplain'><B><font color='#6699CC'>LOOC: [src.mob.name] : <span class='message linkify'>''[msg]''<B></font></span></span>")

	for(var/client/A in GLOB.admins)
		if(A.prefs.toggles & CHAT_OOC)
			to_chat(A, "<span class='oocplain'><B>[ADMIN_LOOKUPFLW(src.mob)]<font color='#6699CC'> LOOC: <span class='message linkify'>''[msg]''<B></font></span></span>")

//keybinding
#define COMSIG_KB_CLIENT_LOOC_DOWN "keybinding_client_looc_down"
/datum/keybinding/client/communication/looc
	hotkey_keys = list("")
	category = CATEGORY_COMMUNICATION
	name = "looc"
	full_name = "Local Out Of Character Say (LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/looc/down(client/user)
	. = ..()
	if(.)
		return
	user.looc()
	return TRUE

//admin tool
/proc/toggle_looc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != GLOB.looc_allowed)
			GLOB.looc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.looc_allowed = !GLOB.looc_allowed
	to_chat(world, "<span class='oocplain'><B>The LOOC has been globally [GLOB.looc_allowed ? "enabled" : "disabled"].</B></span>")

/datum/admins/proc/togglelooc()
	set category = "Server"
	set name = "Toggle LOOC"
	toggle_looc()
	log_admin("[key_name(usr)] toggled LOOC.")
	message_admins("[key_name_admin(usr)] toggled LOOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle LOOC", "[GLOB.looc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
