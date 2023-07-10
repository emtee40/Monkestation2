/datum/symptom/cockroach

	name = "SBG Syndrome"
	desc = "Causes bluespace synchronicity with nearby air channels, making the roaches infesting the station's scrubbers crawl from the host's face"
	stealth = 1
	resistance = 2
	stage_speed = 3
	transmittable = 1
	level = 0
	severity = 0 //rip funy
	symptom_delay_min = 10
	symptom_delay_max = 30
	var/death_roaches = FALSE
	threshold_descs = list(
		"Stage Speed 8" = "Increases roach speed",
		"Transmission 8" = "When the host dies, more roaches spawn"
		)

/datum/symptom/cockroach/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.totalStageSpeed() >= 8)
		symptom_delay_min = 5
		symptom_delay_max = 15
	if(A.totalTransmittable() >= 8)
		death_roaches = TRUE

/datum/symptom/cockroach/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	switch(A.stage)
		if(2)
			if(prob(50))
				to_chat(M, "<span class='notice'>You feel a tingle under your skin.</span>")
		if(3)
			if(prob(50))
				to_chat(M, "<span class='notice'>Your pores feel drafty.</span>")
			if(prob(5))
				to_chat(M, "<span class='notice'>You feel attuned to the atmosphere.</span>")
		if(4)
			if(prob(50))
				to_chat(M, "<span class='notice'>You feel in tune with the station.</span>")
		if(5)
			if(prob(30))
				M.visible_message("<span class='danger'>[M] squirms as a cockroach crawls from their pores!</span>", \
								  "<span class='userdanger'>A cockroach crawls out of your face!!</span>")
				new /mob/living/basic/cockroach(M.loc)
			if(prob(50))
				to_chat(M, "<span class='notice'>You feel something crawling in your pipes!</span>")

/datum/symptom/cockroach/OnDeath(datum/disease/advance/A)
	if(!..())
		return
	if(death_roaches)
		var/mob/living/carbon/M = A.affected_mob
		to_chat(M, "<span class='warning'>Your pores explode into a colony of roaches!</span>")
		for(var/i in 1 to rand(1,5))
			new /mob/living/basic/cockroach(M.loc)

