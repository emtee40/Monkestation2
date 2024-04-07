/datum/heretic_knowledge/rust_regen/on_gain(mob/living/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/datum/heretic_knowledge/rust_regen/on_lose(mob/living/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)

/*
 * Signal proc for [COMSIG_MOVABLE_MOVED].
 *
 * Applies the rusty healing status effect on rust terfs, and removes it on non-rust turfs.
 */
/datum/heretic_knowledge/rust_regen/proc/on_move(mob/living/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	var/turf/mover_turf = get_turf(source)
	if(!QDELETED(mover_turf) && HAS_TRAIT(mover_turf, TRAIT_RUSTY))
		source.apply_status_effect(/datum/status_effect/rust_heal)
	else
		source.remove_status_effect(/datum/status_effect/rust_heal)
