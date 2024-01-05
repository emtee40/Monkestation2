/datum/action/holoparasite
	button_icon = 'monkestation/icons/mob/holoparasite.dmi'
	background_icon_state = "bg_holoparasite"

/datum/action/innate/holoparasite
	button_icon = 'monkestation/icons/mob/holoparasite.dmi'
	background_icon_state = "bg_holoparasite"

/datum/action/cooldown/holoparasite
	button_icon = 'monkestation/icons/mob/holoparasite.dmi'
	background_icon_state = "bg_holoparasite"

// Holoparasites do lots of funky things, so they get their own special snowflake action behavior.
/datum/action/holoparasite
	button_icon = 'monkestation/icons/mob/holoparasite.dmi'
	background_icon = null
	background_icon_state = null
	var/can_toggle = FALSE
	var/list/accent_overlay_states
	var/list/mutable_appearance/accent_overlays
	var/mutable_appearance/toggle_overlay
	var/timer_length
	var/static/list/mutable_appearance/timer_fraction_overlays
	COOLDOWN_DECLARE(timer)

/datum/action/holoparasite/New(Target)
	. = ..()
	if(!timer_fraction_overlays)
		timer_fraction_overlays = list(
			"tbd" = mutable_appearance('monkestation/icons/hud/cooldown.dmi', "second", alpha = 180, appearance_flags = APPEARANCE_UI_IGNORE_ALPHA)
		)
		for(var/fraction in 1 to 9)
			timer_fraction_overlays["[fraction]"] = mutable_appearance('monkestation/icons/hud/cooldown.dmi', "second.[fraction]", alpha = 180, appearance_flags = APPEARANCE_UI_IGNORE_ALPHA)

/datum/action/holoparasite/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/action/holoparasite/Grant(mob/living/basic/holoparasite/grant_to)
	if(!istype(grant_to))
		Remove(owner)
		stack_trace("Attempted to grant a holoparasite action to non-holoparasite [grant_to] ([grant_to?.type])")
		return
	if(can_toggle)
		toggle_overlay = mutable_appearance('monkestation/icons/mob/holoparasite.dmi', "selected", appearance_flags = APPEARANCE_UI)
		toggle_overlay.color = grant_to.accent_color
	for(var/overlay_state in accent_overlay_states)
		var/mutable_appearance/overlay = mutable_appearance('monkestation/icons/mob/holoparasite.dmi', overlay_state, appearance_flags = APPEARANCE_UI)
		overlay.color = grant_to.accent_color
		LAZYADD(accent_overlays, overlay)
	RegisterSignal(grant_to, COMSIG_HOLOPARA_SET_ACCENT_COLOR, PROC_REF(on_set_accent_color))
	RegisterSignal(grant_to, list(COMSIG_HOLOPARA_POST_MANIFEST, COMSIG_HOLOPARA_RECALL, COMSIG_MOVABLE_MOVED), PROC_REF(update_all_buttons))
	return ..()

/datum/action/holoparasite/Remove(mob/remove_from)
	. = ..()
	UnregisterSignal(remove_from, list(COMSIG_HOLOPARA_SET_ACCENT_COLOR, COMSIG_HOLOPARA_POST_MANIFEST, COMSIG_HOLOPARA_RECALL, COMSIG_MOVABLE_MOVED))

/datum/action/holoparasite/apply_button_overlay(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	current_button.cut_overlays()
	for(var/mutable_appearance/overlay as() in accent_overlays)
		current_button.add_overlay(overlay)
	if(activated() && toggle_overlay)
		current_button.add_overlay(toggle_overlay)
	if(timer && !COOLDOWN_FINISHED(src, timer))
		current_button.maptext = "<center><span class='chatOverhead' style='font-weight: bold;color: #eeeeee;'>[FLOOR(COOLDOWN_TIMELEFT(src, timer) * 0.1, 1)]s</span></center>"
	else
		current_button.maptext = ""

/datum/action/holoparasite/create_button()
	var/atom/movable/screen/movable/action_button/button = ..()
	button.maptext = ""
	button.maptext_width = 64
	button.maptext_height = 64
	button.maptext_x = -16
	button.maptext_y = 2
	return button

/datum/action/holoparasite/process(seconds_per_tick)
	update_all_buttons()
	if(!timer || COOLDOWN_FINISHED(src, timer))
		stop_timer()
		return PROCESS_KILL

/**
 * Wrapper for updating all the buttons.
 * Can be used as a signal handler, as no args are passed through to [build_all_button_icons].
 */
/datum/action/holoparasite/proc/update_all_buttons()
	SIGNAL_HANDLER
	build_all_button_icons(update_flags = ALL)

/**
 * Begins the timer, starting up the text+progress overlay.
 */
/datum/action/holoparasite/proc/begin_timer(length)
	timer_length = length
	COOLDOWN_START(src, timer, length)
	update_all_buttons()
	START_PROCESSING(SSfastprocess, src)

/**
 * Stops the timer, disposing of the text overlay, stopping processing, and redoing the overlays.
 */
/datum/action/holoparasite/proc/stop_timer()
	COOLDOWN_RESET(src, timer)
	timer_length = 0
	update_all_buttons()
	STOP_PROCESSING(SSfastprocess, src)

/datum/action/holoparasite/proc/on_set_accent_color(datum/_source, _old_accent_color, new_accent_color)
	SIGNAL_HANDLER
	if(toggle_overlay)
		toggle_overlay.color = new_accent_color
	for(var/mutable_appearance/overlay as() in accent_overlays)
		overlay.color = new_accent_color
	update_all_buttons()

/**
 * Get the text content to display in the tooltip, like, a description.
 */
/datum/action/holoparasite/proc/tooltip_content()
	return desc

/**
 * Whether a toggleable action is currently activated or not.
 */
/datum/action/holoparasite/proc/activated()
	return FALSE

/**
 * Whether the action is currently 'in use' or not.
 */
/datum/action/holoparasite/proc/in_use()
	return FALSE

/**
 * A list of accent overlays to apply to the HUD.
 */
/datum/action/holoparasite/proc/accent_overlays()
	return accent_overlays

/**
 * The timer overlay to apply to the HUD.
 */
/datum/action/holoparasite/proc/timer_overlay()
	if(in_use())
		return timer_fraction_overlays["tbd"]
	if(!timer || !timer_length)
		return
	return timer_fraction_overlays["[10 - clamp(round((COOLDOWN_TIMELEFT(src, timer) / timer_length) * 10), 1, 9)]"]

/**
 * Return TRUE if the HUD button should be transparent, like if it's on cooldown or something.
 */
/datum/action/holoparasite/proc/should_be_transparent()
	return !isnull(timer_overlay())


