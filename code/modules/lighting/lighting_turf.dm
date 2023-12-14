

// Used to get a scaled lumcount.
/turf/proc/get_lumcount(minlum = 0, maxlum = 1)
	return CLAMP01(static_lumcount + dynamic_lumcount)

// Returns a boolean whether the turf is on soft lighting.
// Soft lighting being the threshold at which point the overlay considers
// itself as too dark to allow sight and see_in_dark becomes useful.
// So basically if this returns true the tile is unlit black.
/turf/proc/is_softly_lit()
	return !(luminosity || dynamic_lumcount)


///Proc to add movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/add_opacity_source(atom/movable/new_source)
	LAZYADD(opacity_sources, new_source)
	if(opacity)
		return
	var/old_directional_opacity = directional_opacity
	recalculate_directional_opacity()
	if(directional_opacity != old_directional_opacity)
		recalculate_lights()



///Proc to remove movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/remove_opacity_source(atom/movable/old_source)
	LAZYREMOVE(opacity_sources, old_source)
	if(opacity) //Still opaque, no need to worry on updating.
		return
	var/old_directional_opacity = directional_opacity
	recalculate_directional_opacity()

	if(directional_opacity != old_directional_opacity)
		recalculate_lights()



///Calculate on which directions this turfs block view.
/turf/proc/recalculate_directional_opacity()
	. = directional_opacity
	if(opacity)
		directional_opacity = ALL_CARDINALS
		if(. != directional_opacity)
			reconsider_sunlight() //monkestation addition
		return
	directional_opacity = NONE
	if(opacity_sources)
		for(var/atom/movable/opacity_source as anything in opacity_sources)
			if(opacity_source.flags_1 & ON_BORDER_1)
				directional_opacity |= opacity_source.dir
			else //If fulltile and opaque, then the whole tile blocks view, no need to continue checking.
				directional_opacity = ALL_CARDINALS
				break
	if(. != directional_opacity && (. == ALL_CARDINALS || directional_opacity == ALL_CARDINALS))
		reconsider_sunlight() //monkestation addition


///Transfer the lighting of one area to another
/turf/proc/transfer_area_lighting(area/old_area, area/new_area)

	// We will only run this logic on turfs off the prime z layer
	// Since on the prime z layer, we use an overlay on the area instead, to save time
	if(SSmapping.z_level_to_plane_offset[z])
		var/index = SSmapping.z_level_to_plane_offset[z] + 1
		//Inherit overlay of new area
		if(old_area.lighting_effects)
			cut_overlay(old_area.lighting_effects[index])
		if(new_area.lighting_effects)
			add_overlay(new_area.lighting_effects[index])

	// If we're changing into an area with no lighting, and we're lit, light ourselves
	if(!new_area.lighting_effects && old_area.lighting_effects && space_lit)
		overlays += GLOB.fullbright_overlays[GET_TURF_PLANE_OFFSET(src) + 1]

	//This, is also very expensive
	var/turf/turf
	for(var/atom/atom_in_range as anything in range(world.view, src))
		if(isturf(atom_in_range))
			turf = atom_in_range
			turf.check_shadowcasting_update()





/turf/proc/recalculate_lights()
	if(!SSlighting.initialized)
		return FALSE

#ifdef LIGHTING_TESTING
	add_atom_colour(COLOR_RED_LIGHT, ADMIN_COLOUR_PRIORITY)
	animate(src, 10, color = null)
	addtimer(CALLBACK(src, /atom/proc/remove_atom_colour, ADMIN_COLOUR_PRIORITY, COLOR_RED_LIGHT), 10, TIMER_UNIQUE|TIMER_OVERRIDE)
#endif

	//This is very expensive...
	//Todo: Consider reworking this to use the spatial grid system, if that is viable
	var/atom/movable/light/light
	var/turf/turf
	for(var/atom/atom_in_range as anything in range(MAXIMUM_LIGHT_RANGE, src))
		if(isturf(atom_in_range))
			turf = atom_in_range
			turf.check_shadowcasting_update()
		else if(islight(atom_in_range))
			light = atom_in_range
			light.check_update()

	return TRUE
