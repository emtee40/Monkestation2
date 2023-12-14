// This is where the fun begins.
// These are the main datums that emit light.

// These are the main atoms that emit light.

/atom/movable/light
	appearance_flags = KEEP_TOGETHER
	plane = LIGHTING_PLANE
	layer = LIGHTING_LAYER
	invisibility = INVISIBILITY_LIGHTING
	blend_mode = BLEND_ADD
	anchored = TRUE

	/// The overlay we are currently using for the shadows
	var/mutable_appearance/current_shadow_overlay


	/// The atom we're emitting light from (for example a mob if we're from a flashlight that's being held).

	var/atom/top_atom
	///The atom that we belong to.
	var/atom/source_atom

	/// Lumcount we give to turfs on get_lumcount()
	var/lum_power = null
	light_power = null
	light_outer_range = null
	light_inner_range = null
	light_color = null

	// Variables for keeping track of the colour.
	var/lum_r
	var/lum_g
	var/lum_b


	/// Lazy list to track the turfs being affected by our light, thus having lumcount increased
	var/list/turf/affected_turfs


	/// Whether we have applied our light yet or not.
	var/applied = FALSE
	/// whether we are to be added to SSlighting's sources_queue list for an update
	var/needs_update = LIGHTING_NO_UPDATE


/atom/movable/light/Initialize(mapload, atom/owner, atom/top)
	. = ..()
	// Set new owner
	source_atom = owner

	add_to_light_sources(source_atom)
	// Set top atom and slate for update, no need to update turfs until then
	update(top, FALSE)

/atom/movable/light/Destroy(force)
	if(source_atom)
		remove_from_light_sources(source_atom)

	if (top_atom)
		remove_from_light_sources(top_atom)

	if (needs_update)
		SSlighting.sources_queue -= src

	top_atom = null
	source_atom = null

	return ..()


/atom/movable/light/update_light()
	return FALSE

/atom/movable/light/set_light(l_outer_range, l_inner_range, l_power, l_falloff_curve, l_color, l_on)
	return FALSE

/atom/movable/light/set_light_range(new_inner_range, new_outer_range)
	return FALSE

/atom/movable/light/set_light_power(new_power)
	return FALSE

/atom/movable/light/set_light_color(new_color)
	return FALSE

/atom/movable/light/set_light_on(new_value)
	return FALSE

/atom/movable/light/set_light_flags(new_value)
	return FALSE

/atom/movable/light/set_light_range_power_color(range, power, color)
	return FALSE

/atom/movable/light/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	return FALSE


///add this light source to new_atom_host's light_sources list. updating movement registrations as needed
/atom/movable/light/proc/add_to_light_sources(atom/new_atom_host)
	if(QDELETED(new_atom_host))
		return FALSE

	LAZYADD(new_atom_host.light_sources, src)
	//yes, we register the signal to the top atom too, this is intentional and ensures contained lighting updates properly
	if(ismovable(new_atom_host) && new_atom_host == source_atom)
		var/atom/movable/movable_host = new_atom_host
		RegisterSignal(movable_host, COMSIG_MOVABLE_MOVED, PROC_REF(update_host_lights))
		src.animate_movement = movable_host.animate_movement

	return TRUE

///remove this light source from old_atom_host's light_sources list, unsetting movement registrations
/atom/movable/light/proc/remove_from_light_sources(atom/old_atom_host)
	if(QDELETED(old_atom_host))
		return FALSE

	LAZYREMOVE(old_atom_host.light_sources, src)
	if(ismovable(old_atom_host) && old_atom_host == source_atom)
		UnregisterSignal(old_atom_host, COMSIG_MOVABLE_MOVED)
		src.animate_movement = initial(animate_movement)
	return TRUE

///signal handler for when our host atom moves and we need to update our effects
/atom/movable/light/proc/update_host_lights(atom/movable/host)
	SIGNAL_HANDLER

	if(QDELETED(host))
		return

	host.update_light()

// Yes this doesn't align correctly on anything other than 4 width tabs.
// If you want it to go switch everybody to elastic tab stops.
// Actually that'd be great if you could!
#define EFFECT_UPDATE(level)                  \
	if (needs_update == LIGHTING_NO_UPDATE) { \
		SSlighting.sources_queue += src;      \
	}                                         \
	if (needs_update < level) {               \
		needs_update = level;                 \
	}


/// This proc will cause the light source to update the top atom, and add itself to the update queue.
/atom/movable/light/proc/update(atom/new_top_atom, update_turfs = TRUE)

	// This top atom is different.
	if(new_top_atom != top_atom)
		if(top_atom && (top_atom != source_atom && top_atom.light_sources)) // Remove ourselves from the light sources of that top atom.
			remove_from_light_sources(top_atom)

		top_atom = new_top_atom

		if (top_atom != source_atom)
			add_to_light_sources(top_atom)
	// Update plane
	SET_PLANE_EXPLICIT(src, LIGHTING_PLANE, top_atom)
	// Clean old turfs
	if(update_turfs)
		clean_turfs()
	// forceMove to appropriate loc, update pixel_x and pixel_y
	if(top_atom)
		if(ismovable(top_atom))
			if(top_atom.loc)
				loc = top_atom.loc
			else
				moveToNullspace()
		else
			loc = null
	else
		loc = null
	// Get new turfs
	if(update_turfs)
		get_new_turfs()

	// Update if necessary
	EFFECT_UPDATE(LIGHTING_CHECK_UPDATE)

// Will try to update, with proper checks
/atom/movable/light/proc/check_update()
	EFFECT_UPDATE(LIGHTING_CHECK_UPDATE)

// Will force an update without checking if it's actually needed.
/atom/movable/light/proc/force_update()
	EFFECT_UPDATE(LIGHTING_FORCE_UPDATE)


/atom/movable/light/proc/clean_turfs()
	for(var/turf/lit_turf as anything in affected_turfs)
		lit_turf.static_lumcount -= affected_turfs[lit_turf]
	affected_turfs = null

/atom/movable/light/proc/get_new_turfs()
	if(!loc)
		return
	. = list()
	var/affecting_lumpower
	for(var/turf/lit_turf in view(light_outer_range, src))
		affecting_lumpower = round(lum_power * min(1, get_dist(src, lit_turf)/10 + 0.2), 0.1)
		lit_turf.static_lumcount += affecting_lumpower
		.[lit_turf] = affecting_lumpower

	if(length(.))
		affected_turfs = .

#define CHECK_OCCLUSION(turf) (turf.directional_opacity || turf.opacity)


/atom/movable/light/proc/update_visuals()
	if(QDELETED(source_atom))
		qdel(src)
		return
#ifdef LIGHTING_TESTING
	var/turf/top_atom_turf = get_turf(top_atom)
	if(top_atom_turf)
		top_atom_turf.add_atom_colour(COLOR_BLUE_LIGHT, ADMIN_COLOUR_PRIORITY)
		animate(top_atom_turf, 10, color = null)
		addtimer(CALLBACK(top_atom_turf, /atom/proc/remove_atom_colour, ADMIN_COLOUR_PRIORITY, COLOR_BLUE_LIGHT), 10, TIMER_UNIQUE|TIMER_OVERRIDE)
#endif
	cast_light()
	cast_shadow()

/atom/movable/light/proc/cast_light()
	var/update = FALSE
	var/update_turfs = FALSE

	if(light_power != source_atom.light_power)
		light_power = source_atom.light_power
		update = TRUE
		update_turfs = TRUE

	if(light_outer_range != source_atom.light_outer_range)
		light_outer_range = source_atom.light_outer_range
		update = TRUE
		update_turfs = TRUE

	if(!top_atom)
		top_atom = source_atom
		update = TRUE
		update_turfs = TRUE

	if(!light_outer_range || !light_power)
		qdel(src)
		return

	if(light_color != source_atom.light_color)
		light_color = source_atom.light_color
		PARSE_LIGHT_COLOR(src)
		update_turfs = TRUE

	if(!applied)
		update = TRUE

	if(update)
		applied = TRUE

	else if(needs_update == LIGHTING_CHECK_UPDATE)
		return //nothing's changed

	luminosity = 2 * light_outer_range
	var/new_lum_power = light_power * GLOB.light_power_multiplier
	if(new_lum_power != lum_power)
		set_lum_power(new_lum_power)
	var/new_r = round(clamp(lum_r * lum_power * 255, 0, 255))
	var/new_g = round(clamp(lum_g * lum_power * 255, 0, 255))
	var/new_b = round(clamp(lum_b * lum_power * 255, 0, 255))

	color = rgb(new_r, new_g, new_b)
	alpha = GLOB.light_alpha

	// An explicit call to file() is easily 1000 times as expensive than this construct, so... yeah.
	// Setting icon explicitly allows us to use byond rsc instead of fetching the file everytime.
	// The downside is, of course, that you need to cover all the cases in your switch.
	switch(light_outer_range)
		if(1)
			icon = 'icons/effects/lighting/light_range_1.dmi'
		if(2)
			icon = 'icons/effects/lighting/light_range_2.dmi'
		if(3)
			icon = 'icons/effects/lighting/light_range_3.dmi'
		if(4)
			icon = 'icons/effects/lighting/light_range_4.dmi'
		if(5)
			icon = 'icons/effects/lighting/light_range_5.dmi'
		if(6)
			icon = 'icons/effects/lighting/light_range_6.dmi'
		if(7)
			icon = 'icons/effects/lighting/light_range_7.dmi'
		if(8)
			icon = 'icons/effects/lighting/light_range_8.dmi'
		if(9)
			icon = 'icons/effects/lighting/light_range_9.dmi'
		if(10)
			icon = 'icons/effects/lighting/light_range_10.dmi'

		else
			icon = 'icons/effects/lighting/light_range_10.dmi'
			stack_trace("Invalid light_outer_range = [light_outer_range] for /atom/movable/light! source_atom: [source_atom] [REF(source_atom)]")
	icon_state = "light"
	pixel_x = -(world.icon_size * light_outer_range)
	pixel_y = -(world.icon_size * light_outer_range)



/atom/movable/light/proc/set_lum_power(new_lum_power)
	. = lum_power
	lum_power = new_lum_power
	var/affecting_lumpower
	for(var/turf/lit_turf as anything in affected_turfs)
		lit_turf.dynamic_lumcount -= affected_turfs[lit_turf]
		//ok look this is a completely rarted, arbitrary calculation
		affecting_lumpower = round(lum_power * min(1, get_dist(src, lit_turf)/10), 0.1)
		lit_turf.dynamic_lumcount += affecting_lumpower
		affected_turfs[lit_turf] = affecting_lumpower



/atom/movable/light/proc/cast_shadow()
	overlays -= current_shadow_overlay
	//no shadows on insignificant lights
	if(light_outer_range < 2)
		current_shadow_overlay = null
		return
	// Caching this is in fact barely useful due to the blur filter
	if(!GLOB.lighting_appearances["base_shadow"])
		var/mutable_appearance/final_appearance  = mutable_appearance()
		final_appearance.appearance_flags = KEEP_TOGETHER
		final_appearance.layer = SHADOW_LAYER
		final_appearance.animate_movement = NO_STEPS
		final_appearance.filters += filter(type = "blur", size = SHADOW_BLUR_SIZE)
		GLOB.lighting_appearances["base_shadow"] = final_appearance
	current_shadow_overlay = new(GLOB.lighting_appearances["base_shadow"])
	current_shadow_overlay.pixel_x = -pixel_x
	current_shadow_overlay.pixel_y = -pixel_y
	if(!LAZYLEN(affected_turfs))
		overlays += current_shadow_overlay
		return current_shadow_overlay


	var/mutable_appearance/turf_shadow_overlay
	for(var/turf/neighbor as anything in (affected_turfs-get_turf(src)))
		if(!CHECK_LIGHT_OCCLUSION(neighbor))
			continue
		turf_shadow_overlay = prepare_turf_shadow(neighbor)
		if(!turf_shadow_overlay)
			continue
		// Add it as an overlay, to the main appearance
		current_shadow_overlay.overlays += turf_shadow_overlay
		// This is all so fucking gay, but essentially we're getting an offset for the alpha mask filter
		// That gets rid of the portion of the mask being occupied by the turf.
		// We cannot apply the filter to turf_shadow_overlay because the filter gets affected by the
		// pixel_x and pixel_y of that, therefore the calculation gets all fucked up.
		// None of this bullshit can be automated with plane masters. Trust me, I tried.
		var/x_offset = neighbor.x - x
		var/y_offset = neighbor.y - y
		if(!neighbor.render_target)
			neighbor.render_target = "[REF(neighbor)]"
		var/filter_x = pixel_x + (world.icon_size * light_outer_range) + (x_offset * world.icon_size)
		var/filter_y = pixel_y + (world.icon_size * light_outer_range) + (y_offset * world.icon_size)
		current_shadow_overlay.filters += filter(type = "alpha", render_source = neighbor.render_target, x = filter_x, y = filter_y, flags = MASK_INVERSE)
	overlays += current_shadow_overlay
	return current_shadow_overlay

/atom/movable/light/proc/prepare_turf_shadow(turf/occluder)
	var/x_offset = occluder.x - x
	var/y_offset = occluder.y - y

	var/shadow_appearance_key = "turf_shadow_[x_offset]_[y_offset]_[light_outer_range]"
	// We've not done this before!
	if(!GLOB.lighting_appearances[shadow_appearance_key])
		var/mutable_appearance/shadow_appearance = mutable_appearance()
		shadow_appearance.overlays += get_shadows(x_offset, y_offset, light_outer_range)

		GLOB.lighting_appearances[shadow_appearance_key] = shadow_appearance
	return GLOB.lighting_appearances[shadow_appearance_key]

#undef CHECK_OCCLUSION


// Read out of our sources light sheet, a map of offsets -> the luminosity to use
//#define LUM_FALLOFF(C, T) (1 - CLAMP01(sqrt((C.x - T.x) ** 2 + (C.y - T.y) ** 2 + LIGHTING_HEIGHT) / max(1, light_outer_range)))

// This is the define used to calculate falloff.
// Assuming a brightness of 1 at range 1, formula should be (brightness = 1 / distance^2)
// However, due to the weird range factor, brightness = (-(distance - full_dark_start) / (full_dark_start - full_light_end)) ^ light_max_bright
#define LUM_FALLOFF(C, T)(CLAMP01(-((((C.x - T.x) ** 2 +(C.y - T.y) ** 2) ** 0.5 - light_outer_range) / max(light_outer_range - light_inner_range, 1))) ** light_falloff_curve)

// Macro that applies light to a new corner.
// It is a macro in the interest of speed, yet not having to copy paste it.
// If you're wondering what's with the backslashes, the backslashes cause BYOND to not automatically end the line.
// As such this all gets counted as a single line.
// The braces and semicolons are there to be able to do this on a single line.
#define APPLY_CORNER(C)                          \
	. = LUM_FALLOFF(C, pixel_turf);              \
	. *= (light_power ** 2);                \
	. *= light_power < 0 ? -1:1;            \
	var/OLD = effect_str[C];                     \
	                                             \
	C.update_lumcount                            \
	(                                            \
		(. * lum_r) - (OLD * applied_lum_r),     \
		(. * lum_g) - (OLD * applied_lum_g),     \
		(. * lum_b) - (OLD * applied_lum_b)      \
	);                                           \

#define REMOVE_CORNER(C)                         \
	. = -effect_str[C];                          \
	C.update_lumcount                            \
	(                                            \
		. * applied_lum_r,                       \
		. * applied_lum_g,                       \
		. * applied_lum_b                        \
	);





#undef APPLY_CORNER
#undef EFFECT_UPDATE
#undef LUM_FALLOFF
