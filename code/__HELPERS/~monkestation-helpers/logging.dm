/// Logging for borer evolutions
/proc/log_borer_evolution(text)
	if (CONFIG_GET(flag/log_uplink))
		WRITE_LOG(GLOB.world_uplink_log, "BORER EVOLUTION: [text]")
