/datum/reagent/toxin/mutagen/mutagenvirusfood/stage_disease_incubate(atom/movable/parent, datum/disease/disease, list/symptoms, obj/machinery/disease2/incubator/machine)
	disease.log += "<br />[ROUND_TIME()] Effect Mutation (Mutagenic Agar)"
	for(var/datum/symptom/listed as anything in symptoms)
		disease.effectmutate(isliving(parent), listed)
		if(istype(parent, /obj/item/weapon/virusdish))
			var/obj/item/weapon/virusdish/dish = parent
			dish.analysed = FALSE
			dish.info = "OUTDATED : [dish.info]"
			dish.update_appearance()
			if(machine)
				machine.update_major(parent)

/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar/stage_disease_incubate(atom/movable/parent, datum/disease/disease, list/symptoms, obj/machinery/disease2/incubator/machine)
	disease.log += "<br />[ROUND_TIME()] Effect Chance Strengthing (Sucrose Agar)"
	for(var/datum/symptom/listed as anything in symptoms)
		listed.chance = min(listed.chance + rand(2, 3), listed.max_chance)
		if(istype(parent, /obj/item/weapon/virusdish))
			var/obj/item/weapon/virusdish/dish = parent
			dish.analysed = FALSE
			dish.info = "OUTDATED : [dish.info]"
			dish.update_appearance()
