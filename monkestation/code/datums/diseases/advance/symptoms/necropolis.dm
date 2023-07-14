/datum/symptom/necroseed
	name = "Necropolis Seed"
	desc = "An infantile form of the root of Lavaland's tendrils. Forms a symbiotic bond with the host, making them stronger and hardier, at the cost of speed. Should the disease be cured, the host will be severely weakened."
	stealth = 0
	resistance = 5
	stage_speed = -5
	transmittable = -3
	level = 8
	base_message_chance = 5
	severity = -1
	symptom_delay_min = 1
	symptom_delay_max = 1
	threshold_descs = list(
		"Stealth 7" = "Upon death, the host's soul will solidify into an unholy artifact, rendering them utterly unrevivable in the process.",
		"Resistance 12" = "The area near the host roils with paralyzing tendrils.",
		"Resistance 15" = "Host becomes Immune to heat and ash",

	)
	///responsible for tendrils popping out of the ground near player
	var/tendrils = FALSE
	///if affected person is stage 5, they can turn into a chest and get dusted, making respawning hard, does not work on monkeys.
	var/chest = FALSE
	///responsible for giving the player immunity to lavaland hazards lava,fire,storms,pressure.
	var/fireproof = FALSE
	///keeps track of our tentacles
	var/list/cached_tentacle_turfs
	///keeps track of tentacles last locations
	var/turf/last_location
	///limits tentacles to happen with delays
	var/tentacle_recheck_cooldown = 100

/datum/symptom/necroseed/Start(datum/disease/advance/advanced_disease)
	if(!..())
		return
	if(advanced_disease.totalResistance() >= 12)
		tendrils = TRUE
		if(advanced_disease.totalResistance() >= 15)
			fireproof = TRUE
	if(advanced_disease.totalStealth() >= 7)
		chest = TRUE

/datum/symptom/necroseed/Activate(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/victim = advanced_disease.affected_mob
	switch(advanced_disease.stage)
		if(2)
			if(prob(base_message_chance))
				to_chat(victim, span_notice("Your skin feels scaly."))
		if(3, 4)
			if(prob(base_message_chance))
				to_chat(victim, span_notice("[pick("Your skin is hard.", "You feel stronger.", "You feel powerful.")]"))
		if(5)
			if(tendrils)
				tendril(advanced_disease)
			victim.dna.species.brutemod = min(0.6, victim.dna.species.brutemod)
			victim.dna.species.burnmod = min(0.6, victim.dna.species.burnmod)
			victim.dna.species.heatmod = min(0.6, victim.dna.species.heatmod)
			victim.add_movespeed_modifier(/datum/movespeed_modifier/necro_virus)
			ADD_TRAIT(victim, TRAIT_PIERCEIMMUNE, DISEASE_TRAIT)
			if(fireproof)
				ADD_TRAIT(victim, TRAIT_RESISTHEAT, DISEASE_TRAIT)
				ADD_TRAIT(victim, TRAIT_RESISTHIGHPRESSURE, DISEASE_TRAIT)
				ADD_TRAIT(victim, TRAIT_LAVA_IMMUNE, DISEASE_TRAIT)
				ADD_TRAIT(victim, TRAIT_ASHSTORM_IMMUNE, DISEASE_TRAIT)
				ADD_TRAIT(victim, TRAIT_SNOWSTORM_IMMUNE, DISEASE_TRAIT)

/datum/movespeed_modifier/necro_virus
	multiplicative_slowdown = 0.65
	blacklisted_movetypes = (FLYING|FLOATING)

/datum/symptom/necroseed/proc/tendril(datum/disease/advance/advanced_disease)
	. = advanced_disease.affected_mob
	var/mob/living/loc = advanced_disease.affected_mob.loc
	if(isturf(loc))
		if(!LAZYLEN(cached_tentacle_turfs) || loc != last_location || tentacle_recheck_cooldown <= world.time)
			LAZYCLEARLIST(cached_tentacle_turfs)
			last_location = loc
			tentacle_recheck_cooldown = world.time + initial(tentacle_recheck_cooldown)
			for(var/turf/open/tentacle in (RANGE_TURFS(1, loc)-loc))
				LAZYADD(cached_tentacle_turfs, tentacle)
		for(var/tentacle2 in cached_tentacle_turfs)
			if(isopenturf(tentacle2))
				if(prob(5))
					new /obj/effect/temp_visual/goliath_tentacle/necro(tentacle2, advanced_disease.affected_mob)
			else
				cached_tentacle_turfs -= tentacle2

/datum/symptom/necroseed/End(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/victim = advanced_disease.affected_mob
	to_chat(victim, span_danger("You feel weak and powerless as the necropolis' blessing leaves your body, leaving you slow and vulnerable."))
	victim.dna.species.brutemod = initial(victim.dna.species.heatmod)
	victim.dna.species.burnmod = initial(victim.dna.species.heatmod)
	victim.dna.species.heatmod = initial(victim.dna.species.heatmod)
	victim.remove_movespeed_modifier(/datum/movespeed_modifier/necro_virus)
	REMOVE_TRAIT(victim, TRAIT_PIERCEIMMUNE, DISEASE_TRAIT)
	if(fireproof)
		REMOVE_TRAIT(victim, TRAIT_RESISTHIGHPRESSURE, DISEASE_TRAIT)
		REMOVE_TRAIT(victim, TRAIT_RESISTHEAT, DISEASE_TRAIT)
		REMOVE_TRAIT(victim, TRAIT_LAVA_IMMUNE, DISEASE_TRAIT)
		REMOVE_TRAIT(victim, TRAIT_ASHSTORM_IMMUNE, DISEASE_TRAIT)
		REMOVE_TRAIT(victim, TRAIT_SNOWSTORM_IMMUNE, DISEASE_TRAIT)

/datum/symptom/necroseed/OnDeath(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/victim = advanced_disease.affected_mob
	if(chest && advanced_disease.stage >= 5)
		to_chat(victim, span_danger("Your soul is ripped from your body!</span>"))
		victim.visible_message(span_danger("An unearthly roar shakes the ground as [victim] expires, leaving behind an ominous, fleshy chest."))
		playsound(victim.loc,'sound/effects/tendril_destroyed.ogg', 200, 0, 50, 1, 1)
		victim.dust(FALSE,TRUE,TRUE) //so if stealth is 8, they get dusted on death, this and no monke farming reduces the ways they can farm chests to using cloners...with are slow.
		if(ismonkey(victim))// anti chest farming
			return
		if(iscarbon(victim)) // if carbon and not monkey, drop a chest.
			new /obj/structure/closet/crate/necropolis/tendril(victim.loc)


/obj/effect/temp_visual/goliath_tentacle/necro
	name = "fledgling necropolis tendril"

/obj/effect/temp_visual/goliath_tentacle/necro/trip()
	var/latched = FALSE
	for(var/mob/living/goliath_tentacles_target in loc)
		if(goliath_tentacles_target == spawner)
			retract()
			return
		visible_message(span_danger("[src] grabs hold of [goliath_tentacles_target]!"))
		goliath_tentacles_target.Stun(40)
		goliath_tentacles_target.adjustBruteLoss(rand(1,10))
		latched = TRUE
	if(!latched)
		retract()
	else
		deltimer(timerid)
		timerid = addtimer(CALLBACK(src, PROC_REF(retract)), 10, TIMER_STOPPABLE)
