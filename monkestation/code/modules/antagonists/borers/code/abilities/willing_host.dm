/datum/action/cooldown/borer/willing_host
	name = "Willing Host"
	cooldown_time = 2 MINUTES
	button_icon_state = "willing"
	chemical_cost = 150

/datum/action/cooldown/borer/willing_host/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	for(var/ckey_check in GLOB.willing_hosts)
		if(ckey_check == cortical_owner.human_host.ckey)
			owner.balloon_alert(owner, "host already willing")
			return
	owner.balloon_alert(owner, "asking host...")
	cortical_owner.chemical_storage -= chemical_cost
	var/host_choice = tgui_input_list(cortical_owner.human_host,"Do you accept to be a willing host?", "Willing Host Request", list("Yes", "No"))
	if(host_choice != "Yes")
		owner.balloon_alert(owner, "host not willing!")
		StartCooldown()
		return
	owner.balloon_alert(owner, "host willing!")
	to_chat(cortical_owner.human_host, span_notice("You have accepted being a willing host!"))
	GLOB.willing_hosts += cortical_owner.human_host.ckey
	StartCooldown()
