// Apply team-specific antag HUD.
/datum/antagonist/brother/apply_innate_effects(mob/living/mob_override)
	. = ..()
	add_team_hud(mob_override || owner.current, /datum/antagonist/brother, REF(team))

/datum/antagonist/brother/create_team(datum/team/brother_team/new_team)
	. = ..()
	if(new_team)
		LAZYADD(hud_keys, REF(new_team))
