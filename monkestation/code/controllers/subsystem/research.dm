/datum/controller/subsystem/research
	var/boosted = FALSE

/datum/controller/subsystem/research/Initialize()
	. = ..()
	if(!SSticker.HasRoundStarted())
		RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(on_round_start))
	else
		on_round_start()

/datum/controller/subsystem/research/proc/on_round_start()
	SIGNAL_HANDLER
	if(boosted)
		CRASH("Attempted to boost research twice, which should only happen once on roundstart!")
	boosted = TRUE
	addtimer(VARSET_CALLBACK(src, boosted, FALSE), CONFIG_GET(number/roundstart_research_time))
	UnregisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING)

/// Returns a copy of the single server income list, with the research boost multiplier applied if active.
/datum/controller/subsystem/research/proc/boosted_ssi()
	var/list/bitcoins = single_server_income.Copy()
	if(!boosted)
		return bitcoins
	var/boost_mul = CONFIG_GET(number/roundstart_research_boost)
	for(var/shitcoin in bitcoins)
		bitcoins[shitcoin] *= boost_mul
	return bitcoins
