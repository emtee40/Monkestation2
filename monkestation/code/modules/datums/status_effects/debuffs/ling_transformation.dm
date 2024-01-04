/datum/status_effect/ling_transformation
	id = "ling_transformation"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	remove_on_fullheal = TRUE
	/// The DNA that the status effect transforms the target into.
	var/datum/dna/target_dna
	/// The target's original DNA, which will be restored upon 'curing' them.
	var/datum/dna/original_dna
	/// How much "charge" the transformation has left. It's randomly set upon creation,
	/// and ticks down every second if there's clonexadone in the target's system.
	var/charge_left
	/// Whether the transformation has already been applied or not (i.e is this a new transformation, or an old one being transferred?)
	var/already_applied = FALSE

/datum/status_effect/ling_transformation/on_creation(mob/living/new_owner, datum/dna/target_dna, datum/dna/original_dna, already_applied = FALSE)
	if(!iscarbon(new_owner) || QDELETED(target_dna))
		qdel(src)
		return
	RegisterSignal(new_owner, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_healthscan))
	src.target_dna = new target_dna.type
	target_dna.copy_dna(src.target_dna)
	charge_left = rand(10, 20)
	if(original_dna)
		src.original_dna = new original_dna.type
		original_dna.copy_dna(src.original_dna)
	src.already_applied = already_applied
	return ..()

/datum/status_effect/ling_transformation/on_apply()
	. = ..()
	if(!target_dna)
		qdel(src)
		return
	var/mob/living/carbon/carbon_owner = owner
	if(original_dna?.is_same_as(target_dna)) // Cleanly handle someone being transform stung back into their original identity
		qdel(src)
		return
	else if(!original_dna)
		original_dna = new carbon_owner.dna.type
		carbon_owner.dna.copy_dna(original_dna)
	if(!already_applied)
		apply_dna(target_dna)
		to_chat(owner, span_warning("You don't feel like yourself anymore..."))

/datum/status_effect/ling_transformation/on_remove()
	. = ..()
	if(QDELETED(owner) || !original_dna)
		return
	apply_dna(original_dna)
	to_chat(owner, span_notice("You feel like yourself again!"))
	UnregisterSignal(owner, COMSIG_LIVING_HEALTHSCAN)

/datum/status_effect/ling_transformation/tick(seconds_per_tick, times_fired)
	. = ..()
	if(owner.reagents.has_reagent(/datum/reagent/medicine/rezadone, amount = 10, needs_metabolizing = TRUE))
		owner.reagents.remove_reagent(/datum/reagent/medicine/rezadone, amount = 10)
		qdel(src)
		return
	if(owner.reagents.has_reagent(/datum/reagent/medicine/clonexadone, needs_metabolizing = TRUE))
		charge_left -= seconds_per_tick
		if(SPT_PROB(4, seconds_per_tick))
			to_chat(owner, span_warning("You begin to feel slightly more like yourself..."))
	if(FLOOR(charge_left, 1) <= 0)
		qdel(src)

/datum/status_effect/ling_transformation/proc/apply_dna(datum/dna/dna)
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner || !istype(carbon_owner))
		return
	dna.transfer_identity(carbon_owner, transfer_SE = TRUE)
	carbon_owner.real_name = carbon_owner.dna.real_name
	carbon_owner.updateappearance(mutcolor_update = TRUE)
	carbon_owner.domutcheck()

/datum/status_effect/ling_transformation/proc/on_healthscan(datum/source, list/render_list, advanced)
	SIGNAL_HANDLER

	if(advanced)
		render_list += "<span class='alert ml-1'>Subject's DNA is a forced, unstable state. <b>Clonexadone</b> or <b>Rezadone</b> may be able to restore it.</span>\n"
