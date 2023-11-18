/datum/disease/food
	name = "Food Poisoning"
	max_stages = 4
	cure_text = "Spaceacillin"
	cures = list(/datum/reagent/medicine/spaceacillin)
	agent = "Salmonella Cosmosis"
	spread_text = "Infected Food or Blood"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "If left untreated the subject will vomit profusely."
	severity = DISEASE_SEVERITY_HARMFUL
	disease_flags = CAN_CARRY|CAN_RESIST
	spread_flags = DISEASE_SPREAD_BLOOD
	required_organs = list(/obj/item/organ/internal/stomach)
	bypasses_immunity = TRUE

/datum/disease/food/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("Your stomach hurts.", "Your stomach feels like its spinning.")]"))
				affected_mob.adjust_disgust(10)
				affected_mob.stamina.adjust(-15)
				if(prob(20))
					affected_mob.adjustToxLoss(1, FALSE)
		if(3)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("Your stomach hurts.", "Your stomach feels like its spinning.")]"))
				affected_mob.stamina.adjust(-15)
				if(prob(20))
					affected_mob.adjustToxLoss(1, FALSE)
			if(SPT_PROB(1.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("[pick("You feel nauseated.", "You feel like you're going to throw up!")]"))
				affected_mob.adjust_disgust(30)
		if(4)
			if(SPT_PROB(1.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("[pick("Your head hurts.", "Your head pounds.")]"))
				affected_mob.stamina.adjust(-25)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("[pick("You feel nauseated.", "You feel like you're going to throw up!")]"))
				affected_mob.adjust_disgust(40)
			if(SPT_PROB(6, seconds_per_tick))
				affected_mob.adjust_disgust(10)
				affected_mob.vomit(20, FALSE, distance = 1)

