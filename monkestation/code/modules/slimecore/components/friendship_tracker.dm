/datum/component/friendship_container
	///our friendship thresholds from lowest to highest
	var/list/friendship_levels = list()
	///our current friends stored as a weakref = amount
	var/list/weakrefed_friends = list()

/datum/component/friendship_container/Initialize(friendship_levels = list())
	. = ..()
	if(!length(friendship_levels))
		return FALSE

	src.friendship_levels = friendship_levels


/datum/component/friendship_container/RegisterWithParent()
	RegisterSignal(parent, COMSIG_FRIENDSHIP_CHECK_LEVEL, PROC_REF(check_friendship_level))
	RegisterSignal(parent, COMSIG_FRIENDSHIP_CHANGE, PROC_REF(change_friendship))

/datum/component/friendship_container/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_FRIENDSHIP_CHECK_LEVEL)
	UnregisterSignal(parent, COMSIG_FRIENDSHIP_CHANGE)

/datum/component/friendship_container/proc/change_friendship(datum/source, atom/target, amount)
	for(var/datum/weakref/ref as anything in weakrefed_friends)
		if(ref.resolve() == target)
			weakrefed_friends[ref] += amount
			return TRUE
	weakrefed_friends += list(WEAKREF(target) = amount)
	return TRUE

///Returns {TRUE} if friendship is above a certain threshold else returns {FALSE}
/datum/component/friendship_container/proc/check_friendship_level(datum/source, atom/target, friendship_level)
	for(var/datum/weakref/ref as anything in weakrefed_friends)
		if(ref.resolve() == target)
			if(friendship_levels[friendship_level] <= weakrefed_friends[ref])
				return TRUE
			return FALSE
	return FALSE
