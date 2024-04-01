/datum/action/brother_comms
	name = "Blood Bond"
	desc = "Communicate privately with your fellow blood brother(s)."
	check_flags = AB_CHECK_CONSCIOUS
	var/datum/antagonist/brother/bond

/datum/action/brother_comms/New(datum/antagonist/brother/target)
	if(!istype(target))
		CRASH("Attempted to create [type] without an associated antag datum!")
	src.bond = target
	return ..()

/datum/action/brother_comms/IsAvailable(feedback)
	if(QDELETED(bond) || bond.owner != owner.mind)
		return FALSE
	var/datum/team/brother_team/team = bond.get_team()
	if(QDELETED(team) || !(owner.mind in team.members))
		return FALSE
	if(length(team.members) < 2)
		if(feedback)
			owner.balloon_alert(owner, "no blood brothers to communicate with!")
		return FALSE
	return ..()

/datum/action/brother_comms/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/team/brother_team/team = bond.get_team()
	var/message = tgui_input_text(owner, "Blood Bond", "What do you wish to communicate with your fellow blood brother[length(team.members) > 2 ? "s" : ""]?", timeout = 90 SECONDS)
	if(!message || !IsAvailable(feedback = TRUE))
		return FALSE
	bond.communicate(message)
