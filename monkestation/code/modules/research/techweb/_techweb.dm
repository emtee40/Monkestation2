/datum/techweb/add_point_list(list/bitcoins, boost = TRUE)
	if(boost && SSresearch.boosted)
		var/boost_mul = CONFIG_GET(number/roundstart_research_boost)
		for(var/shitcoin in bitcoins)
			bitcoins[shitcoin] *= boost_mul
	return ..()

