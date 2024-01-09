//! Procs for logging wirehack actions, including pulses, cuts and mends, as well as assemblies
//! being attached and detached.

/// Logs a single wirehack event.
///
/// Because messing with wires can have side effects, make sure to call this at an appropriate time,
/// such that the resulting logs make sense when put in order. For example, if you're logging that
/// an assembly is attempting to pulse a wire, make sure that log comes before the logs about the
/// wire being pulsed.
///
/// Parameters:
/// * `user`: Required; The user that caused this event
/// * `action`: Required; Text detailing the action that took place ("mended", "pulsed", etc.)
/// * `target`: Required; The target of the action
/// * `wire`: Required; The relevant wire, by its function (WIRE_TX, WIRE_AI, etc. - this should be
///   something that translates to a string)
/// * `action_additional`: Optional; a string that comes after the wire is named
/// * `message_admins`: Optional; Whether this event should be sent to admins' chat window
///   immediately. Wirehack events are usually not important, so this is FALSE by default to avoid
///   spamming admins.
/proc/log_wirehack(atom/user, action, atom/target, wire, additional = "", message_admins = FALSE)
	// NOTE: Though `user` is required, we cannot count on it being non-null, as in some cases (such
	// as with prefabs which perform wire actions, or with assemblies) user may be null. In
	// particular, the following cases are known where `user` can be `null`:
	//
	// * Timers pulsing a wire
	//
	// However, we can make an effort to patch these holes, and where we haven't, still provide as
	// much data as we can. Hence, I'll put a stack trace here to track down any such instances.
	if(!user || !action || !target || !wire)
		stack_trace("A wirehack event failed to specify a required parameter. This should not prevent logging, but is considered an error regardless.")

	var/event_text = "[action] the [wire] wire of [target ? "[target.name] at [AREACOORD(target)]" : "an unknown target (please report this)"][(additional != "") ? " [additional]" : ""]"

	// TODO: It would be nice to take the data provided to this function, pass it to a proc on
	// `target`, and get back some data on what happened. For example, if they pulsed the "Open"
	// wire on an airlock, we could use such a proc to get details on what the pulse did - such as
	// "Opening it", "Closing it", "Doing nothing due to bolts", and so on.

	if(user)
		// TODO: Replace with LOG_WIREHACK
		user.log_message(event_text, LOG_GAME)
	else
		// TODO: Replace with LOG_WIREHACK
		log_game(event_text)

	add_event_to_buffer(
		source = user,
		target = target,
		data = event_text,
		log_key = "WIREHACK",
	)

	// Allow notifying the admins, for example if we consider this wire to be a particularly
	// important wire to be notified of.
	if(message_admins)
		message_admins("[user ? "[ADMIN_LOOKUPFLW(user)] at [ADMIN_VERBOSEJMP(user)]" : "An unspecified user (please report this)"] [action ? action : "performed an unspecified action (please report this) on"] the [wire ? wire : "Unspecified (please report this)"] wire of [target ? "[target.name] at [ADMIN_VERBOSEJMP(target)]" : "an unspecified target (please report this)"][(additional != "") ? " [additional]" : ""]")

/// Logs a single wirehack event related to assemblies.
///
/// The parameters are the same as with `/proc/log_wirehack()`, with a couple additions:
/// * `assembly`: Required; The assembly which is related to this event, such as a Remote Signaling
///   Device or Timer.
/proc/log_wirehack_with_assembly(atom/user, action, atom/assembly, atom/target, wire, message_admins = FALSE)
	if(!assembly)
		stack_trace("An assembly-related wirehack event failed to specify the assembly related to the event. This should not prevent logging, but is considered an error regardless.")

	// TODO: Make sure we log what the assembly is made of, and its settings (such as the timer on a
	// Timer)
	log_wirehack(user, action, target, wire, "using an assembly ([assembly ? assembly : "An unspecified assembly (please report this)"])", message_admins)
