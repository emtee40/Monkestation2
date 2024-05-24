/datum/reagent/proc/disease_incubate(atom/movable/parent, datum/disease/disease, obj/machinery/disease2/incubator/machine)
	return

/datum/reagent/proc/stage_disease_incubate(datum/disease/disease, list/symptoms, obj/machinery/disease2/incubator/machine)
	return


/datum/reagent/medicine/antipathogenic/spaceacillin/disease_incubate(atom/movable/parent, datum/disease/disease, obj/machinery/disease2/incubator/machine)
	disease.log += "<br />[ROUND_TIME()] Weakening (/datum/reagent/medicine/antipathogenic/spaceacillin in [parent])"
	var/change = rand(1,5)
	disease.strength = max(0, disease.strength - change)
	if(machine)
		machine.update_minor(parent,-change)

/datum/reagent/medicine/synaptizine/synaptizinevirusfood/disease_incubate(atom/movable/parent, datum/disease/disease, obj/machinery/disease2/incubator/machine)
	disease.log += "<br />[ROUND_TIME()] Strengthening (Virus Plasma in [parent])"
	var/change = rand(1,5)
	disease.strength = min(100, disease.strength + change)
	if(machine)
		machine.update_minor(parent, change)

/datum/reagent/uranium/uraniumvirusfood/disease_incubate(atom/movable/parent, datum/disease/disease, obj/machinery/disease2/incubator/machine)
	disease.log += "<br />[ROUND_TIME()] Antigen Mutation (Decaying Uranium Gel in [parent])"
	disease.antigenmutate()
	if(istype(parent, /obj/item/weapon/virusdish))
		var/obj/item/weapon/virusdish/dish = parent
		dish.analysed = FALSE
		dish.info = "OUTDATED : [dish.info]"
		dish.update_appearance()
	if(machine)
		machine.update_major(parent)
