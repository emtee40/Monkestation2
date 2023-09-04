#define STORM_STAGE_NONE 0
#define STORM_STAGE_OUTER 1
#define STORM_STAGE_MIDDLE 2
#define STORM_STAGE_INNER 3
//these values might need to be tweaked
#define CLOSE_AREA_MAX_DIST 35
#define MIDDLE_AREA_MAX_DIST 50
/datum/royale_storm_controller
	var/area_consume_timer = 5 SECONDS
	///which list to pick from
	var/list/current_area_pick
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

/datum/royale_storm_controller/New()
	. = ..()
	current_area_pick = outer_areas
	message_admins("Storm started.")
	send_to_playing_players("<span class='userdanger'>The storm has been created! It will consume the station from the outside in, so plan around it!</span>")
	consume_area(/area/space, repeat = FALSE)
	consume_area(/area/space/nearstation, repeat = TRUE) //start the storm

/datum/royale_storm_controller/proc/setup()
	storm_stage = STORM_STAGE_NONE
	build_areas()

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
			inner_areas += area_instance
		else if(general_dist <= MIDDLE_AREA_MAX_DIST)
			middle_areas += area_instance
		else
			outer_areas += area_instance

/datum/royale_storm_controller/proc/check_consumption()

/datum/royale_storm_controller/proc/consume_area(area/area_path, repeat = TRUE)
	var/datum/particle_weather/royale_storm/storm = SSparticle_weather.run_weather(new /datum/particle_weather/royale_storm(), TRUE)
	storms += storm
	storm.area_type = area_path
	//message_admins("Storm consuming [initial(area_path.name)].")
	storm.telegraph()
	if(repeat)
		if(!current_area_pick.len) //there was none left, don't try and take from an empty list
			return
		timerid = addtimer(CALLBACK(src, .proc/consume_area, pick_n_take(current_area_pick)), area_consume_timer)
		if(!current_area_pick.len) //we took the last one
			progression--
			switch(progression)
				if(2)
					send_to_playing_players(span_userdanger("The storm has consumed the entire outer station!"))
					area_consume_timer += 5 SECONDS //get a little slower
					current_area_pick = middle_areas
				if(1)
					send_to_playing_players(span_userdanger("The storm has consumed the majority of the station!"))
					current_area_pick = inner_areas
				if(0)
					send_to_playing_players(span_userdanger("The storm has consumed the ENTIRE station!"))

///stops the storm.
/datum/royale_storm_controller/proc/stop_storm()
	send_to_playing_players(span_userdanger("The storm has been halted by centcom!"))
	if(timerid)
		deltimer(timerid)

///ends the storm.
/datum/royale_storm_controller/proc/end_storm()
	for(var/datum/particle_weather/storm as anything in storms)
		storm.wind_down()
	storms = null

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
