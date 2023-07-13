/datum/symptom/beesease
	name = "Bee Infestation"
	desc = "Causes the host to cough toxin bees and occasionally synthesize toxin."
	stealth = -2
	resistance = 2
	stage_speed = 1
	transmittable = 1
	level = 0
	severity = 2
	symptom_delay_min = 5
	symptom_delay_max = 20
	///determines if host gets reagents or not
	var/honey = FALSE
	///false=no bee spawning, true= bee spawns
	var/toxic_bees= FALSE
	threshold_descs = list(
		"Resistance 12" = "The bees become symbiotic with the host, synthesizing honey and no longer stinging the stomach lining, and no longer attacking the host. Bees will also contain honey, unless transmission exceeds 10.",
		"Transmission 10" = "Bees now contain a completely random toxin."
		)

/datum/symptom/beesease/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalResistance() >= 12)
		honey = TRUE
	if(A.totalTransmittable() >= 10)
		toxic_bees = TRUE

/datum/symptom/beesease/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/Affected = A.affected_mob
	switch(A.stage)
		if(2)
			if(prob(2))
				to_chat(Affected, span_notice("You taste honey in your mouth."))
		if(3)
			if(prob(15))
				to_chat(Affected, span_notice("Your stomach tingles."))
			if(prob(15))
				if(honey)
					to_chat(Affected, span_notice("You can't get the taste of honey out of your mouth!"))
					Affected.reagents.add_reagent(/datum/reagent/consumable/honey, 2)
				else
					to_chat(Affected, span_userdanger("Your stomach stings painfully."))
					Affected.adjustToxLoss(5)
					Affected.updatehealth()
		if(4, 5)
			if(honey)
				ADD_TRAIT(Affected, TRAIT_BEEFRIEND, DISEASE_TRAIT)
			if(prob(15))
				to_chat(Affected, span_notice("Your stomach squirms."))
			if(prob(25))
				if(honey)
					to_chat(Affected, span_notice("You can't get the taste of honey out of your mouth!."))
					Affected.reagents.add_reagent_list(list(/datum/reagent/consumable/honey = 10, /datum/reagent/medicine/insulin = 5)) //insulin prevents hyperglycemic shock
				else
					to_chat(Affected, span_danger("Your stomach stings painfully."))
					Affected.adjustToxLoss(5)
					Affected.updatehealth()
			if(prob(10))
				Affected.visible_message(span_danger("[Affected] buzzes."), \
								  span_userdanger("Your stomach buzzes violently!"))
			if(prob(15))
				to_chat(Affected, span_danger("You feel something moving in your throat."))
			if(prob(10))
				Affected.visible_message(span_danger("[Affected] coughs up a bee!"), \
								  span_userdanger("You cough up a bee!"))
				if(toxic_bees)
					new /mob/living/simple_animal/hostile/bee/toxin(Affected.loc)
				else if(honey)
					var/mob/living/simple_animal/hostile/bee/newbee = new /mob/living/simple_animal/hostile/bee(Affected.loc) //Heh, newbee
					newbee.assign_reagent(GLOB.chemical_reagents_list[/datum/reagent/consumable/honey])
					var/mob/living/simple_animal/hostile/bee/newbee2 = new /mob/living/simple_animal/hostile/bee(Affected.loc)
					newbee2.assign_reagent(GLOB.chemical_reagents_list[/datum/reagent/medicine/insulin])
				else
					new /mob/living/simple_animal/hostile/bee(Affected.loc)

/datum/symptom/beesease/End(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(A.affected_mob, TRAIT_BEEFRIEND, DISEASE_TRAIT)
