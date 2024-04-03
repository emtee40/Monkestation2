
/datum/anvil_challenge
	/// When the ui minigame phase started
	var/start_time
	/// Is it finished (either by win/lose or window closing)
	var/completed = FALSE
	///the smithing mob
	var/mob/user
	/// Background icon state from anvil_game.dmi
	var/background = "background_default"
	/// list of the clicks needed aswell as the world timings
	var/list/anvil_presses = list()
	/// A secondary list of our notes with how many pixels they have moved
	var/list/note_pixels_moved = list()
	///The background as shown in the minigame, and the holder of the other visual overlays
	var/atom/movable/screen/anvil_hud/anvil_hud
	///the output portion of the anvil
	var/datum/anvil_recipe/selected_recipe
	///our anvil object
	var/obj/structure/anvil/host_anvil
	///the difficulty of the recipe
	var/difficulty = 1
	///overall success
	var/success = 100
	///our total off time
	var/off_time = 0
	///our notes left to make
	var/notes_left = 0
	///our total notes
	var/total_notes = 0
	///failed notes
	var/failed_notes = 0
	///do we debug?
	var/debug = FALSE

/datum/anvil_challenge/New(obj/structure/anvil/anvil, datum/anvil_recipe/end_product_recipe, mob/user)
	host_anvil = anvil
	src.user = user
	selected_recipe = end_product_recipe

	//RegisterSignal(host_anvil, COMSIG_QDELETING, PROC_REF(on_anvil_deletion))

	notes_left = end_product_recipe.total_notes
	total_notes = end_product_recipe.total_notes

	generate_anvil_beats(TRUE)

	if(!user.client || user.incapacitated())
		return FALSE
	. = TRUE
	anvil_hud = new
	anvil_hud.prepare_minigame(src, anvil_presses)

	RegisterSignal(user.client, COMSIG_CLIENT_CLICK, PROC_REF(check_click))

	START_PROCESSING(SSfishing, src)

/datum/anvil_challenge/proc/generate_anvil_beats(init = FALSE)
	var/list/new_notes = list()

	var/last_note_time = world.time
	for(var/i = 1 to min(rand(1,3), notes_left))
		notes_left--
		var/atom/movable/screen/hud_note/hud_note = new(null, null, src)
		hud_note.generate_click_type()
		hud_note.pixel_x += 40 // we start 40 units back and move towards the end
		anvil_presses += hud_note
		anvil_presses[hud_note] = last_note_time + (1 SECONDS / difficulty)
		if(debug)
			hud_note.maptext = "[last_note_time + (1 SECONDS / difficulty)] - 75"
		last_note_time += (1 SECONDS / difficulty)
		note_pixels_moved += hud_note
		note_pixels_moved[hud_note] = 0
		new_notes |= hud_note

	if(!init)
		anvil_hud.add_notes(new_notes)

/datum/anvil_challenge/proc/check_click(datum/source, atom/target, atom/location, control, params, mob/user)
	var/atom/movable/screen/hud_note/choice = anvil_presses[1]
	var/upper_range = anvil_presses[choice] + 0.4 SECONDS
	var/lower_range = anvil_presses[choice] - 0.4 SECONDS

	var/list/modifiers = params2list(params)

	//oh yea we making it out of the shitcode with this one.
	var/list/click_list = list()
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		click_list |= RIGHT_CLICK
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		click_list |= LEFT_CLICK
	if(LAZYACCESS(modifiers, ALT_CLICK))
		click_list |= ALT_CLICK
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		click_list |= SHIFT_CLICK


	if(!choice.check_click(click_list))
		failed_notes++
	else
		if((world.time > lower_range) && (world.time < upper_range))
			anvil_presses -= anvil_presses[choice]
			user.balloon_alert(user, "Great Hit!")
			playsound(host_anvil, 'monkestation/code/modules/smithing/sounds/forge.ogg', 25, TRUE, mixer_channel = CHANNEL_SOUND_EFFECTS)

		else
			if(world.time > anvil_presses[choice] + 0.4 SECONDS)
				off_time += world.time - (anvil_presses[choice] + 0.4 SECONDS)
				failed_notes++
			else if(world.time < anvil_presses[choice] - 0.4 SECONDS)
				off_time += (anvil_presses[choice] + 0.4 SECONDS) - world.time
				failed_notes++

	anvil_presses -= choice
	note_pixels_moved -= choice
	anvil_hud.pop_note(choice)
	if(!length(anvil_presses))
		if(!notes_left)
			end_minigame()
		else
			generate_anvil_beats()
	return FALSE

/datum/anvil_challenge/proc/end_minigame()
	UnregisterSignal(user.client, COMSIG_CLIENT_CLICK)
	STOP_PROCESSING(SSfishing, src)
	anvil_presses = null
	note_pixels_moved = null
	anvil_hud.end_minigame()
	QDEL_NULL(anvil_hud)
	host_anvil.smithing = FALSE
	host_anvil.generate_item(success)
	host_anvil = null

/datum/anvil_challenge/process(seconds_per_tick)
	move_notes()

///we have to move 80 units over the span of the notes world.time
/datum/anvil_challenge/proc/move_notes()
	for(var/atom/movable/screen/hud_note as anything in anvil_presses)
		var/movement_left = 75 - note_pixels_moved[hud_note]
		if(movement_left <= 0)
			hud_note.alpha -= min(15, hud_note.alpha)
			continue
		var/time_left = max(anvil_presses[hud_note] - world.time , 1)
		var/estimated_movement = round(movement_left / time_left , 0.1)
		if(debug)
			hud_note.maptext = "[anvil_presses[hud_note]] - [movement_left]"
		hud_note.pixel_x -= estimated_movement
		note_pixels_moved[hud_note] += estimated_movement

///The screen object which bait, fish, and completion bar are visually attached to.
/atom/movable/screen/anvil_hud
	icon = 'monkestation/code/modules/smithing/icons/anvil_hud.dmi'
	screen_loc = "CENTER:8,CENTER+2:2"
	name = "anvil minigame"
	appearance_flags = APPEARANCE_UI|KEEP_TOGETHER
	alpha = 230
	var/list/cached_notes = list()

///Initialize stuff
/atom/movable/screen/anvil_hud/proc/prepare_minigame(datum/anvil_challenge/challenge, list/notes)
	icon_state = challenge.background
	add_overlay("frame")
	add_notes(notes)
	challenge.user.client.screen += src

/atom/movable/screen/anvil_hud/proc/end_minigame()
	QDEL_LIST(cached_notes)

/atom/movable/screen/anvil_hud/proc/add_notes(list/notes)
	for(var/atom/movable/screen/hud_note/note as anything in notes)
		cached_notes += note
		vis_contents += note

/atom/movable/screen/anvil_hud/proc/pop_note(atom/movable/screen/hud_note/note)
	vis_contents -= note
	cached_notes -= note
	qdel(note)

/atom/movable/screen/hud_note
	icon = 'monkestation/code/modules/smithing/icons/anvil_hud.dmi'
	icon_state = "note"
	vis_flags = VIS_INHERIT_ID
	var/list/click_requirements = list()

/atom/movable/screen/hud_note/proc/generate_click_type()
	switch(rand(1,2))
		if(1)
			click_requirements = list(LEFT_CLICK)
		if(2)
			click_requirements = list(RIGHT_CLICK)
			icon_state = "note-right"
		/*
		if(3)
			click_requirements = list(LEFT_CLICK, ALT_CLICK)
		if(4)
			click_requirements = list(RIGHT_CLICK, ALT_CLICK)
		if(5)
			click_requirements = list(LEFT_CLICK, SHIFT_CLICK)
		if(6)
			click_requirements = list(RIGHT_CLICK, SHIFT_CLICK)
		*/

/atom/movable/screen/hud_note/proc/check_click(list/click_modifiers)
	var/list/copied_checks = click_requirements
	for(var/item in copied_checks)
		if(item in click_modifiers)
			copied_checks -= item
		if(!length(copied_checks))
			return TRUE
	return FALSE
