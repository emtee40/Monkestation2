/atom/var/mutable_appearance/reflection
/turf/var/reflective_marked = FALSE

#define SHINE_MATTE 0
#define SHINE_REFLECTIVE 1
#define SHINE_SHINY 2

/datum/component/reflective_turf
	var/turf/owner_turf
	var/turf/above_parent
	///the duration of the reflection [ 0 = no duration]
	var/duration = 0
	///cached list of all things added to the reflective surface
	var/list/cached_reflectors = list()
	///our reflective_index used to select the correct overlay
	var/reflective_index = SHINE_REFLECTIVE
	// filter icons
	///flip icon
	var/icon/flipped = icon('monkestation/code/modules/shadowcasting/icons/overlays.dmi', "flip")
	var/icon/reflective_icon

/datum/component/reflective_turf/Initialize(duration = 0, reflective_index = SHINE_MATTE)
	. = ..()
	src.duration = duration
	src.reflective_index = reflective_index

	owner_turf = get_turf(parent)
	above_parent = get_step(owner_turf, NORTH)
	above_parent.reflective_marked = TRUE
	RegisterSignal(above_parent, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))
	RegisterSignal(above_parent, COMSIG_ATOM_EXITED, PROC_REF(on_exited))
	RegisterSignal(above_parent, COMSIG_PARENT_QDELETING, PROC_REF(above_deleted))
	RegisterSignal(owner_turf, COMSIG_PARENT_QDELETING, PROC_REF(clear_reflections))

	var/reflective_state
	switch(reflective_index)
		if(SHINE_REFLECTIVE)
			reflective_state = "partialOverlay"
		if(SHINE_SHINY)
			reflective_state = "whiteOverlay"
		if(SHINE_MATTE)
			reflective_state = "whiteOverlay"
	reflective_icon = icon('monkestation/code/modules/shadowcasting/icons/overlays.dmi', reflective_state)

/datum/component/reflective_turf/Destroy(force, silent)
	. = ..()
	UnregisterSignal(above_parent, list(
		COMSIG_ATOM_ENTERED,
		COMSIG_PARENT_QDELETING,
		COMSIG_ATOM_EXITED,
	))
	UnregisterSignal(owner_turf, COMSIG_PARENT_QDELETING)
	cached_reflectors = null

/datum/component/reflective_turf/proc/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(arrived.reflection)
		return
	arrived.reflection = new()
	arrived.reflection.appearance = arrived.appearance
	arrived.reflection.pixel_y = -32

	//filters are here
	arrived.reflection.add_filter("flip", 1.1, displacement_map_filter(flipped, x = 0, y = 0, size = 42))
	arrived.reflection.add_filter("reflection", 1.1, displacement_map_filter(reflective_icon, x = 0, y = 0, size = 42))
	
	cached_reflectors |= arrived

/datum/component/reflective_turf/proc/on_exited(obj/item/source, atom/movable/gone, direction)
	SIGNAL_HANDLER

	var/turf/entering = get_step(above_parent, direction)
	if(entering.reflective_marked)
		return

	// this should probably be put into a lazy deletion system where 
	// if you dont enter a reflective area in x time it deletes but 
	// stays at 0 alpha until than
	qdel(gone.reflection)
	cached_reflectors -= (gone)
	gone.reflection = null

/datum/component/reflective_turf/proc/above_deleted()
	SIGNAL_HANDLER
	
	above_parent = get_step(owner_turf, NORTH)
	above_parent.reflective_marked = TRUE

/datum/component/reflective_turf/proc/clear_reflections()
	SIGNAL_HANDLER

	above_parent.reflective_marked = FALSE
	for(var/atom/atom as anything in cached_reflectors)
		if(!atom.reflection)
			continue
		qdel(atom.reflection)

	qdel(src)

/turf/open/proc/make_shiny(duration = 0, shine = SHINE_SHINY)
	if(GetComponent(/datum/component/reflective_turf))
		return

	AddComponent(/datum/component/reflective_turf, duration, shine)



#undef SHINE_MATTE
#undef SHINE_REFLECTIVE
#undef SHINE_SHINY
