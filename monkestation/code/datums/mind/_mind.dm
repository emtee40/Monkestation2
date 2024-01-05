/datum/mind
	/// A holder datum used to handle holoparasites and their shared behavior.
	var/datum/holoparasite_holder/holoparasite_holder

/datum/mind/proc/holoparasite_holder()
	if(!holoparasite_holder)
		holoparasite_holder = new(src)
	return holoparasite_holder
