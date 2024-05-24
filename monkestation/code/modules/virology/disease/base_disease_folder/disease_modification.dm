/datum/disease/advanced/proc/incubate(atom/incubator, mutatechance=1, specified_stage=0)
	mutatechance *= mutation_modifier

	var/mob/living/body = null
	var/obj/item/weapon/virusdish/dish = null
	var/obj/machinery/disease2/incubator/machine = null

	if (isliving(incubator))
		body = incubator
	else if (istype(incubator,/obj/item/weapon/virusdish))
		dish = incubator
		if (istype(dish.loc,/obj/machinery/disease2/incubator))
			machine = dish.loc

	if(specified_stage)
		for(var/x in symptoms.len)
			if(x == specified_stage)
				var/datum/symptom/e = symptoms[x]
				e.multiplier_tweak(0.1 * rand(1, 3))
				minormutate(specified_stage)
				if(e.chance == e.max_chance && prob(strength) && e.max_chance <= initial(e.max_chance) * 3)
					e.max_chance++

	if (mutatechance > 0 && (body || dish) && incubator.reagents)
		if (incubator.reagents.has_reagent(/datum/reagent/toxin/mutagen,  0.5) && incubator.reagents.has_reagent(/datum/reagent/consumable/nutriment/protein,0.5))
			if(incubator.reagents.remove_reagent(/datum/reagent/toxin/mutagen, 0.5) && incubator.reagents.remove_reagent(/datum/reagent/consumable/nutriment/protein,0.5))
				log += "<br />[ROUND_TIME()] Robustness Strengthening (Mutagen and Protein in [incubator])"
				var/change = rand(1,5)
				robustness = min(100,robustness + change)
				for(var/datum/symptom/e in symptoms)
					e.multiplier_tweak(0.1)
				if (dish)
					if (machine)
						machine.update_minor(dish,0,change,0.1)
		else if (incubator.reagents.has_reagent(/datum/reagent/toxin/mutagen, 0.5) && incubator.reagents.has_reagent(/datum/reagent/medicine/antipathogenic/spaceacillin,0.5))
			if(incubator.reagents.remove_reagent(/datum/reagent/toxin/mutagen, 0.5) && incubator.reagents.remove_reagent(/datum/reagent/medicine/antipathogenic/spaceacillin,0.5))
				log += "<br />[ROUND_TIME()] Robustness Weakening (Mutagen and spaceacillin in [incubator])"
				var/change = rand(1,5)
				robustness = max(0,robustness - change)
				for(var/datum/symptom/e in symptoms)
					e.multiplier_tweak(-0.1)
				if (dish)
					if (machine)
						machine.update_minor(dish,0,-change,-0.1)
		else
			if(incubator.reagents.remove_reagent(/datum/reagent/toxin/mutagen, 0.05) && prob(mutatechance))
				log += "<br />[ROUND_TIME()] Effect Mutation (Mutagen in [incubator])"
				effectmutate(body != null)
				if (dish)
					if(dish.info && dish.analysed)
						dish.info = "OUTDATED : [dish.info]"
						dish.analysed = 0
					dish.update_icon()
					if (machine)
						machine.update_major(dish)
			if(incubator.reagents.remove_reagent(/datum/reagent/consumable/nutriment/protein,0.05) && prob(mutatechance))
				log += "<br />[ROUND_TIME()] Strengthening (/datum/reagent/consumable/nutriment/protein in [incubator])"
				var/change = rand(1,5)
				strength = min(100,strength + change)
				if (dish)
					if (machine)
						machine.update_minor(dish,change)
			if(incubator.reagents.remove_reagent(/datum/reagent/medicine/antipathogenic/spaceacillin,0.05) && prob(mutatechance))
				log += "<br />[ROUND_TIME()] Weakening (/datum/reagent/medicine/antipathogenic/spaceacillin in [incubator])"
				var/change = rand(1,5)
				strength = max(0,strength - change)
				if (dish)
					if (machine)
						machine.update_minor(dish,-change)
		if(incubator.reagents.remove_reagent(/datum/reagent/uranium/radium,0.02) && prob(mutatechance/8))
			log += "<br />[ROUND_TIME()] Antigen Mutation (Radium in [incubator])"
			antigenmutate()
			if (dish)
				if(dish.info && dish.analysed)
					dish.info = "OUTDATED : [dish.info]"
					dish.analysed = 0
				if (machine)
					machine.update_major(dish)

/datum/disease/advanced/proc/minormutate(index)
	var/datum/symptom/e = get_effect(index)
	e.minormutate()
	infectionchance = min(50,infectionchance + rand(0,10))
	log += "<br />[ROUND_TIME()] Infection chance now [infectionchance]%"

/datum/disease/advanced/proc/minorstrength(index)
	var/datum/symptom/e = get_effect(index)
	e.multiplier_tweak(0.1)

/datum/disease/advanced/proc/minorweak(index)
	var/datum/symptom/e = get_effect(index)
	e.multiplier_tweak(-0.1)

//Major Mutations
/datum/disease/advanced/proc/effectmutate(var/inBody=FALSE)
	clean_global_log()
	subID = rand(0,9999)
	var/list/randomhexes = list("7","8","9","a","b","c","d","e")
	var/colormix = "#[pick(randomhexes)][pick(randomhexes)][pick(randomhexes)][pick(randomhexes)][pick(randomhexes)][pick(randomhexes)]"
	color = BlendRGB(color,colormix,0.25)
	var/i = rand(1, symptoms.len)
	var/datum/symptom/e = symptoms[i]
	var/datum/symptom/f
	if (inBody)//mutations that occur directly in a body don't cause helpful symptoms to become deadly instantly.
		f = new_random_effect(min(5,text2num(e.badness)+1), max(0,text2num(e.badness)-1), e.stage, e.type)
	else
		f = new_random_effect(min(5,text2num(e.badness)+2), max(0,text2num(e.badness)-3), e.stage, e.type)//badness is slightly more likely to go down than up.
	symptoms[i] = f
	log += "<br />[ROUND_TIME()] Mutated effect [e.name] [e.chance]% into [f.name] [f.chance]%."
	update_global_log()

/datum/disease/advanced/proc/antigenmutate()
	clean_global_log()
	subID = rand(0,9999)
	var/old_dat = get_antigen_string()
	roll_antigen()
	log += "<br />[ROUND_TIME()] Mutated antigen [old_dat] into [get_antigen_string()]."
	update_global_log()
