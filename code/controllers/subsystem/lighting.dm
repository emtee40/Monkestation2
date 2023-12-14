SUBSYSTEM_DEF(lighting)
	name = "Lighting"
	wait = 2
	init_order = INIT_ORDER_LIGHTING
	flags = SS_TICKER
	var/static/list/sources_queue = list() // List of lighting sources queued for update.
#ifdef VISUALIZE_LIGHT_UPDATES
	var/allow_duped_values = FALSE
	var/allow_duped_corners = FALSE
#endif

/datum/controller/subsystem/lighting/stat_entry(msg)
	msg = "L:[length(sources_queue)]"
	return ..()


/datum/controller/subsystem/lighting/Initialize()

	fire(FALSE, TRUE)
	initialized = TRUE
	return SS_INIT_SUCCESS

/datum/controller/subsystem/lighting/fire(resumed, init_tick_checks)
	MC_SPLIT_TICK_INIT(3)
	if(!init_tick_checks)
		MC_SPLIT_TICK

	var/list/queue
	var/i = 0
	// UPDATE SOURCE QUEUE
	queue = sources_queue
	while(i < length(queue)) //we don't use for loop here because i cannot be changed during an iteration
		i += 1



		var/atom/movable/light/light_source = queue[i]
		light_source.update_visuals()
		light_source.needs_update = LIGHTING_NO_UPDATE


		// We unroll TICK_CHECK here so we can clear out the queue to ensure any removals/additions when sleeping don't fuck us
		if(init_tick_checks)
			if(!TICK_CHECK)
				continue
			queue.Cut(1, i + 1)
			i = 0
			stoplag()
		else if(MC_TICK_CHECK)
			break
	if(i)
		queue.Cut(1, i+1)
		i = 0

	if(!init_tick_checks)
		MC_SPLIT_TICK


/datum/controller/subsystem/lighting/Recover()
	initialized = SSlighting.initialized
	return ..()
