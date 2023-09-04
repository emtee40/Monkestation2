/mob/living/carbon/proc/handle_weather(delta_time = 1, area/given_area)
	var/turf/turf = get_turf(src)
//	var/area/current_area = get_area(turf)
	var/datum/particle_weather/area_particle_weather = SSparticle_weather.area_weather[given_area]
	// Check if we're supposed to be something affected by weather
	if(SSparticle_weather.running_weather && (turf.turf_flags & TURF_WEATHER))
		current_weather_effect_type = SSparticle_weather.running_weather
	else if(area_particle_weather)
		current_weather_effect_type = area_particle_weather
		area_particle_weather.process_mob_effect(src, delta_time, given_area)
		return
	else
		current_weather_effect_type = null
		return
	SSparticle_weather.running_weather.process_mob_effect(src, delta_time)

/// Play sound for all on-map clients on a given Z-level. Good for ambient sounds.
/proc/playsound_z(z, soundin, volume = 100)
	var/sound/S = sound(soundin)
	for(var/mob/M in GLOB.player_list)
		if(M.z in z)
			M.playsound_local(get_turf(M), soundin, volume, channel = CHANNEL_Z, soundin = S)
