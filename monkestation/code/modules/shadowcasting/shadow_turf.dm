/turf/proc/check_shadowcasting_update()
	if(!shadowcasting_appearance)
		return
	SSshadowcasting.turf_queue += src

/turf/proc/update_shadowcasting()
	update_shadowcasting_appearance()
	SEND_SIGNAL(src, COMSIG_TURF_UPDATE_SHADOWCASTING)

/turf/proc/update_shadowcasting_appearance()
	if(!shadowcasting_appearance)
		shadowcasting_appearance = new()
	shadowcasting_appearance.overlays = null
	shadowcasting_appearance.filters = null
	create_shadowcasting_overlays()

/turf/proc/create_shadowcasting_overlays()
	var/mutable_appearance/turf_shadowcast_overlay
	for(var/turf/neighbor in (view(world.view, src)-src))
		if(!CHECK_LIGHT_OCCLUSION(neighbor))
			continue

		turf_shadowcast_overlay = prepare_turf_shadowcast(neighbor)
		if(!turf_shadowcast_overlay)
			continue


		// Add it as an overlay, to the main appearance
		shadowcasting_appearance.overlays += turf_shadowcast_overlay
		// This is all so fucking gay, but essentially we're getting an offset for the alpha mask filter
		// That gets rid of the portion of the shadow being occupied by the turf.
		// We cannot apply the filter to turf_shadowcast_overlay because that is a cached appearance.
		// None of this bullshit can be automated with plane masters. Trust me, I tried.
		var/x_offset = neighbor.x - x
		var/y_offset = neighbor.y - y
		if(!neighbor.render_target)
			neighbor.render_target = "[REF(neighbor)]"
		var/filter_x = (x_offset * world.icon_size)
		var/filter_y = (y_offset * world.icon_size)
		shadowcasting_appearance.filters += filter(type = "alpha", render_source = neighbor.render_target, x = filter_x, y = filter_y, flags = MASK_INVERSE)

/turf/proc/prepare_turf_shadowcast(turf/occluder)
	var/x_offset = occluder.x - x
	var/y_offset = occluder.y - y

	var/shadow_appearance_key = "turf_shadow_[x_offset]_[y_offset]_[SHADOWCASTING_RANGE]"
	// We've not done this before!
	if(!GLOB.lighting_appearances[shadow_appearance_key])
		var/mutable_appearance/shadow_appearance = mutable_appearance()
		shadow_appearance.overlays += get_shadows(x_offset, y_offset, SHADOWCASTING_RANGE)
		GLOB.lighting_appearances[shadow_appearance_key] = shadow_appearance
	return GLOB.lighting_appearances[shadow_appearance_key]
