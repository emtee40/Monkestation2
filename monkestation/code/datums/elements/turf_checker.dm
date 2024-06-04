/datum/element/turf_checker
	///list of turf types that are valid for us
	var/list/valid_turfs
	///the signal we listen for
	var/registered_signal
	///do we have a constant effect, more expensive if enabled
	var/constant = FALSE //might be possible to just check for registered_signal being set
	///what was our last turf type, used to save on checks
	var/turf/last_turf_type
	///what was our last constant state
	var/last_state = FALSE

/datum/element/turf_checker/Attach(atom/movable/target, list/valid_turfs = list(), registered_signal, constant = FALSE)
	. = ..()
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE

	src.valid_turfs = valid_turfs
	src.registered_signal = registered_signal
	src.constant = constant
	if(constant)
		RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(check_turf_constant))

	if(registered_signal)
		RegisterSignal(target, registered_signal, PROC_REF(check_turf))

/datum/element/turf_checker/Detach(datum/source, ...)
	. = ..()
	if(constant)
		UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

	if(registered_signal)
		UnregisterSignal(source, registered_signal)

//so we dont override checked_atom with old_loc
/datum/element/turf_checker/proc/check_turf_constant(atom/movable/checked_atom)
	SIGNAL_HANDLER
	check_turf(checked_atom)

/datum/element/turf_checker/proc/check_turf(atom/movable/checked_atom, atom/movable/check_override)
	SIGNAL_HANDLER
	if(check_override)
		checked_atom = check_override

	var/turf/checked_turf_type = get_turf(checked_atom)
	checked_turf_type = checked_turf_type.type
	if(checked_turf_type == last_turf_type)
		return

	last_turf_type = checked_turf_type
	if(!(checked_turf_type in valid_turfs))
		if(!constant)
			return COMPONENT_CHECKER_INVALID_TURF
		if(last_state)
			last_state = FALSE
			SEND_SIGNAL(src, COMSIG_TURF_CHECKER_UPDATE_STATE, last_state)
	else if(constant && !last_state)
		last_state = TRUE
		SEND_SIGNAL(src, COMSIG_TURF_CHECKER_UPDATE_STATE, last_state)
