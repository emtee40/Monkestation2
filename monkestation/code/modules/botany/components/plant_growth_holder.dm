/datum/component/growth_information
	///how much we have grown % wise
	var/growth_precent = 0
	///our age
	var/age = 0
	///how many growth cycles we have gone through
	var/growth_cycle = 0
	///can we be harvested multiple times?
	var/repeated_harvest = FALSE
	///has a bee visited us recently
	var/pollinated = FALSE
	///our current health value
	var/health_value
	///our modifier to yield
	var/yield_modifier = 1
	///our current plant state
	var/plant_state = NONE
	///the mutable appearance we have created
	var/mutable_appearance/current_looks
	///our current planter host
	var/atom/movable/planter
