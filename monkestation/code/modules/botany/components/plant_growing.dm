//this is the source of the old hydrotray behaviours
/datum/component/plant_growing
	///this is our managed seeds
	var/list/managed_seeds = list()
	///this is the amount of seeds we can have at once in a tray
	var/maximum_seeds = 1

	///are we bioboosted
	var/bio_boosted = FALSE
	///our current water precent
	var/water_precent = 100
	///how many processes we need to work

	var/work_processes = 10
	///how many processes we've done
	var/work_stage = 0

	///how toxic our tray currently is % wise
	var/toxicity_contents = 0

	///the icon we apply to our parent if we are self sustaining
	var/self_sustaining_overlay
	///the current precentage we are to self sustaining
	var/self_sustaining_precent = 0
	///does self sustaining also increase plant stats slowly
	var/self_growing = FALSE

/datum/component/plant_growing/Initialize(max_reagents = 40, maximum_seeds = 1)
	. = ..()
	src.maximum_seeds = maximum_seeds
	///we create reagents using max_reagents, then make it visible and an open container
	parent.create_reagents(max_reagents, (OPENCONTAINER | AMOUNT_VISIBLE))

	RegisterSignal(parent, COMSIG_TRY_PLANT_SEED, PROC_REF(try_plant_seed))
	RegisterSignal(parent, COMSIG_TRY_HARVEST_SEEDS, PROC_REF(try_harvest))
	RegisterSignal(parent, COMSIG_TRY_POLLINATE, PROC_REF(try_pollinate))

	RegisterSignals(parent, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_DEL_REAGENT, COMSIG_REAGENTS_REM_REAGENT), PROC_REF(on_reagent_change))

	START_PROCESSING(SSplants, src)

/datum/component/plant_growing/process(seconds_per_tick)
	if(!length(managed_seeds))
		return
	work_stage++
	if((work_stage < work_processes) && !bio_boosted)
		return
	work_stage = 0

	for(var/obj/item/seeds/seed as anything in managed_seeds)
		if(!bio_boosted)
			water_precent -= max(water_precent - rand(1, 6), 0)
			if(water_precent <= 0)
				SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_HEALTH, -rand(0, 2))
				continue
		if(water_precent >= 10)
			SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_HEALTH, rand(1, 2))
		SEND_SIGNAL(seed, COMSIG_PLANT_GROWTH_PROCESS, parent.reagents)
		if(self_growing)
			adjust_seed_stats(seed)
		if((self_sustaining_precent >= 100) || bio_boosted)
			continue

		if(prob(seed.weed_chance))
			SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_WEED, seed.weedrate)

/datum/component/plant_growing/proc/try_plant_seed(obj/item/seed/seed)
	if(length(managed_seeds) >= maximum_seeds)
		return FALSE

	managed_seeds += seed
	seed.forceMove(parent)
	if(seed.GetComponent(/datum/component/growth_information))
		SEND_SIGNAL(seed, COMSIG_PLANT_BUILD_IMAGE)
		return TRUE

	seed.AddComponent(/datum/component/growth_information)
	SEND_SIGNAL(seed, COMSIG_PLANT_BUILD_IMAGE)
	return TRUE

/datum/component/plant_growing/proc/try_harvest()
	if(!length(managed_seeds))
		return

	for(var/obj/item/seed/seed as anything in managed_seeds)
		SEND_SIGNAL(seed, COMSIG_PLANT_TRY_HARVEST, parent)
