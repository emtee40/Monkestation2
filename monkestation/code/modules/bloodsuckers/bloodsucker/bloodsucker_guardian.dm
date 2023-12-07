///Bloodsuckers spawning a Guardian will get the Bloodsucker one instead.
/obj/item/guardian_creator/attack_self(mob/living/user)
	if(allowed_to_get_new_guardian(user) && IS_BLOODSUCKER(user))
		poll_for_guardian_player(user, /mob/living/basic/guardian/standard/timestop)
		return

	// Call parent to deal with everyone else
	return ..()

/**
 * The Guardian itself
 */
/mob/living/basic/guardian/standard/timestop
	// Like Bloodsuckers do, you will take more damage to Burn and less to Brute
	damage_coeff = list(BRUTE = 0.5, BURN = 2.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)

	creator_name = "Timestop"
	creator_desc = "Devastating close combat attacks and high damage resistance. Can smash through weak walls and stop time."
	creator_icon = "standard"

/mob/living/basic/guardian/standard/timestop/Initialize(mapload, theme)
	//Wizard Holoparasite theme, just to be more visibly stronger than regular ones
	theme = GLOB.guardian_themes[GUARDIAN_THEME_TECH]
	. = ..()
	var/datum/action/cooldown/spell/timestop/guardian/timestop_ability = new()
	timestop_ability.Grant(src)

///Guardian Timestop ability
/datum/action/cooldown/spell/timestop/guardian
	name = "Guardian Timestop"
	desc = "This spell stops time for everyone (including your master) in a \
		small radius around you, allowing you to move freely while your \
		enemies and even projectiles are frozen."
	cooldown_time = 60 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE

/datum/action/cooldown/spell/timestop/guardian/Grant(mob/grant_to)
	. = ..()
	var/mob/living/basic/guardian/standard/bloodsucker_guardian = owner
	if(bloodsucker_guardian && istype(bloodsucker_guardian) && bloodsucker_guardian.summoner)
		ADD_TRAIT(bloodsucker_guardian.summoner, TRAIT_TIME_STOP_IMMUNE, REF(src))

/datum/action/cooldown/spell/timestop/guardian/Remove(mob/remove_from)
	var/mob/living/basic/guardian/standard/bloodsucker_guardian = owner
	if(bloodsucker_guardian && istype(bloodsucker_guardian) && bloodsucker_guardian.summoner)
		REMOVE_TRAIT(bloodsucker_guardian.summoner, TRAIT_TIME_STOP_IMMUNE, REF(src))
	return ..()
