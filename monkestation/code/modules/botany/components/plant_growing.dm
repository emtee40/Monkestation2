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
	///how much water we can have at max used to determine %
	var/max_water = 200

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

	var/pest_level = 0
	var/weed_level = 0

	var/pollinated = FALSE

/datum/component/plant_growing/Initialize(max_reagents = 40, maximum_seeds = 1)
	. = ..()

	var/atom/movable/movable_parent = parent
	src.maximum_seeds = maximum_seeds
	///we create reagents using max_reagents, then make it visible and an open container
	movable_parent.create_reagents(max_reagents, (OPENCONTAINER | AMOUNT_VISIBLE))

	RegisterSignals(parent, list(COMSIG_TRY_PLANT_SEED, COMSIG_ATOM_ATTACKBY), PROC_REF(try_plant_seed))
	RegisterSignal(parent, COMSIG_TRY_POLLINATE, PROC_REF(try_pollinate))

	RegisterSignals(parent, list(COMSIG_TRY_HARVEST_SEEDS, COMSIG_ATOM_ATTACK_HAND), PROC_REF(try_harvest))
	RegisterSignals(movable_parent.reagents, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_DEL_REAGENT, COMSIG_REAGENTS_REM_REAGENT), PROC_REF(on_reagent_change))

	RegisterSignal(parent, COMSIG_GROWING_ADJUST_TOXIN, PROC_REF(adjust_toxin))
	RegisterSignal(parent, COMSIG_GROWING_ADJUST_PEST, PROC_REF(adjust_pests))
	RegisterSignal(parent, COMSIG_GROWING_ADJUST_WEED, PROC_REF(adjust_weeds))
	RegisterSignal(parent, COMSIG_GROWER_ADJUST_SELFGROW, PROC_REF(adjust_selfgrow))
	RegisterSignal(parent, COMSIG_GROWER_INCREASE_WORK_PROCESSES, PROC_REF(increase_work_processes))
	RegisterSignal(parent, COMSIG_REMOVE_PLANT, PROC_REF(remove_plant))
	RegisterSignal(parent, COMSIG_GROWER_CHECK_POLLINATED, PROC_REF(check_pollinated))
	RegisterSignal(parent, COMSIG_ATTEMPT_BIOBOOST, PROC_REF(try_bioboost))
	RegisterSignal(parent, COMSIG_PLANTER_REMOVE_PLANTS, PROC_REF(remove_all_plants))

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

	START_PROCESSING(SSplants, src)
	SEND_SIGNAL(parent, COMSIG_GROWING_WATER_UPDATE, water_precent)

/datum/component/plant_growing/process(seconds_per_tick)
	if(!length(managed_seeds))
		return
	work_stage++
	var/atom/movable/movable_parent = parent
	movable_parent.update_appearance()
	if((work_stage < work_processes) && !bio_boosted)
		return
	work_stage = 0

	for(var/datum/reagent/reagent as anything in movable_parent.reagents.reagent_list)
		reagent.on_plant_grower_apply(parent)

	for(var/obj/item/seeds/seed as anything in managed_seeds)
		if(!bio_boosted)
			adjust_water(-rand(1, 6))
			if(water_precent <= 0)
				SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_HEALTH, -rand(0, 2))
			if(movable_parent.reagents.total_volume <= 5)
				SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_HEALTH, -rand(0, 2))
				continue

		if(water_precent >= 10)
			SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_HEALTH, rand(1, 2))
		SEND_SIGNAL(seed, COMSIG_PLANT_GROWTH_PROCESS, movable_parent.reagents)
		if((self_sustaining_precent >= 100) || bio_boosted)
			continue

		if(prob(seed.weed_chance))
			SEND_SIGNAL(seed, COMSIG_PLANT_ADJUST_WEED, seed.weed_rate)
	movable_parent.reagents.remove_any(movable_parent.reagents.total_volume * 0.05)
	SEND_SIGNAL(movable_parent, COMSIG_NUTRIENT_UPDATE, movable_parent.reagents.total_volume / movable_parent.reagents.maximum_volume)


/datum/component/plant_growing/proc/try_plant_seed(datum/source, obj/item/seeds/seed, mob/living/user)
	SIGNAL_HANDLER
	var/atom/movable/movable_parent = parent
	if(!istype(seed))
		return FALSE

	if(length(managed_seeds) >= maximum_seeds)
		return FALSE

	managed_seeds += seed
	seed.forceMove(parent)
	if(seed.GetComponent(/datum/component/growth_information))
		SEND_SIGNAL(seed, COMSIG_PLANT_BUILD_IMAGE)
		SEND_SIGNAL(seed, COMSIG_PLANT_CHANGE_PLANTER, parent)
		return TRUE

	seed.AddComponent(/datum/component/growth_information, parent)
	SEND_SIGNAL(seed, COMSIG_PLANT_BUILD_IMAGE)
	movable_parent.update_appearance()
	return TRUE

/datum/component/plant_growing/proc/try_harvest(datum/source, mob/living/user)
	if(!length(managed_seeds))
		return

	for(var/obj/item/seeds/seed as anything in managed_seeds)
		SEND_SIGNAL(seed, COMSIG_PLANT_TRY_HARVEST, user)
		if(pollinated)
			seed.adjust_potency(rand(1,2))
			seed.adjust_yield(rand(1,2))
			seed.adjust_endurance(rand(1,2))
			seed.adjust_lifespan(rand(1,2))


/datum/component/plant_growing/proc/try_pollinate(datum/source)
	if(!length(managed_seeds))
		return

	pollinated = TRUE

	for(var/obj/item/seeds/seed as anything in managed_seeds)
		SEND_SIGNAL(seed, COMSIG_PLANT_TRY_POLLINATE, parent)

	addtimer(VARSET_CALLBACK(src, bio_boosted, FALSE), rand(60, 90))

///here we just remove any water added and increase the water precent, add other things you want done once.
/datum/component/plant_growing/proc/on_reagent_change(datum/reagents/holder, ...)
	///restocks water
	if(holder.has_reagent(/datum/reagent/water))
		var/water_volume = holder.get_reagent_amount(/datum/reagent/water)
		adjust_water(water_volume)
		holder.remove_reagent(/datum/reagent/water, water_volume)
	SEND_SIGNAL(parent, COMSIG_NUTRIENT_UPDATE, holder.total_volume / holder.maximum_volume)

/datum/component/plant_growing/proc/adjust_water(amount)
	var/water_precent_filled = (amount / max_water) * 100
	water_precent = clamp(water_precent + water_precent_filled, 0, 100)
	SEND_SIGNAL(parent, COMSIG_GROWING_WATER_UPDATE, water_precent)

/datum/component/plant_growing/proc/adjust_toxin(datum/source, amount)
	toxicity_contents = max(0, toxicity_contents + amount)
	SEND_SIGNAL(parent, COMSIG_TOXICITY_UPDATE, toxicity_contents)

/datum/component/plant_growing/proc/adjust_pests(datum/source, amount)
	pest_level = clamp(pest_level + amount, 0, 10)
	SEND_SIGNAL(parent, COMSIG_PEST_UPDATE, pest_level)

/datum/component/plant_growing/proc/adjust_weeds(datum/source, amount)
	weed_level = clamp(weed_level + amount, 0, 10)
	SEND_SIGNAL(parent, COMSIG_WEEDS_UPDATE, weed_level)

/datum/component/plant_growing/proc/adjust_selfgrow(datum/source, amount)
	self_sustaining_precent = clamp(self_sustaining_precent + amount, 0, 10)

/datum/component/plant_growing/proc/increase_work_processes(datum/source, amount)
	work_stage += amount

/datum/component/plant_growing/proc/on_examine(atom/A, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/atom/movable/movable_parent = parent

	examine_list += span_info("Water: [water_precent]%")
	examine_list += span_info("Nutrients: [movable_parent.reagents.total_volume] units")

	if(bio_boosted)
		examine_list += span_boldnotice("It's currently being bio boosted, plants will grow incredibly quickly.")

	if(self_sustaining_precent >= 100)
		examine_list += span_info("The tray's self-sustenance is active, protecting it from species mutations, weeds, and pests.")
	if(self_growing)
		examine_list += span_info("The tray's self sustaining growth dampeners are off.")
	if(weed_level >= 5)
		examine_list += span_warning("It's filled with weeds!")
	if(pest_level >= 5)
		examine_list += span_warning("It's filled with tiny worms!")

/datum/component/plant_growing/proc/remove_plant(datum/source, obj/item/seeds/seed)
	managed_seeds -= seed
	qdel(seed)
	SEND_SIGNAL(parent, REMOVE_PLANT_VISUALS)

/datum/component/plant_growing/proc/check_pollinated(datum/source)
	return pollinated

/datum/component/plant_growing/proc/try_bioboost(datum/source, duration)
	if(bio_boosted)
		return FALSE
	bio_boosted = TRUE
	addtimer(VARSET_CALLBACK(src, bio_boosted, FALSE), duration)
	return TRUE

/datum/component/plant_growing/proc/remove_all_plants(datum/source)
	for(var/obj/item/seeds/seed as anything in managed_seeds)
		managed_seeds -= seed
		qdel(seed)
		SEND_SIGNAL(parent, REMOVE_PLANT_VISUALS)
