#define STORM_STAGE_NONE 0
#define STORM_STAGE_OUTER 1
#define STORM_STAGE_MIDDLE 2
#define STORM_STAGE_INNER 3
//these values might need to be tweaked
#define CLOSE_AREA_MAX_DIST 35
#define MIDDLE_AREA_MAX_DIST 50
/datum/royale_storm_controller
	///how often to consume an area
	var/area_consume_timer = 5 SECONDS
	///which list to pick from
	var/list/current_area_pick = list()
	///outer areas, does not include space
	var/list/outer_areas = list()
	///middle areas
	var/list/middle_areas = list()
	///inner areas
	var/list/inner_areas = list()
	///what stage of consuming the station is the storm
	var/storm_stage = STORM_STAGE_NONE
	///timer id to the next area consumption
	var/timerid
	///active weathers
	var/list/storms = list()
	///ref to our royale controller
	var/datum/battle_royale_controller/royale_controller

/datum/royale_storm_controller/Destroy(force, ...)
	royale_controller = null
	return ..()

///set us up and start us
/datum/royale_storm_controller/proc/setup()
	storm_stage = STORM_STAGE_NONE
	current_area_pick = list()
	build_areas()
	calculate_consume_time()
	message_admins("Storm started.")
	send_to_playing_players(span_userdanger("The storm has been created! It will consume the station from the outside in, so plan around it!"))
	var/datum/particle_weather/royale_storm/outside_storm = new
	outside_storm.weather_duration_lower = royale_controller?.max_duration
	outside_storm.weather_duration_upper = royale_controller?.max_duration
	SSparticle_weather.run_weather(outside_storm, TRUE)
	consume_area(/area/space/nearstation, TRUE) //start the storm

///Build our storm areas
/datum/royale_storm_controller/proc/build_areas()
	outer_areas = list()
	middle_areas = list()
	inner_areas = list()
	var/turf/center = SSmapping.get_station_center()
	for(var/station_area as anything in GLOB.the_station_areas)
		var/area/area_instance = GLOB.areas_by_type[station_area]
		if(!area_instance)
			continue

		var/general_dist = get_dist(locate(/turf) in area_instance, center) //due to the way this is handled it can vary what list an area will go in, but that should be fine
		if(!general_dist)
			message_admins("Area lacking dist for royale storm generation.")
			continue

		if(general_dist <= CLOSE_AREA_MAX_DIST)
			inner_areas += area_instance.type
		else if(general_dist <= MIDDLE_AREA_MAX_DIST)
			middle_areas += area_instance.type
		else
			outer_areas += area_instance.type

///calculate how long inbetween each consume to get the desired game length
/datum/royale_storm_controller/proc/calculate_consume_time()
	if(!royale_controller || !royale_controller.max_duration)
		message_admins("No set royale_controller[royale_controller ? ".max_duration" : ""] for a royale storm controller.")
		return

	area_consume_timer = truncate(royale_controller.max_duration / (length(outer_areas) + length(middle_areas) + length(inner_areas)))

///consume an area with a storm
/datum/royale_storm_controller/proc/consume_area(area/area_path, repeat = FALSE)
	var/datum/weather/royale_storm/storm = new(SSmapping.levels_by_trait(ZTRAIT_STATION))
	storms += storm
	storm.area_type = area_path
	message_admins("Storm consuming [initial(area_path.name)].")
	storm.telegraph()
	if(repeat)
		message_admins("ONE")
		if(!current_area_pick)
			message_admins("TWO")
			return

		if(!length(current_area_pick)) //there was none left, don't try and take from an empty list
			message_admins("THREE")
			switch(storm_stage)
				if(STORM_STAGE_NONE)
					message_admins("N")
					storm_stage = STORM_STAGE_OUTER
					current_area_pick = outer_areas
				if(STORM_STAGE_OUTER)
					message_admins("O")
					send_to_playing_players(span_userdanger("The storm has consumed the entire outer station!"))
					storm_stage = STORM_STAGE_MIDDLE
					current_area_pick = middle_areas
				if(STORM_STAGE_MIDDLE)
					message_admins("M")
					send_to_playing_players(span_userdanger("The storm has consumed the majority of the station!"))
					storm_stage = STORM_STAGE_INNER
					current_area_pick = inner_areas
				if(STORM_STAGE_INNER)
					message_admins("I")
					send_to_playing_players(span_userdanger("The storm has consumed the ENTIRE station!"))
					current_area_pick = null
					return
		timerid = addtimer(CALLBACK(src, PROC_REF(consume_area), pick_n_take(current_area_pick), TRUE), area_consume_timer)
		message_admins("HHHHHMMMM[area_consume_timer]")

///stops the storm.
/datum/royale_storm_controller/proc/stop_storm()
	send_to_playing_players(span_userdanger("The storm has been halted by centcom!"))
	if(timerid)
		deltimer(timerid)

///ends the storm.
/datum/royale_storm_controller/proc/end_storm()
	for(var/datum/particle_weather/storm as anything in storms)
		storm.wind_down()
	SSparticle_weather.stop_weather()
	storms = null

/datum/weather/royale_storm
	name = "royale storm"
	desc = "A sick creation of the most ADHD ridden centcom scientists, used to force stationgoers to fight with the threat of being shredded by an artificial storm for entertainment."

	telegraph_duration = 1 SECONDS
	weather_overlay = "royale"
	perpetual = TRUE

	telegraph_message = null
	weather_message = null
	end_message = null

	target_trait = ZTRAIT_STATION

	immunity_type = "NOTHING KID"

/datum/weather/royale_storm/weather_act(mob/living/living_affected)
	living_affected.adjustFireLoss(5)
	to_chat(living_affected, span_userdanger("You're badly burned by the storm!"))

//for outside
/datum/particle_weather/royale_storm
	name = "Battle Royale Storm"
	display_name = "Battle Royale Storm"
	desc = "A sick creation of the most ADHD ridden centcom scientists, used to force stationgoers to fight with the threat of being shredded by an artificial storm for entertainment."
	particle_effect_type = /particles/weather/rain/storm/royale

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/rain)
	weather_messages = list(span_userdanger("You're badly burned by the storm!"))

	damage_type = BURN
	damage_per_tick = 5
	min_severity = 4
	max_severity = 150
	max_severity_change = 50
	severity_steps = 50
	probability = 1

	weather_warnings = list("siren" = null, "message" = FALSE)
	fire_smothering_strength = 6
	weather_traits = WEATHERTRAIT_NO_IMMUNITIES

/particles/weather/rain/storm/royale
	gradient               = list(0,"#4d00ff",1,"#8550ff",2,"#3900bd","loop")
	color_change		   = generator("num",-5,5)

#undef STORM_STAGE_NONE
#undef STORM_STAGE_OUTER
#undef STORM_STAGE_MIDDLE
#undef STORM_STAGE_INNER
#undef CLOSE_AREA_MAX_DIST
#undef MIDDLE_AREA_MAX_DIST
