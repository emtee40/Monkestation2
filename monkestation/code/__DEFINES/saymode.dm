/datum/saymode/bloodling
	key = "9"
	mode = MODE_BLOODLING

/datum/saymode/changeling/handle_message(mob/living/user, message, datum/language/language)
	//we can send the message
	if(!user.mind)
		return FALSE
	var/datum/antagonist/bloodling_sender = IS_BLOODLING_OR_THRALL(user)
	if(!bloodling_sender)
		return FALSE

	user.log_talk(message, LOG_SAY, tag="bloodling [user]")
	var/msg = span_changeling("<b>[user]:</b> [message]")

	//the recipients can recieve the message
	for(var/datum/antagonist/reciever in GLOB.antagonists)
		if(!reciever.owner)
			continue
		if(!IS_BLOODLING_OR_THRALL(reciever.owner.current))
			continue
		var/mob/living/ling_mob = reciever.owner.current
		to_chat(ling_mob, msg)

	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		to_chat(ghost, "[FOLLOW_LINK(ghost, user)] [msg]")
	return FALSE
