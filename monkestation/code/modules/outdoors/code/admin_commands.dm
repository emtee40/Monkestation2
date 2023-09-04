/client/proc/run_particle_weather()
	set category = "Admin.Events"
	set name = "Run Particle Weather"
	set desc = "Triggers a particle weather"

	if(!holder)
		return

	var/weather_type = input("Choose a weather", "Weather")  as null|anything in sort_list(subtypesof(/datum/particle_weather), /proc/cmp_typepaths_asc)
	if(!weather_type)
		return

	SSparticle_weather.run_weather(new weather_type(), TRUE)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type].")
	log_admin("[key_name(usr)] started weather of type [weather_type].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Run Particle Weather")

/client/proc/run_area_particle_weather()
	set category = "Admin.Events"
	set name = "Run Area Particle Weather"
	set desc = "Triggers an area particle weather"

	if(!holder)
		return

	var/weather_type = input("Choose a weather", "Weather")  as null|anything in sort_list(subtypesof(/datum/particle_weather), /proc/cmp_typepaths_asc)
	var/selected_area = tgui_input_list(usr, "Cheese an area", "Weather", sort_list(GLOB.areas))
	if(!weather_type || !area_type)
		return

	SSparticle_weather.add_area_weather(new weather_type(), selected_area)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type].")
	log_admin("[key_name(usr)] started weather of type [weather_type].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Run Particle Weather")
