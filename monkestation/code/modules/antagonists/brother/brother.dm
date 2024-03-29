// Apply team-specific antag HUD.
/datum/antagonist/brother/apply_innate_effects(mob/living/mob_override)
	. = ..()
	add_team_hud(mob_override || owner.current, /datum/antagonist/brother, REF(team))

/datum/antagonist/brother/create_team(datum/team/brother_team/new_team)
	. = ..()
	if(new_team)
		LAZYADD(hud_keys, REF(new_team))

/datum/antagonist/brother/antag_token(datum/mind/hosts_mind, mob/spender)
	if(isobserver(spender))
		var/mob/living/carbon/human/new_mob = spender.change_mob_type(/mob/living/carbon/human, delete_old_mob = TRUE)
		new_mob.equipOutfit(/datum/outfit/job/assistant)
		hosts_mind = new_mob.mind
	var/datum/team/brother_team/team = new
	team.add_member(hosts_mind)
	team.forge_brother_objectives()
	hosts_mind.add_antag_datum(/datum/antagonist/brother, team)
