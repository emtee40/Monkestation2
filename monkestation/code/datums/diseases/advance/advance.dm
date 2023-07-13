/datum/disease/advance/after_add()
	if(affected_mob)
		RegisterSignal(affected_mob, COMSIG_LIVING_DEATH, PROC_REF(on_mob_death)) //RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/disease/advance/proc/on_mob_death()
	SIGNAL_HANDLER

	for(var/datum/symptom/S as anything in symptoms) // on death, do the thing.
		S.OnDeath(src)
