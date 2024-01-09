
/// Sets whether a wire is now cut.
///
/// This avoids
///
/// Parameters:
/// * `wire`: The wire we want to cut, by its constant. (WIRE_TX, WIRE_AI, etc.)
/// * `mended`: If this wire is currently mended together. TRUE means it's mended, and FALSE means
///   it's cut.
/datum/wires/proc/set_wire_state(wire, mended)
	if(mended)
		cut_wires -= wire
	else
		cut_wires |= wire

	on_cut(wire, mend = mended)

// Moved from the original `cut` proc, located at `code/datums/wires/_wires.dm`, this is a refactor
// of the original. The logic to modify the `cut_wires` list and call `on_cut` has been moved to the
// above `set_wire_state` proc, and wirehack logging has been added to this proc.
/datum/wires/proc/cut(wire)
	var/is_currently_cut = is_cut(wire)
	log_wirehack(usr, is_currently_cut ? "mended" : "cut", holder, wire)
	set_wire_state(wire, !is_currently_cut)
