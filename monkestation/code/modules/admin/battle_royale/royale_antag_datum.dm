/datum/antagonist/battle_royale
	name = "Battle Royale Participant"
	show_in_roundend = FALSE
	antag_moodlet = /datum/mood_event/battle_royale
	show_in_antagpanel = FALSE //you should never need to manually add this, might at some point add a proc to manually inject someone into a royale
	///Have we died?
	var/died = FALSE

/datum/antagonist/battle_royale/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/battle_royale/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	RegisterSignal(current, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_change))
	RegisterSignal(current, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/antagonist/battle_royale/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	UnregisterSignal(current, COMSIG_MOVABLE_Z_CHANGED)
	UnregisterSignal(current, COMSIG_LIVING_DEATH)

/datum/antagonist/battle_royale/forge_objectives()
	var/datum/objective/battle_royale/objective = new
	objectives += objective

/datum/antagonist/battle_royale/proc/on_z_change(datum/source, turf/old_turf, turf/new_turf)
	if(!isliving(source) || SSmapping.level_trait(new_turf.z, ZTRAIT_STATION))
		return

	var/mob/living/living_moved = source
	to_chat(living_moved, span_userdanger("You left the station Z level(s)!"))
	living_moved.dust(drop_items = TRUE)

/datum/antagonist/battle_royale/proc/on_death(datum/source, gibbed)
	died = TRUE
	GLOB.battle_royale_controller?.check_ending()
	if(!isliving(source) || gibbed)
		return

	var/mob/living/living_died = source
	to_chat(living_died, span_userdanger("You died!"))
	living_died.dust(drop_items = TRUE)

/datum/objective/battle_royale //has no completion requirement as it cannot be completed
	name = "Get that victory royale"
	explanation_text = "Be the last one standing in the battle for victory!"
	admin_grantable = FALSE

/datum/mood_event/battle_royale
	mood_change = 4 //same as being a traitor
