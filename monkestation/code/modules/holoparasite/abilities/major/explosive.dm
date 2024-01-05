#define UNREGISTER_BOMB_SIGNALS(A) \
	do { \
		UnregisterSignal(A, boom_signals); \
		UnregisterSignal(A, list(COMSIG_ATOM_EXAMINE, COMSIG_PREQDELETED)); \
	} while (0)

/datum/holoparasite_ability/major/explosive
	name = "Explosive"
	desc = "The $theme can, with a single touch, turn any inanimate object into a bomb."
	ui_icon = FA_ICON_BOMB
	cost = 4
	thresholds = list(
		list(
			"stat" = "Potential",
			"desc" = "Reduces the cooldown between manually detonating bombs."
		),
		list(
			"stat" = "Range",
			"desc" = "Reduces the cooldown between arming bombs."
		)
	)
	/// How long the holoparasite must wait between arming bombs.
	var/arming_cooldown_length
	/// How long the holoparasite must wait between manual detonations.
	var/detonate_cooldown_length
	/// A list of items currently armed as bombs by this holoparasite.
	var/list/bombs = list()
	/// An associated list of which bombs have which disarm timers.
	var/list/bomb_disarm_timers = list()
	/// Whether the holoparasite is currently attempting to arm a bomb or not.
	var/arming = FALSE
	/// The HUD button used to toggle arming mode.
	var/datum/action/holoparasite/explosive/arm/arm_hud
	/// The HUD button used to manually detonate bombs.
	var/datum/action/holoparasite/explosive/detonate/detonate_hud
	/**
	 * A typecache of objects which may not be turned into bombs.
	 * This mostly consists of things that are more likely to be misclicked than be intentionally armed,
	 * or could potentially be way too unfair to be a bomb.
	 */
	var/static/list/forbidden_typecache
	/// A list of signals which will trigger a bomb detonation.
	var/static/list/boom_signals = list(
		COMSIG_PARENT_ATTACKBY,
		COMSIG_ATOM_BUMPED,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_ATOM_ATTACK_PAW,
		COMSIG_ATOM_ATTACK_ANIMAL
	)
	/// The cooldown for arming bombs.
	COOLDOWN_DECLARE(arming_cooldown)
	/// The cooldown for manually detonating bombs.
	COOLDOWN_DECLARE(detonate_cooldown)

/datum/holoparasite_ability/major/explosive/New(datum/holoparasite_stats/master_stats)
	. = ..()
	if(!forbidden_typecache)
		forbidden_typecache = typecacheof(list(
			/obj/anomaly,
			/obj/effect,
			/obj/eldritch,
			/obj/item/cigbutt,
			/obj/item/disk/nuclear,
			/obj/item/grenade,
			/obj/item/paper,
			/obj/item/paper_bin,
			/obj/item/pen,
			/obj/item/reagent_containers,
			/obj/item/stack/cable_coil,
			/obj/item/stack/tile,
			/obj/item/trash,
			/obj/item/wallframe,
			/obj/machinery/atmospherics,
			/obj/machinery/disposal,
			/obj/machinery/holopad,
			/obj/machinery/power,
			/obj/machinery/syndicatebomb,
			/obj/structure/cable,
			/obj/structure/chair,
			/obj/structure/disposalpipe,
			/obj/structure/rack,
			/obj/structure/sign,
			/obj/structure/table
		)) | GLOB.WALLITEMS_INTERIOR | GLOB.WALLITEMS_EXTERIOR

/datum/holoparasite_ability/major/explosive/Destroy()
	. = ..()
	QDEL_NULL(arm_hud)
	QDEL_NULL(detonate_hud)

/datum/holoparasite_ability/major/explosive/setup_thresholds()
	. = ..()
	arming_cooldown_length = HOLOPARA_BASE_ARM_COOLDOWN / master_stats.range
	detonate_cooldown_length = HOLOPARA_BASE_DETONATE_COOLDOWN / master_stats.potential

/datum/holoparasite_ability/major/explosive/register_signals()
	. = ..()
	RegisterSignal(owner, COMSIG_HOLOPARA_SETUP_HUD, PROC_REF(on_hud_setup))
	RegisterSignal(owner, COMSIG_HOSTILE_ATTACKINGTARGET, PROC_REF(on_attack))

/datum/holoparasite_ability/major/explosive/unregister_signals()
	. = ..()
	UnregisterSignal(owner, list(COMSIG_HOLOPARA_SETUP_HUD, COMSIG_HOSTILE_ATTACKINGTARGET))


/**
 * Handles attacking a mob, for the random explosive attack.
 */
/datum/holoparasite_ability/major/explosive/proc/on_attack(datum/_source, atom/movable/target)
	SIGNAL_HANDLER
	ASSERT_ABILITY_USABILITY_SILENT
	if(!istype(target))
		return
	if(arming && isobj(target))
		try_arm_bomb(target)
		return COMPONENT_HOSTILE_NO_ATTACK
	if(prob(40) && isliving(target) && !target.anchored && !owner.has_matching_summoner(target))
		new /obj/effect/temp_visual/holoparasite/phase/out(get_turf(target))
		new /obj/effect/temp_visual/explosion(get_turf(target))
		target.visible_message(span_danger("[owner.color_name] hits [span_name("[target]")] with an explosive punch!"), \
			"<span class='userdanger'>[owner.color_name]'s punch explodes violently, ripping you through space!</span>", \
			vision_distance = COMBAT_MESSAGE_RANGE
		)
		var/old_turf = get_turf(target)
		do_teleport(target, target, precision = 10, channel = TELEPORT_CHANNEL_WORMHOLE)
		var/distance_flung = get_dist(old_turf, get_turf(target))
		target.log_message("was flung [distance_flung] tiles by an explosive punch from [key_name(owner)]", LOG_ATTACK)
		owner.log_message("flung [key_name(target)] [distance_flung] tiles with an explosive punch", LOG_ATTACK, log_globally = FALSE)
		new /obj/effect/temp_visual/holoparasite/phase(get_turf(target))
		for(var/mob/living/collateral in hearers(1, target))
			if(owner.has_matching_summoner(collateral))
				continue
			to_chat(collateral, span_userdanger("The shockwave from [owner.color_name]'s explosive punch hits you, injuring you!"))
			collateral.take_overall_damage(brute = rand(10, 15), stamina = rand(5, 15))
			collateral.log_message("was hit by collateral damage from [key_name(owner)] attacking [key_name(target)]", LOG_ATTACK)
			owner.log_message("dealt collateral damage to [key_name(collateral)] while attacking [key_name(target)]", LOG_ATTACK, log_globally = FALSE)

/**
 * Handles alt-clicking on an object, in order to arm it as a bomb.
 */
/datum/holoparasite_ability/major/explosive/proc/try_arm_bomb(obj/target)
	SIGNAL_HANDLER
	ASSERT_ABILITY_USABILITY
	if(!istype(target) || !owner.Adjacent(target))
		return
	if(!owner.is_manifested())
		owner.balloon_alert(owner, "failed, must be manifested")
		return
	if(!COOLDOWN_FINISHED(src, arming_cooldown))
		owner.balloon_alert(owner, "failed, cooldown")
		arming = FALSE
		return
	if(!isturf(target.loc))
		owner.balloon_alert(owner, "failed, bomb must be on ground")
		return
	if(is_type_in_typecache(target, forbidden_typecache))
		owner.balloon_alert(owner, "failed, invalid bomb target")
		return
	SSblackbox.record_feedback("tally", "holoparasite_bombs", 1, "[target.type]")
	target.balloon_alert(owner, "bomb armed")
	owner.log_message("rigged a bomb ([target.name] | [target.type]) at [AREACOORD(target.loc)]", LOG_ATTACK)
	arming = FALSE
	COOLDOWN_START(src, arming_cooldown, arming_cooldown_length)
	arm_hud.begin_timer(arming_cooldown_length)
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(display_examine))
	RegisterSignal(target, COMSIG_PARENT_PREQDELETED, PROC_REF(on_bomb_destroyed))
	RegisterSignals(target, boom_signals, PROC_REF(kaboom))
	bomb_disarm_timers[target] = addtimer(CALLBACK(src, PROC_REF(disable), target), master_stats.potential * 18 * 10, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)
	bombs += target

/datum/holoparasite_ability/major/explosive/proc/on_bomb_destroyed(obj/source)
	SIGNAL_HANDLER
	disable(source, result = "destroyed")

/**
 * Allows the holoparasite to manually detonate a bomb.
 */
/datum/holoparasite_ability/major/explosive/proc/manual_kaboom()
	. = TRUE
	var/list/bomb_names = list()
	var/list/bomb_assoc = list()
	var/max_time_left = 0
	if(!length(bombs))
		to_chat(owner, "<span class='warning'>You have no bombs to detonate!</span>")
		owner.balloon_alert(owner, "failed, no bombs armed")
		return FALSE
	if(!COOLDOWN_FINISHED(src, detonate_cooldown))
		to_chat(owner, "<span class='danger bold'>Your powers are on cooldown! You must wait [COOLDOWN_TIMELEFT_TEXT(src, detonate_cooldown)] before you can manually detonate another bomb!</span>")
		owner.balloon_alert(owner, "failed, cooldown")
		return FALSE
	for(var/obj/bomb as() in bombs)
		if(QDELETED(bomb))
			bombs -= bomb
			bomb_disarm_timers -= bomb
			continue
		var/area/bomb_area = get_area(bomb)
		var/bomb_dist = get_dist(get_turf(owner), get_turf(bomb))
		var/bomb_name = avoid_assoc_duplicate_keys("[bomb.name] @ [bomb_area.name] \[[bomb_dist] tiles away\]", bomb_names)
		max_time_left = max(max_time_left, timeleft(bomb_disarm_timers[bomb]))
		bomb_assoc[bomb_name] = bomb
	var/chosen_bomb = tgui_input_list(owner, "Choose a bomb to manually detonate", "Bomb Detonation", bomb_assoc, timeout = max_time_left - 1)
	if(!chosen_bomb || !bomb_assoc[chosen_bomb])
		return FALSE
	var/obj/bomb = bomb_assoc[chosen_bomb]
	if(QDELETED(bomb))
		owner.balloon_alert(owner, "failed, bomb destroyed")
		bombs -= bomb
		bomb_disarm_timers -= bomb
		return FALSE
	if(!(bomb in bombs))
		owner.balloon_alert(owner, "failed, bomb disarmed")
		return FALSE
	if(trying_to_do_stupid_cheesy_instakill(bomb))
		owner.balloon_alert(owner, "failed to detonate")
		return FALSE
	owner.log_message("manually detonated the bomb trap ([bomb.name] | [bomb.type]) at [AREACOORD(bomb.loc)]", LOG_ATTACK)
	owner.balloon_alert(owner, "bomb detonated")
	bomb.visible_message(span_bolddanger("[bomb] suddenly and violently explodes!"))
	disable(bomb, silent = TRUE, result = "manual detonation")
	explosion(bomb, 0, 1, 0, 5, flame_range = 3)
	COOLDOWN_START(src, detonate_cooldown, detonate_cooldown_length)
	detonate_hud.begin_timer(detonate_cooldown_length)

/**
 * Detonates a holoparasite bomb.
 */
/datum/holoparasite_ability/major/explosive/proc/kaboom(obj/source, mob/living/explodee)
	SIGNAL_HANDLER
	if(!istype(source) || !istype(explodee) || owner.has_matching_summoner(explodee) || trying_to_do_stupid_cheesy_instakill(source))
		return
	to_chat(explodee, span_bolddanger("[source] was boobytrapped!"))
	to_chat(owner, span_bolddanger("Success! Your trap caught [span_name("[explodee]")]!"))
	var/turf/target_turf = get_turf(source)
	explodee.log_message("was caught by a bomb trap ([source.name] | [source.type]) set by [key_name(owner)] at [AREACOORD(target_turf)]", LOG_ATTACK)
	owner.log_message("caught [key_name(explodee)] with a bomb trap ([source.name] | [source.type]) at [AREACOORD(target_turf)]", LOG_ATTACK, log_globally = FALSE)
	playsound(target_turf, "explosion", vol = 200, vary = TRUE)
	new /obj/effect/temp_visual/explosion(target_turf)
	EX_ACT(explodee, EXPLODE_HEAVY)
	disable(source, silent = TRUE, result = "success")

/**
 * Disables a holoparasite bomb.
 */
/datum/holoparasite_ability/major/explosive/proc/disable(obj/bomb, silent = FALSE, result = "expired")
	if(!(bomb in bombs)) // Seems it was already detonated!
		return
	if(!silent)
		to_chat(src, span_bolddanger("Failure! Your trap didn't catch anyone this time."))
	deltimer(bomb_disarm_timers[bomb])
	bomb_disarm_timers -= bomb
	bombs -= bomb
	if(!QDELETED(bomb))
		UNREGISTER_BOMB_SIGNALS(bomb)
		if(result)
			SSblackbox.record_feedback("associative", "holoparasite_bomb_result", 1, list(
				"type" = "[bomb.type]",
				"result" = result
			))

/**
 * Checks to see if a bomb is on someone's head slot or not.
 * This is so you can't do the stupid cheesy insta-kill by throwing a booby-trapped hat on someone's head, then detonating it.
 * Also prevents embedded objects and applied cuffs from being detonated, too, so you can't just work around this with bolas or syndie cards.
 */
/datum/holoparasite_ability/major/explosive/proc/trying_to_do_stupid_cheesy_instakill(obj/item/bomb)
	. = FALSE
	if(!istype(bomb))
		return
	var/mob/living/wearer = bomb.loc
	if(!istype(wearer))
		return
	if(iscarbon(wearer))
		var/mob/living/carbon/carbon_wearer = wearer
		if(carbon_wearer.handcuffed == bomb || carbon_wearer.legcuffed == bomb)
			return TRUE
		for(var/obj/item/bodypart/bodypart as() in carbon_wearer.bodyparts)
			if(bomb in bodypart.embedded_objects)
				return TRUE
	return wearer.get_item_by_slot(ITEM_SLOT_HEAD) == bomb

/**
 * Adds a unique examine text to holoparasite bombs.
 */
/datum/holoparasite_ability/major/explosive/proc/display_examine(datum/_source, mob/user, text)
	SIGNAL_HANDLER
	text += "<span class='holoparasite'>It glows with a [COLOR_TEXT(owner.accent_color, "strange light")]!</span>"

/datum/action/holoparasite/explosive
	var/datum/holoparasite_ability/major/explosive/ability

/datum/action/holoparasite/explosive/detonate
	name = "Detonate Bomb"
	desc = "Manually detonate an armed bomb trap."
	icon_state = "explode"

/datum/action/holoparasite/explosive/detonate/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	ability.manual_kaboom()
	update_all_buttons()

/datum/action/holoparasite/explosive/detonate/tooltip_content()
	. = ..()
	. += "<br>You must wait <b>[DisplayTimeText(ability.detonate_cooldown_length)]</b> between manually detonating bombs."
	if(!length(ability.bombs))
		. += "<br><b>You have no bombs to detonate!</b>"

/datum/action/holoparasite/explosive/arm
	name = "Arm Bomb"
	desc = "Attempt to arm the next thing you click on as a bomb"
	icon_state = "explosive-arm"
	can_toggle = TRUE
	accent_overlay_states = list("explosive-arm-accent")
	var/static/disable_name = "Stop Arming Bomb"
	var/static/disable_desc = "Stop trying to arm whatever you click on, returning to normal interactions."
	var/static/disable_icon = "cancel"

/datum/action/holoparasite/explosive/arm/update_name(updates)
	name = ability.arming ? disable_name : initial(name)
	return ..()

/datum/action/holoparasite/explosive/arm/update_desc(updates)
	desc = ability.arming ? disable_desc : initial(desc)
	return ..()

/datum/action/holoparasite/explosive/arm/update_icon_state()
	icon_state = ability.arming ? disable_icon : initial(icon_state)
	return ..()

/datum/action/holoparasite/explosive/arm/accent_overlays()
	if(!ability.arming)
		return ..()

/datum/action/holoparasite/explosive/arm/tooltip_content()
	. = ..()
	. += "<br>You must wait <b>[DisplayTimeText(ability.arming_cooldown_length)]</b> between arming bombs."

/datum/action/holoparasite/explosive/arm/activated()
	return ability.arming

/datum/action/holoparasite/explosive/arm/Click(location, control, params)
	if(!COOLDOWN_FINISHED(ability, arming_cooldown))
		begin_timer(COOLDOWN_TIMELEFT(ability, arming_cooldown))
		update_appearance()
		return
	ability.arming = !ability.arming
	to_chat(owner, "<span class='notice holoparasite'>You [ability.arming ? "enable" : "disable"] bomb arming.</span>")
	update_appearance()

#undef UNREGISTER_BOMB_SIGNALS
