/datum/component/plumbing/ooze_compressor
	demand_connects = NORTH

/datum/component/plumbing/ooze_compressor/Initialize(start=TRUE, _ducting_layer, _turn_connects=TRUE, datum/reagents/custom_receiver)
	. = ..()
	if(!istype(parent, /obj/machinery/plumbing/ooze_compressor))
		return COMPONENT_INCOMPATIBLE

/datum/component/plumbing/ooze_compressor/send_request(dir)
	var/obj/machinery/plumbing/ooze_compressor/chamber = parent
	if(chamber.compressing || !chamber.current_recipe)
		return

	for(var/required_reagent in chamber.reagents_for_recipe)
		var/has_reagent = FALSE
		for(var/datum/reagent/containg_reagent as anything in reagents.reagent_list)
			if(required_reagent == containg_reagent.type)
				has_reagent = TRUE
				if(containg_reagent.volume == chamber.reagents_for_recipe[required_reagent])
					continue
				if(containg_reagent.volume + CHEMICAL_QUANTISATION_LEVEL + 1 < chamber.reagents_for_recipe[required_reagent])
					process_request(min(chamber.reagents_for_recipe[required_reagent] - containg_reagent.volume, MACHINE_REAGENT_TRANSFER) , required_reagent, dir)
					return
		if(!has_reagent)
			process_request(min(chamber.reagents_for_recipe[required_reagent], MACHINE_REAGENT_TRANSFER), required_reagent, dir)
			return

	chamber.compress_recipe() //If we move this up, it'll instantly get turned off since any reaction always sets the reagent_total to zero. Other option is make the reaction update
	//everything for every chemical removed, wich isn't a good option either.
	chamber.on_reagent_change(reagents) //We need to check it now, because some reactions leave nothing left.
