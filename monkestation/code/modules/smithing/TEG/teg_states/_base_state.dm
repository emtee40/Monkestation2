//basically instead of having crazy weird chains for how the TEG calculates power we instead use a datum for the state
//this allows us to have TEGS that perform wildly different and is needed for when we arc plate the TEG
/datum/thermoelectric_state
	///the WEAKREF to our parent
	var/datum/weakref/owner

/datum/thermoelectric_state/proc/on_apply()

/datum/thermoelectric_state/proc/on_remove()
