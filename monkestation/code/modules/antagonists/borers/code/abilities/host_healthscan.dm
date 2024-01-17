/datum/action/cooldown/borer/check_blood
	name = "Check Blood"
	cooldown_time = 5 SECONDS
	button_icon_state = "blood"

/datum/action/cooldown/borer/check_blood/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.human_host)
		owner.balloon_alert(owner, "host required")
		return
	healthscan(owner, cortical_owner.human_host, advanced = TRUE) // :thinking:
	chemscan(owner, cortical_owner.human_host)
	StartCooldown()
