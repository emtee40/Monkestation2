/datum/component/abberant_organ
	///our trigger
	var/datum/organ_trigger/trigger
	///our processors
	var/list/processors = list()
	///our outcome
	var/datum/organ_outcome/outcome
	///list of added traits
	var/list/organ_traits = list()
	///our stability
	var/stability = 100
	///our complexity
	var/complexity = 0
	///our max complexity before genetic failure
	var/max_complexity = 100
	///weakref to our human
	var/datum/weakref/host
	///our restriction flags
	var/restriction_flags = NONE

/datum/component/abberant_organ/Initialize(max_complexity = 100, restriction_flags = NONE)
	. = ..()
	src.max_complexity = max_complexity
	src.restriction_flags = restriction_flags

/datum/component/abberant_organ/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ABBERANT_TRIGGER, PROC_REF(trigger))
	RegisterSignal(parent, COMSIG_ABBERANT_OUTCOME, PROC_REF(process_outcome))
	RegisterSignal(parent, COMSIG_ABBERANT_ADD_TRAIT, PROC_REF(add_trait))
	RegisterSignal(parent, COMSIG_ABBERANT_TRY_ADD_PROCESS, PROC_REF(try_add_process))

	RegisterSignal(parent, COMSIG_ORGAN_IMPLANTED, PROC_REF(add_host))
	RegisterSignal(parent, COMSIG_ORGAN_REMOVED, PROC_REF(remove_host))

/datum/component/abberant_organ/proc/add_host(obj/item/organ/source, mob/living/new_host)
	host = WEAKREF(new_host)
	SEND_SIGNAL(parent, COMSIG_ABBERANT_HOST_SET, host)

/datum/component/abberant_organ/proc/remove_host()
	host = null
	SEND_SIGNAL(parent, COMSIG_ABBERANT_HOST_CLEARED)

/datum/component/abberant_organ/proc/trigger()
	SIGNAL_HANDLER

/datum/component/abberant_organ/proc/add_trait(datum/source, /datum/organ_trait)
	//TODO

/datum/component/abberant_organ/proc/try_add_process(datum/source, datum/organ_process/process)
	if(!(restriction_flags & process.process_flags))
		return FALSE

/datum/component/abberant_organ/proc/process_outcome(datum/source)
	//TODO
