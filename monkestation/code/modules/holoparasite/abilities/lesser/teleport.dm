/datum/holoparasite_ability/lesser/teleport
	name = "Teleportation Pad"
	desc = "The $theme can prepare a bluespace teleportation pad, where it can then create quantum tunnels to warp things to said beacon afterwards."
	ui_icon = FA_ICON_ROCKET
	cost = 2
	thresholds = list(
		list(
			"stat" = "Potential",
			"desc" = "Reduces the cooldown for placing a bluespace beacon."
		),
		list(
			"stat" = "Potential",
			"minimum" = 4,
			"desc" = "The $theme will no longer leave behind visible bluespace tears when warping."
		),
		list(
			"stat" = "Range",
			"minimum" = 5,
			"desc" = "The $theme can warp things to a beacon located on a different Z-level."
		)
	)
	/// The placed bluespace beacon that the holoparasite can warp things to.
	var/obj/structure/receiving_pad/beacon
	/// Whether the holoparasite is currently attempting to warp something.
	var/warping = FALSE
	/// Whether the holoparasite is currently attempting to place a beacon..
	var/placing = FALSE
	/// Whether the holoparasite leaves a visible bluespace tear behind when warping.
	var/leaves_tear_behind = FALSE
	/// Whether the holoparasite can warp to a beacon on a different Z-level.
	var/cross_z_warping = TRUE
	/// If the holoparasite is in warp mode - where it will try to warp whatever it clicks on.
	var/warp_mode = FALSE
	/// The HUD button used to deploy a warp beacon.
	var/datum/action/holoparasite/teleport/deploy/deploy_action
	/// The HUD button used to warp something to the previously placed beacon.
	var/datum/action/holoparasite/teleport/warp/warp_action
	/// Cooldown for placing a bluespace beacon.
	COOLDOWN_DECLARE(deploy_cooldown)
	/// Cooldown for warping to a beacon.
	COOLDOWN_DECLARE(warp_cooldown)

/datum/holoparasite_ability/lesser/teleport/Destroy()
	. = ..()
	QDEL_NULL(beacon)

/datum/holoparasite_ability/lesser/teleport/apply()
	. = ..()
	if(QDELETED(deploy_action))
		deploy_action = new(src)
		deploy_action.ability = src
	if(QDELETED(warp_action))
		warp_action = new(src)
		warp_action.ability = src
	deploy_action.Grant(owner)
	warp_action.Grant(owner)

/datum/holoparasite_ability/lesser/teleport/remove()
	. = ..()
	if(!QDELETED(deploy_action))
		deploy_action.Remove(owner)
	if(!QDELETED(warp_action))
		warp_action.Remove(owner)

/datum/holoparasite_ability/lesser/teleport/setup_thresholds()
	. = ..()
	leaves_tear_behind = master_stats.potential < 4
	cross_z_warping = master_stats.potential >= 5

/datum/holoparasite_ability/lesser/teleport/register_signals()
	. = ..()
	RegisterSignal(owner, COMSIG_HOLOPARA_STAT, PROC_REF(on_stat))
	//RegisterSignal(owner, COMSIG_HOSTILE_ATTACKINGTARGET, PROC_REF(on_attack))

/datum/holoparasite_ability/lesser/teleport/unregister_signals()
	. = ..()
	UnregisterSignal(owner, list(COMSIG_HOLOPARA_STAT/*, COMSIG_HOSTILE_ATTACKINGTARGET*/))
/**
 * Adds cooldown info to the holoparasite's stat panel.
 */
/datum/holoparasite_ability/lesser/teleport/proc/on_stat(datum/_source, list/tab_data)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, deploy_cooldown))
		tab_data += "Beacon Deployment Cooldown: [COOLDOWN_TIMELEFT_TEXT(src, deploy_cooldown)]"
	if(!COOLDOWN_FINISHED(src, warp_cooldown))
		tab_data += "Warp Cooldown: [COOLDOWN_TIMELEFT_TEXT(src, warp_cooldown)]"

/**
 * Attempts to teleport something to the holoparasite's bluespace beacon.
 */
/datum/holoparasite_ability/lesser/teleport/proc/on_attack(datum/_source, atom/movable/target)
	SIGNAL_HANDLER
	ASSERT_ABILITY_USABILITY
	if(!warp_mode || !istype(target))
		return
	if(!owner.is_manifested())
		//to_chat(owner, span_bolddanger("<span class='danger bold'>You must be manifested to warp a target!</span>"))
		return
	if(warping)
		//to_chat(owner, span_bolddanger("<span class='danger bold'>You are already in the process of warping something!</span>"))
		return
	if(!COOLDOWN_FINISHED(src, warp_cooldown))
		//to_chat(owner, span_bolddanger("<span class='danger bold'>You must wait [COOLDOWN_TIMELEFT_TEXT(src, warp_cooldown)] before you can warp something else!</span>"))
		return
	if(!istype(beacon))
		//to_chat(owner, "<span class='danger bold'>You need a beacon placed to warp things!</span>"))
		return
	if(!owner.Adjacent(target))
		//to_chat(owner, span_bolddanger("<span class='danger bold'>You must be adjacent to the thing you wish to warp!"))
		return
	if(target.anchored)
		//to_chat(owner, span_bolddanger("You cannot warp something that is anchored to the ground!"))
		return
	// We invoke async here so we don't call do_after in a signal handler
	try_warp(target, beacon)
	return COMPONENT_HOSTILE_NO_ATTACK

/datum/holoparasite_ability/lesser/teleport/proc/try_warp(atom/movable/target, obj/structure/receiving_pad/beacon)
	set waitfor = FALSE

	warping = TRUE
	warp_action.update_all_buttons()
	var/cooldown = warp(target, beacon)
	warping = FALSE
	if(cooldown)
		warp_mode = FALSE

/**
 * Warps an atom to a bluespace beacon.
 */
/datum/holoparasite_ability/lesser/teleport/proc/warp(atom/movable/target, obj/structure/receiving_pad/beacon)
	var/turf/target_turf = get_turf(target)
	var/turf/beacon_turf = get_turf(beacon)
	// If our range isn't maxed out, then ensure that the beacon is on the same virtual Z-level as the target.
	if(!cross_z_warping && (beacon_turf.z != target_turf.z && (!is_station_level(beacon_turf.z) || !is_station_level(target_turf.z))))
		owner.balloon_alert(owner, "beacon too far away")
		return

	to_chat(owner, span_bolddanger("You begin to warp [target]..."))
	target.visible_message(span_danger("[target] starts to [COLOR_TEXT(owner.accent_color, "glow faintly")]!"), \
		span_userdanger("You start to [COLOR_TEXT(owner.accent_color, "faintly glow")], and you feel strangely weightless!"))

	owner.do_attack_animation(target)
	owner.balloon_alert_to_viewers(owner, "attempting to warp")
	if(!do_after(owner, 6 SECONDS, target, extra_checks = CALLBACK(src, PROC_REF(extra_do_after_checks), beacon)))
		owner.balloon_alert_to_viewers(owner, "warp interrupted")
		return
	owner.balloon_alert(owner, "warped successfully")
	SSblackbox.record_feedback("tally", "holoparasite_warped", 1, "[target.type]")
	new /obj/effect/temp_visual/holoparasite/phase/out(target_turf)
	if(leaves_tear_behind)
		for(var/obj/effect/holopara_bluespace_tear/bs_tear as() in list(new /obj/effect/holopara_bluespace_tear(target_turf, beacon_turf), new /obj/effect/holopara_bluespace_tear(beacon_turf, target_turf)))
			QDEL_IN(bs_tear, HOLOPARA_TELEPORT_BLUESPACE_TEAR_TIME)
			animate(bs_tear, alpha = 255, time = 1 MINUTES)
	log_game("[key_name(owner)] teleported [isliving(target) ? key_name(target) : "[target] ([target.type])"] from [AREACOORD(target_turf)] to the bluespace beacon at [AREACOORD(beacon_turf)]")
	do_teleport(target, beacon_turf, precision = 0, asoundin = 'monkestation/sound/holoparasites/telepad.ogg', asoundout = 'monkestation/sound/holoparasites/telepad.ogg', channel = TELEPORT_CHANNEL_FREE)
	new /obj/effect/temp_visual/holoparasite/phase(beacon_turf)

	// pulling this outta my ass
	var/cooldown = HOLOPARA_TELEPORT_BASE_COOLDOWN
	var/teleported_living_thing = FALSE
	if(isliving(target))
		teleported_living_thing = TRUE
	else
		for(var/thing in target.get_all_contents())
			if(isliving(thing))
				teleported_living_thing = TRUE
				break
	if(!teleported_living_thing)
		cooldown *= HOLOPARA_TELEPORT_NONLIVING_COOLDOWN_MULTIPLIER
	COOLDOWN_START(src, warp_cooldown, cooldown)
	return cooldown

/datum/holoparasite_ability/lesser/teleport/proc/extra_do_after_checks(obj/structure/receiving_pad/beacon)
	. = TRUE
	if(QDELETED(beacon) || HAS_TRAIT(owner, TRAIT_HOLOPARA_BYSTANDER))
		return FALSE
	var/turf/beacon_turf = get_turf(beacon)
	if(!beacon_turf || !isanyfloor(beacon_turf))
		return FALSE

/datum/holoparasite_ability/lesser/teleport/proc/try_place_beacon()
	placing = TRUE
	deploy_action.update_all_buttons()
	place_beacon()
	placing = FALSE
	deploy_action.update_all_buttons()
	warp_action.update_all_buttons()


/**
 * Places a bluespace beacon at the holoparasite's current location.
 */
/datum/holoparasite_ability/lesser/teleport/proc/place_beacon()
	. = TRUE
	if(!COOLDOWN_FINISHED(src, deploy_cooldown))
		owner.balloon_alert(owner, "wait [COOLDOWN_TIMELEFT_TEXT(src, deploy_cooldown)] for another beacon")
		return FALSE
	if(!owner.is_manifested())
		owner.balloon_alert(owner, "not manifested")
		return FALSE
	var/turf/target_turf = get_turf(owner)
	var/area/target_area = get_area(owner)
	if(!target_turf || !target_area || !isanyfloor(target_turf))
		owner.balloon_alert(owner, "invalid beacon location")
		return FALSE
	if(istype(target_area, /area/shuttle/supply) || is_centcom_level(target_turf.z) || is_away_level(target_turf.z) || CHECK_BITFIELD(target_area.area_flags, NOTELEPORT))
		owner.balloon_alert(owner, "invalid beacon area")
		return FALSE
	owner.balloon_alert_to_viewers(owner, "deploying beacon")
	if(!do_after(owner, 5 SECONDS, target_turf))
		owner.balloon_alert(owner, "beacon setup interrupted")
		return FALSE
	owner.visible_message(span_holoparasite("[owner.color_name] deploys a glowing beacon below [owner.p_them()]self!"), span_holoparasite("You successfully deploy a bluespace beacon!"))
	if(!QDELETED(beacon))
		QDEL_NULL(beacon)
	beacon = new(target_turf, src)
	owner.give_accent_border(beacon)
	owner.balloon_alert_to_viewers(owner, "beacon deployed")
	COOLDOWN_START(src, deploy_cooldown, HOLOPARA_TELEPORT_DEPLOY_COOLDOWN)
	deploy_action.begin_timer(HOLOPARA_TELEPORT_DEPLOY_COOLDOWN)
	var/datum/space_level/target_z_level = SSmapping.get_level(target_turf.z)
	SSblackbox.record_feedback("associative", "holoparasite_beacons", 1, list(
		"map" = SSmapping.config.map_name,
		"area" = "[target_area.name]",
		"x" = target_turf.x,
		"y" = target_turf.y,
		"z" = target_turf.z,
		"z_name" = target_z_level?.name
	))

/datum/action/holoparasite/teleport
	var/datum/holoparasite_ability/lesser/teleport/ability

/datum/action/holoparasite/teleport/warp
	name = "Enable Warping"
	desc = "Attempt to warp the next thing you click on to your bluespace beacon."
	button_icon_state = "warp:toggle"
	can_toggle = TRUE
	var/static/disable_name = "Disable Warping"
	var/static/disable_desc = "Stop trying to warp whatever you click on, returning to normal interactions."
	var/static/disable_icon = "cancel"

/datum/action/holoparasite/teleport/warp/update_button_name(atom/movable/screen/movable/action_button/button, force = FALSE)
	. = ..()
	button.name = ability.warp_mode ? disable_name : initial(name)
	button.desc = ability.warp_mode ? disable_desc : initial(desc)

/datum/action/holoparasite/teleport/warp/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	button_icon_state = (ability.warp_mode && !ability.warping) ? disable_icon : initial(button_icon_state)
	return ..()

/datum/action/holoparasite/teleport/warp/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	if(!COOLDOWN_FINISHED(ability, warp_cooldown))
		ability.warp_mode = FALSE
		begin_timer(COOLDOWN_TIMELEFT(ability, warp_cooldown))
		update_all_buttons()
		return
	if(ability.warping)
		return
	ability.warp_mode = !ability.warp_mode
	to_chat(owner, span_holoparasite(span_notice("You [ability.warp_mode ? "enable" : "disable"] warping.")))

/datum/action/holoparasite/teleport/warp/in_use()
	return ability.warping

/datum/action/holoparasite/teleport/warp/activated()
	return ability.warp_mode

/datum/action/holoparasite/teleport/warp/should_be_transparent()
	return ..() || QDELETED(ability.beacon)

/datum/action/holoparasite/teleport/deploy
	name = "Deploy Beacon"
	desc = "Deploys a bluespace beacon, allowing you to warp things to it later."
	button_icon_state = "warp:place"

/datum/action/holoparasite/teleport/deploy/Trigger(trigger_flags)
	. = ..()
	if(!. || ability.placing)
		return FALSE
	ability.try_place_beacon()

/datum/action/holoparasite/teleport/deploy/in_use()
	return ability.placing

// the pad
/obj/structure/receiving_pad
	name = "bluespace receiving pad"
	desc = "A receiving zone for bluespace teleportations."
	icon = 'monkestation/icons/mob/holoparasite.dmi'
	icon_state = "telepad"
	light_outer_range = MINIMUM_USEFUL_LIGHT_RANGE
	density = FALSE
	anchored = TRUE
	layer = ABOVE_OPEN_TURF_LAYER
	/// The holoparasite ability that created this beacon.
	var/datum/holoparasite_ability/lesser/teleport/ability

/obj/structure/receiving_pad/Initialize(mapload, datum/holoparasite_ability/lesser/teleport/_ability)
	. = ..()
	if(!istype(_ability))
		stack_trace("Attempted to initialize holoparasite beacon without associated ability reference!")
		return INITIALIZE_HINT_QDEL
	ability = _ability
	var/image/silicon_image = image(icon = 'monkestation/icons/mob/holoparasite.dmi', icon_state = null, loc = src)
	silicon_image.override = TRUE
	//add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "holopara_warp_pad", silicon_image)

/obj/structure/receiving_pad/Destroy()
	cut_overlays()
	// Unset the ability's beacon ref (provided that ref still points to us)
	if(ability.beacon == src)
		ability.beacon = null
	return ..()

/obj/structure/receiving_pad/proc/disappear()
	visible_message(span_warning("[src] vanishes!"))
	qdel(src)

/obj/effect/holopara_bluespace_tear
	name = "bluespace tear"
	icon_state = "bluestream_fade"
	alpha = 0
	var/turf/destination

/obj/effect/holopara_bluespace_tear/Initialize(mapload, turf/_destination)
	. = ..()
	if(istype(_destination))
		destination = _destination

/obj/effect/holopara_bluespace_tear/attack_hand(mob/living/carbon/user)
	if(!istype(user) || !user.has_trauma_type(/datum/brain_trauma/special/bluespace_prophet))
		to_chat(user, span_warning("You peer into the \the [src], quickly realizing that you have absolutely no clue whatsoever how to navigate through it..."))
		return
	if(!istype(destination) || QDELETED(destination))
		to_chat(user, span_warning("There doesn't seem to be anything on the other side of \the [src]..."))
		return
	user.visible_message(span_notice("[user] begins to effortlessly climb into \the [src], navigating through the tear with unnatural familarity!</span>"), \
		span_notice("You begin to crawl into \the [src], fully understanding the complex path through bluespace, despite it being incomprehensible to most..."))
	if(!do_after(user, 1.5 SECONDS, src, extra_checks = CALLBACK(src, PROC_REF(_bluespace_tear_crawl_check), user)))
		user.visible_message(span_warning("[user] backs out of \the [src]!"), span_warning("You were interrupted while trying to navigate \the [src]!"))
		return
	user.visible_message(span_warning("[user] fully crawls into \the [src], disappearing from view!"), \
		span_notice("You crawl into \the [src], effortlessly navigating through the bluespace tunnels, and come out on the other side..."))
	playsound(user, 'sound/magic/wand_teleport.ogg', vol = 75, vary = TRUE)
	do_teleport(user, destination, precision = 0, channel = TELEPORT_CHANNEL_QUANTUM)

/obj/effect/holopara_bluespace_tear/proc/_bluespace_tear_crawl_check(mob/living/carbon/user)
	return istype(user) && istype(destination) && !QDELETED(destination) && user.has_trauma_type(/datum/brain_trauma/special/bluespace_prophet)
