/mob
	///Should the mob use the shadowcasting component when a client is logged to it?
	var/shadow_caster = FALSE

//TODO: add prefs
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
