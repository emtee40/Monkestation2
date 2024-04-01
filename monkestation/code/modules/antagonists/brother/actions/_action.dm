/datum/action/bb
	background_icon = 'monkestation/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_syndie"
	button_icon = 'monkestation/icons/mob/actions/actions_bb.dmi'
	check_flags = AB_CHECK_CONSCIOUS
	var/datum/antagonist/brother/bond

/datum/action/bb/New(datum/antagonist/brother/target)
	if(!istype(target))
		CRASH("Attempted to create [type] without an associated antag datum!")
	src.bond = target
	return ..()

/datum/action/bb/IsAvailable(feedback)
	if(QDELETED(bond) || bond.owner != owner.mind)
		return FALSE
	var/datum/team/brother_team/team = bond.get_team()
	if(QDELETED(team) || !(owner.mind in team.members))
		return FALSE
	return ..()
