/datum/preference/numeric/shadowcasting_blurriness
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "shadowcasting_blurriness"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 6

/datum/preference/numeric/shadowcasting_blurriness/create_default_value()
	return 6

/datum/preference/numeric/shadowcasting_blurriness/apply_to_client_updated(client/client, value)
	if(client.mob)
		for(var/atom/movable/screen/plane_master/plane_master as anything in client.mob.hud_used.get_true_plane_masters(SHADOWCASTING_PLANE))
			plane_master.add_filter("blur", 2, gauss_blur_filter(size = value))

/datum/preference/numeric/shadowcasting_darkness
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "shadowcasting_darkness"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/shadowcasting_darkness/create_default_value()
	return 96

/datum/preference/numeric/shadowcasting_darkness/apply_to_client_updated(client/client, value)
	if(client.mob)
		for(var/atom/movable/screen/plane_master/plane_master as anything in client.mob.hud_used.get_true_plane_masters(SHADOWCASTING_PLANE))
			plane_master.alpha = value
