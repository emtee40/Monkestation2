/mob
	///Should the mob use the shadowcasting component when a client is logged to it?
	var/shadow_caster = FALSE

/mob/proc/update_shadowcasting()
	if(!shadow_caster || !client)
		return
	var/pref_alpha = client.prefs.read_preference(/datum/preference/numeric/shadowcasting_darkness)
	for(var/atom/movable/screen/plane_master/plane_master as anything in hud_used.get_true_plane_masters(SHADOWCASTING_PLANE))
		plane_master.alpha = pref_alpha
	var/pref_blur = client.prefs.read_preference(/datum/preference/numeric/shadowcasting_blurriness)
	for(var/atom/movable/screen/plane_master/plane_master as anything in hud_used.get_true_plane_masters(SHADOWCASTING_PLANE))
		plane_master.add_filter("blur", 2, gauss_blur_filter(size = pref_blur))

	var/datum/component/shadowcasting = GetComponent(/datum/component/shadowcasting)
	if(!pref_alpha)
		if(shadowcasting)
			qdel(shadowcasting)
	else if(!shadowcasting)
		AddComponent(/datum/component/shadowcasting)

/client/proc/cmd_admin_change_light_multiplier()
	set name = "Change Light Multiplier"
	set category = "Debug"

	if(!check_rights(R_ADMIN) || !check_rights(R_DEBUG))
		return

	var/new_power = input(usr, "New light power multiplier", "", GLOB.light_power_multiplier) as num|null
	if(isnull(new_power) || (new_power == GLOB.light_power_multiplier))
		return
	new_power = clamp(new_power, 0, 255)
	var/old_power = GLOB.light_power_multiplier
	GLOB.light_power_multiplier = new_power

	message_admins("[key_name_admin(usr)] has changed the light power multiplier from [old_power] to [new_power]")
	log_admin("[key_name(usr)] has changed the light power multiplier from [old_power] to [new_power].")

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Changed Light Multiplier", "[new_power]"))

	for(var/atom/movable/light/light_atom in world)
		light_atom.force_update()

/client/proc/cmd_admin_change_light_alpha()
	set name = "Change Light Alpha"
	set category = "Debug"

	if(!check_rights(R_ADMIN) || !check_rights(R_DEBUG))
		return

	var/new_alpha = input(usr, "New light alpha", "", GLOB.light_alpha) as num|null
	new_alpha = clamp(round(new_alpha), 0, 255)
	if(isnull(new_alpha) || (new_alpha == GLOB.light_alpha))
		return
	var/old_alpha = GLOB.light_alpha
	GLOB.light_alpha = new_alpha

	message_admins("[key_name_admin(usr)] has changed the light alpha from [old_alpha] to [new_alpha]")
	log_admin("[key_name(usr)] has changed the light alpha from [old_alpha] to [new_alpha].")

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Changed Light Alpha", "[new_alpha]"))

	for(var/atom/movable/light/light_atom in world)
		light_atom.force_update()
