/**
 * Allows you to hide under tables or bodies
 * Without this, borers are really weak due to NEEDING players being blind or consenting
 */
/datum/action/cooldown/borer/toggle_hiding
	name = "Toggle Hiding"
	button_icon_state = "hide"

/datum/action/cooldown/borer/toggle_hiding/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(owner.layer == PROJECTILE_HIT_THRESHHOLD_LAYER)
		cortical_owner.upgrade_flags &= ~BORER_HIDING
		owner.balloon_alert(owner, "stopped hiding")
		owner.layer = BELOW_MOB_LAYER
		StartCooldown()
		return
	cortical_owner.upgrade_flags |= BORER_HIDING
	owner.balloon_alert(owner, "started hiding")
	owner.layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	StartCooldown()
