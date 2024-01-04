/datum/action/changeling/sting/transformation
	helptext = "The victim will transform much like a changeling would. Does not provide a warning to others. Mutations will not be transferred, and monkeys will become human. Can be reversed through exposure to clonexadone."

/datum/action/changeling/sting/transformation/sting_action(mob/user, mob/living/carbon/target)
	if(!istype(target))
		return
	. = TRUE
	log_combat(user, target, "stung", "transformation sting", " new identity is '[selected_dna.dna.real_name]'")
	var/datum/dna/new_dna = selected_dna.dna
	var/datum/status_effect/ling_transformation/previous_transformation = target.has_status_effect(STATUS_EFFECT_LING_TRANSFORMATION)
	target.apply_status_effect(STATUS_EFFECT_LING_TRANSFORMATION, new_dna, istype(previous_transformation) ? previous_transformation.original_dna : null)
