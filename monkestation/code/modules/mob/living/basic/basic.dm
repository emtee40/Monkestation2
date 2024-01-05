/mob/living/basic/update_sight()
	if(!client)
		return
	var/new_sight = initial(sight)
	lighting_cutoff = initial(lighting_cutoff)
	lighting_color_cutoffs = list(lighting_cutoff_red, lighting_cutoff_green, lighting_cutoff_blue)

	if(client.eye != src)
		var/atom/client_eye = client.eye
		if(client_eye.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return

	if(HAS_TRAIT(src, TRAIT_TRUE_NIGHT_VISION))
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_HIGH)

	if(HAS_TRAIT(src, TRAIT_MESON_VISION))
		new_sight |= SEE_TURFS
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_MEDIUM)

	if(HAS_TRAIT(src, TRAIT_THERMAL_VISION))
		new_sight |= SEE_MOBS
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_MEDIUM)

	if(HAS_TRAIT(src, TRAIT_XRAY_VISION))
		new_sight |= SEE_TURFS|SEE_MOBS|SEE_OBJS

	if(SSmapping.level_trait(z, ZTRAIT_NOXRAY))
		new_sight = NONE

	set_sight(new_sight)
	return ..()
