//a simple element that listens for passed signals and then returns based on if get_turf's type is within valid_turfs, if you need more then use the /complex subtype
/datum/element/turf_checker
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2
	///list of turf types that are valid for us
	var/list/valid_turfs
	///the signal we listen for
	var/registered_signal

/**
 * valid_turfs - the list of turf types that are valid for when we check
 * registered_signal - the signal from target we listen for to call on_signal_recieved()
 * check_on_move - should we check turf every time our target calls Moved()
 * update_state_proc - proc for target to call when we send COMSIG_TURF_CHECKER_UPDATE_STATE
 * register_loc - should we listen to Moved() on locs of our target as well
 */
/datum/element/turf_checker/Attach(atom/movable/target, list/valid_turfs = list(), registered_signal)
	. = ..()
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE

	message_admins("0 [english_list(args)]")
	src.valid_turfs = valid_turfs
	src.registered_signal = registered_signal
	if(registered_signal)
		RegisterSignal(target, registered_signal, PROC_REF(on_signal_recieved))

/datum/element/turf_checker/Detach(atom/movable/source)
	. = ..()
	if(registered_signal)
		UnregisterSignal(source, registered_signal)

/datum/element/turf_checker/proc/on_signal_recieved(atom/movable/checked_atom, atom/movable/check_override, do_check_turf = TRUE, register_to, unregister_from)
	SIGNAL_HANDLER
	message_admins("1 [english_list(args)]")
	if(do_check_turf)
		message_admins("2")
		check_turf(checked_atom, check_override)

	if(register_to) //keeping these here in case your use case can handle this on the attached atom in a cheaper way than the /complex subtype
		RegisterSignal(register_to, COMSIG_MOVABLE_MOVED, PROC_REF(check_turf_source_only))

	if(unregister_from)
		UnregisterSignal(unregister_from, COMSIG_MOVABLE_MOVED)

//so we dont override checked_atom with old_loc
/datum/element/turf_checker/proc/check_turf_source_only(atom/movable/checked_atom)
	SIGNAL_HANDLER
	message_admins("3")
	check_turf(checked_atom)

/datum/element/turf_checker/proc/check_turf(atom/movable/checked_atom, atom/movable/check_override)
	SIGNAL_HANDLER
	message_admins("4 [checked_atom]")
	. = COMPONENT_CHECKER_VALID_TURF
	if(check_override)
		message_admins("5 [check_override]")
		checked_atom = check_override

	var/turf/checked_turf_type = get_turf(checked_atom)
	if(!checked_turf_type)
		message_admins("NONE [checked_atom]")
	checked_turf_type = checked_turf_type.type
	message_admins("TYPE [checked_turf_type]")
	if(!(checked_turf_type in valid_turfs))
		message_admins("6")
		. = COMPONENT_CHECKER_INVALID_TURF
	return .

///a more expensive version of the element that allows for things like tracking the loc of our object, behaves more like a component than an element but its less duplicate code
/datum/element/turf_checker/complex
	argument_hash_start_idx = 1 //we act like a component and have one instance per object, yeah its not great but this way we can still have the cheap parent
	///the atom we are attached to, pretty much our parent
	var/atom/movable/attached_to
	///do we listen for COMSIG_MOVABLE_MOVED
	var/check_on_move
	///our last validity state, used to save on checks
	var/last_validity_state = FALSE
	///a ref to the loc that we listen to the movement of to send our signals
	var/atom/watched_holder
	///our attached_to's recursive locs minus it and watched_holder
	var/list/trimmed_recursive_locs = list()

/datum/element/turf_checker/complex/Attach(atom/movable/target, list/valid_turfs, registered_signal, check_on_move = FALSE, update_state_proc, register_loc = TRUE)
	. = ..()
	message_admins("7 [english_list(args)]")
	attached_to = target
	src.check_on_move = check_on_move
	if(check_on_move)
		message_admins("8")
		last_validity_state = FALSE
		if(register_loc)
			RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(on_attached_moved))
		else
			RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(check_turf_source_only))

		if(update_state_proc)
			target.RegisterSignal(src, COMSIG_TURF_CHECKER_UPDATE_STATE, update_state_proc)

		get_new_locs(target)
		check_turf(target)

/datum/element/turf_checker/complex/Detach(atom/movable/source)
	. = ..()
	message_admins("DET")
	if(check_on_move)
		source.UnregisterSignal(src, COMSIG_TURF_CHECKER_UPDATE_STATE)
		UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

	if(watched_holder != attached_to)
		UnregisterSignal(watched_holder, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_ATOM_ABSTRACT_EXITED))

	for(var/atom/recursive_loc in trimmed_recursive_locs)
		UnregisterSignal(recursive_loc, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))

	attached_to = null
	watched_holder = null
	trimmed_recursive_locs = null
	qdel(src, TRUE) //normally elements are blocked from qdelling, again this is more like a component

/datum/element/turf_checker/complex/check_turf(atom/movable/checked_atom, atom/movable/check_override)
	. = ..()
	if(. == COMPONENT_CHECKER_INVALID_TURF)
		message_admins("9")
		if(last_validity_state)
			last_validity_state = FALSE
			SEND_SIGNAL(src, COMSIG_TURF_CHECKER_UPDATE_STATE, checked_atom, FALSE)
		return

	if(check_on_move && !last_validity_state)
		message_admins("10")
		last_validity_state = TRUE
		SEND_SIGNAL(src, COMSIG_TURF_CHECKER_UPDATE_STATE, checked_atom, TRUE)

/datum/element/turf_checker/complex/proc/get_new_locs()
	if(QDELETED(attached_to))
		message_admins("11")
		return

	message_admins("12")
	var/list/attached_locs = attached_to.get_locs_recursive()
	var/atom/highest_holder = attached_locs[length(attached_locs)]
	if(highest_holder == attached_to && watched_holder == attached_to)
		message_admins("13")
		return

	var/list/old_recursive_locs = trimmed_recursive_locs
	trimmed_recursive_locs = list()
	if(watched_holder != highest_holder && watched_holder != attached_to)
		UnregisterSignal(watched_holder, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_ABSTRACT_EXITED, COMSIG_QDELETING))

	if(highest_holder != attached_to)
		watched_holder = WEAKREF(highest_holder)
		RegisterSignal(highest_holder, COMSIG_MOVABLE_MOVED, PROC_REF(check_turf_source_only))
		RegisterSignal(highest_holder, COMSIG_ATOM_ABSTRACT_EXITED, PROC_REF(on_holder_exited))
		RegisterSignal(highest_holder, COMSIG_QDELETING, PROC_REF(on_loc_qdeleted))
		if(length(attached_locs) > 2)
			trimmed_recursive_locs = attached_locs - list(attached_locs[1], highest_holder)
			for(var/atom/recursive_loc in trimmed_recursive_locs)
				if(!QDELETED(recursive_loc))
					if(recursive_loc in old_recursive_locs)
						old_recursive_locs -= recursive_loc
					else
						RegisterSignal(recursive_loc, COMSIG_MOVABLE_MOVED, PROC_REF(check_holder))
						RegisterSignal(recursive_loc, COMSIG_QDELETING, PROC_REF(on_loc_qdeleted))
	else
		watched_holder = attached_to

	for(var/atom/old_recursive_loc in old_recursive_locs)
		UnregisterSignal(old_recursive_loc, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))

/datum/element/turf_checker/complex/proc/check_holder(atom/movable/moved)
	SIGNAL_HANDLER
	if(attached_to.get_highest_non_turf_loc() != watched_holder)
		get_new_locs()

/datum/element/turf_checker/complex/proc/on_attached_moved(atom/movable/moved, atom/old_loc)
	SIGNAL_HANDLER
	if(watched_holder == attached_to)
		check_turf(moved)
		return

	get_new_locs()
	check_turf(moved)

/datum/element/turf_checker/complex/proc/on_holder_exited(atom/exited, atom/movable/gone)
	SIGNAL_HANDLER
	if(gone == attached_to || attached_to.get_highest_non_turf_loc() != watched_holder)
		get_new_locs()
		check_turf(attached_to)

/datum/element/turf_checker/complex/proc/on_loc_qdeleted(atom/destroyed, forced)
	SIGNAL_HANDLER
	UnregisterSignal(destroyed, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))
	if(destroyed == watched_holder)
		UnregisterSignal(destroyed, COMSIG_ATOM_ABSTRACT_EXITED)
		watched_holder = null
	else
		trimmed_recursive_locs -= destroyed
	get_new_locs()
