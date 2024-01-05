#define HUD_CLOAK_ELIGIBLE (ability.can_cloak && !ability.cloaking && COOLDOWN_FINISHED(ability, cloak_cooldown))

/datum/holoparasite_ability/major/scout
	name = "Scout"
	desc = "The $theme can turn near-invisible and invincible and scout the station, although it cannot attack anything."
	ui_icon = FA_ICON_BINOCULARS
	cost = 1
	thresholds = list(
		list(
			"stat" = "Range",
			"desc" = "Along with Potential, increases the falloff distance where transmitted messages start to become scrambled."
		),
		list(
			"stat" = "Potential",
			"desc" = "Along with Range, increases the falloff distance where transmitted messages start to become scrambled."
		),
		list(
			"stat" = "Potential",
			"minimum" = 3,
			"desc" = "Allows the $theme to 'cloak' itself, where it becomes invisible to everyone except itself and its summoner when scouting, and can automatically stalk targets while in this state."
		)
	)
	traits = list(TRAIT_EMPATH) // Scout holoparas have a good eye.
	/// If the holoparasite is currently scouting or not.
	var/scouting = FALSE
	/// If the holoparasite is currently cloaking or not.
	var/cloaking = FALSE
	/// If the holoparasite is capable of cloaking.
	var/can_cloak = TRUE
	/// The "falloff range", where linked hearing messages begin to get scrambled.
	var/falloff_range = 0
	/// Whether the holopara actually manifested with cloak or not.
	var/manifested_with_cloak = FALSE
	/// A weakref to the mob that the holoparasite is currently stalking, if any.
	var/datum/weakref/stalking
	/// Whether the stalkee got a message when we began stalking them or not.
	var/stalkee_was_notified = FALSE
	/// The HUD button to toggle between scouting/cloaking modes.
	var/datum/action/holoparasite/toggle_scout/toggle_action
	/// The cooldown for toggling 'full stealth' mode.
	COOLDOWN_DECLARE(cloak_cooldown)
	/// The cooldown for stalking another person.
	COOLDOWN_DECLARE(stalk_cooldown)

/datum/holoparasite_ability/major/scout/apply()
	. = ..()
	if(QDELETED(toggle_action))
		toggle_action = new(src)
		toggle_action.ability = src
	toggle_action.Grant(owner)

/datum/holoparasite_ability/major/scout/remove()
	. = ..()
	stop_cloaking(forced = TRUE)
	exit_scout(forced = TRUE)
	if(!QDELETED(toggle_action))
		toggle_action.Remove(owner)

/datum/holoparasite_ability/major/scout/setup_thresholds()
	. = ..()
	can_cloak = master_stats.potential >= 3
	falloff_range = clamp(round((master_stats.range + master_stats.potential) * 0.5, 1), 2, 6)

/datum/holoparasite_ability/major/scout/register_signals()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_CAN_TRACK, PROC_REF(on_can_track))
	RegisterSignal(owner, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_bullet_act))
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(on_click))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(owner, COMSIG_HOLOPARA_SETUP_HUD, PROC_REF(on_hud_setup))
	RegisterSignals(owner, list(COMSIG_HOLOPARA_SET_HUD_HEALTH, COMSIG_HOLOPARA_SET_HUD_STATUS), PROC_REF(on_medhud))
	RegisterSignal(owner, COMSIG_HOLOPARA_POST_MANIFEST, PROC_REF(on_post_manifest))
	RegisterSignal(owner, COMSIG_HOLOPARA_RECALL, PROC_REF(on_recall))
	RegisterSignal(owner, COMSIG_HOLOPARA_STAT, PROC_REF(on_stat))
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, PROC_REF(on_hear))

/datum/holoparasite_ability/major/scout/unregister_signals()
	. = ..()
	UnregisterSignal(owner, list(COMSIG_LIVING_CAN_TRACK, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_MOB_CLICKON, COMSIG_MOVABLE_MOVED, COMSIG_HOLOPARA_SETUP_HUD, COMSIG_HOLOPARA_SET_HUD_HEALTH, COMSIG_HOLOPARA_SET_HUD_STATUS, COMSIG_HOLOPARA_POST_MANIFEST, COMSIG_HOLOPARA_RECALL, COMSIG_HOLOPARA_STAT, COMSIG_MOVABLE_HEAR))

/**
 * Ensures holoparasites cannot be tracked when scouting.
 */
/datum/holoparasite_ability/major/scout/proc/on_can_track()
	SIGNAL_HANDLER
	if(scouting)
		return COMPONENT_CANT_TRACK

/**
 * Projectiles completely go through scouting holoparas.
 */
/datum/holoparasite_ability/major/scout/proc/on_bullet_act()
	SIGNAL_HANDLER
	if(scouting)
		return COMPONENT_BULLET_PIERCED

/**
 * Handles healing a target whenever attacking them.
 */
/datum/holoparasite_ability/major/scout/proc/on_click(datum/_source, atom/target)
	SIGNAL_HANDLER
	if(!owner.is_manifested())
		return
	if(scouting && isobj(target) && owner.Adjacent(target))
		if(target.ui_interact(owner) != FALSE) // unimplemented ui_interact returns FALSE, while implemented typically just returns... nothing.
			to_chat(owner, span_notice("You take a closer look at [costly_icon2html(target, owner)] [target]..."))
			return COMSIG_MOB_CANCEL_CLICKON
	if(!cloaking || !isliving(target))
		return
	if(owner.has_matching_summoner(target))
		to_chat(owner, span_warning("There's no need to stalk [span_name("[target]")]..."))
		return
	if(!isturf(target.loc) || target.z != owner.z || !in_view_range(owner, target))
		to_chat(owner, span_warning("[span_name("[target]")] is too far away to begin stalking!"))
		return
	begin_stalking(target)
	return COMSIG_MOB_CANCEL_CLICKON

/**
 * Manually moving ourselves while stalking will stop the stalk.
 */
/datum/holoparasite_ability/major/scout/proc/on_move(datum/_source, atom/_old_loc, _dir, forced = FALSE)
	SIGNAL_HANDLER
	if(stalking?.resolve() && !forced)
		stop_stalking()

/datum/holoparasite_ability/major/scout/proc/on_hud_setup(datum/_source, datum/hud/holoparasite/_hud, list/huds_to_add)
	SIGNAL_HANDLER
	if(QDELETED(toggle_action))
		toggle_action = new(null, owner, src)
	huds_to_add += toggle_action

/**
 * Blanks out the holoparasite's medhud whenever it is cloaked.
 */
/datum/holoparasite_ability/major/scout/proc/on_medhud(datum/_source, image/holder)
	SIGNAL_HANDLER
	if(scouting)
		holder.icon_state = null

/**
 * Handles turning scout mode holoparasites incorporeal whenever it manifests.
 */
/datum/holoparasite_ability/major/scout/proc/on_post_manifest()
	SIGNAL_HANDLER
	if(scouting)
		owner.anchored = TRUE
		owner.incorporeal_move = INCORPOREAL_MOVE_BASIC
		owner.move_resist = INFINITY
		owner.set_density(FALSE)
		owner.alpha = 45
		owner.attack_sound = 'sound/items/bikehorn.ogg'
		owner.add_traits(list(TRAIT_THERMAL_VISION, TRAIT_HOLOPARA_BYSTANDER, TRAIT_SHOCKIMMUNE), HOLOPARASITE_SCOUT_TRAIT)
	if(cloaking)
		manifested_with_cloak = TRUE

/**
 * Handles resetting the corporeality of the holoparasite whenever it recalls.
 */
/datum/holoparasite_ability/major/scout/proc/on_recall()
	SIGNAL_HANDLER
	owner.incorporeal_move = FALSE
	owner.anchored = FALSE
	owner.move_resist = initial(owner.move_resist)
	owner.set_density(initial(owner.density))
	owner.attack_sound = owner.theme.mob_info[HOLOPARA_THEME_ATTACK_SOUND] || initial(owner.attack_sound)
	REMOVE_TRAITS_IN(owner, HOLOPARASITE_SCOUT_TRAIT)
	stop_stalking()
	stop_cloaking()

/**
 * Adds cloaking cooldown info to the holoparasite's stat panel.
 */
/datum/holoparasite_ability/major/scout/proc/on_stat(datum/_source, list/tab_data)
	SIGNAL_HANDLER
	/*tab_data["Current Mode"] = GENERATE_STAT_TEXT(cloaking ? "Cloaked" : (scouting ? "Scouting" : "Normal"))
	if(can_cloak)
		if(!COOLDOWN_FINISHED(src, cloak_cooldown))
			tab_data["Cloaking Cooldown"] = GENERATE_STAT_TEXT(COOLDOWN_TIMELEFT_TEXT(src, cloak_cooldown))
		if(!COOLDOWN_FINISHED(src, stalk_cooldown))*/

/**
 * Handles the 'spy' thingy for scout holoparas, which allows the summoner to eavesdrop on what's going on near the holopara.
 */
/datum/holoparasite_ability/major/scout/proc/on_hear(datum/_source, list/hear_args)
	SIGNAL_HANDLER
	if(!length(hear_args))
		return
	// Only relay if the holoparasite is in scout mode.
	if(!scouting)
		return
	// We don't care about radio chatter.
	if(hear_args[HEARING_RADIO_FREQ])
		return
	var/message = hear_args[HEARING_RAW_MESSAGE]
	var/atom/movable/speaker = hear_args[HEARING_SPEAKER]
	var/spans = hear_args[HEARING_SPANS]
	var/list/message_mods = hear_args[HEARING_MESSAGE_MODE]
	var/mob/living/summoner = owner.summoner.current
	if(!summoner)
		return
	// Only relay if the holoparasite is manifested.
	if(!owner.is_manifested())
		return
	// Don't relay the summoner's own speech!
	if(speaker == summoner)
		return
	// Don't relay anything the summoner can just hear for themselves.
	if(summoner.can_hear() && (speaker in get_hearers_in_view(7, summoner)))
		return
	var/dist = get_dist(owner, speaker)
	var/star_factor = (dist > falloff_range) ? min((dist - falloff_range) * 10, 55) : 0
	// If the summoner is 'psychically attuned' (they're more used to psychic bullshit than an average person), we'll reduce the star factor for them.
	if(is_species(summoner, /datum/species/jelly/stargazer) || isabductor(summoner))
		star_factor *= HOLOPARA_SCOUT_SPY_ATTUNED_MULTIPLIER
	var/scrambled_message = stars(message, star_factor)
	// Bit of a nasty hardcoded hack, but eh, it works!
	var/datum/antagonist/traitor/summoner_traitor = owner.summoner.has_antag_datum(/datum/antagonist/traitor)
	if(summoner_traitor?.should_give_codewords)
		scrambled_message = GLOB.syndicate_code_phrase_regex.Replace(scrambled_message, "<span class='blue'>$1</span>")
		scrambled_message = GLOB.syndicate_code_response_regex.Replace(scrambled_message, "<span class='red'>$1</span>")
	// Assemble the message prefix
	var/message_prefix = "<span class='holoparasite italics robot'>\[[owner.color_name] Sensory Link\] [speaker.GetVoice()]"
	// Get the say message quote thingy
	var/message_part
	if(message_mods[MODE_CUSTOM_SAY_ERASE_INPUT])
		message_part = message_mods[MODE_CUSTOM_SAY_EMOTE]
	else
		var/atom/movable/source = speaker.GetSource() || speaker
		message_part = source.say_quote(scrambled_message, spans, message_mods)
	message_part = "<span class='message'>[summoner.say_emphasis(message_part)]</span></span>"
	// And now, we put the final message together and show it to the summoner.
	var/final_message = "[message_prefix] [message_part]"
	to_chat(owner.list_summoner_and_or_holoparasites(include_self = FALSE), final_message)

/**
 * Enters scout mode, which disables all forms of damage and abilities,
 * but gives the holoparasite infinite range.
 */
/datum/holoparasite_ability/major/scout/proc/enter_scout()
	if(owner.is_manifested())
		to_chat(owner,  span_warning("You can only toggle scouting while recalled"))
		return
	owner.environment_smash = ENVIRONMENT_SMASH_NONE
	owner.alpha = 45
	owner.range = -1
	owner.add_filter("holoparasite_scout_blur", 2, gauss_blur_filter(size = 1))
	scouting = TRUE
	owner.med_hud_set_health()
	owner.med_hud_set_status()
	owner.balloon_alert(owner, "entered scout mode")
	to_chat(owner, span_boldnotice("You enter scout mode, you may no longer attack or use most abilities, however you can freely move around the station through obstacles at great speeds."))
	SEND_SIGNAL(owner, COMSIG_HOLOPARA_ENTER_SCOUT)

/**
 * Exits scout mode, restoring the holoparasite's stats to normal.
 */
/datum/holoparasite_ability/major/scout/proc/exit_scout(forced = FALSE)
	if(!forced && owner.is_manifested())
		to_chat(owner, "<span class='warning'>You can only toggle scouting while recalled!</span>")
		return
	owner.environment_smash = initial(owner.environment_smash)
	owner.alpha = 255
	owner.range = initial(owner.range)
	owner.stats.apply(owner)
	owner.remove_filter("holoparasite_scout_blur")
	scouting = FALSE
	owner.med_hud_set_health()
	owner.med_hud_set_status()
	REMOVE_TRAITS_IN(owner, HOLOPARASITE_SCOUT_TRAIT)
	owner.update_sight()
	if(!forced)
		owner.balloon_alert(owner, "exited scout mode")
		to_chat(owner, span_boldnotice("You exit scout mode, you may attack and use abilities normally again."))
	SEND_SIGNAL(owner, COMSIG_HOLOPARA_EXIT_SCOUT)

/**
 * Causes the holoparasite to 'cloak', where the holoparasite becomes invisible to all but itself and its summoner.
 *
 * Returns TRUE if the holoparasite successfully cloaks (or if it is already cloaked), FALSE if it does not.
 */
/datum/holoparasite_ability/major/scout/proc/begin_cloaking()
	. = TRUE
	if(!can_cloak)
		stop_cloaking(forced = TRUE)
		return FALSE
	if(cloaking)
		return
	if(owner.is_manifested())
		to_chat(owner, "<span class='warning'>You can only toggle cloaking while recalled!</span>")
		return FALSE
	if(!COOLDOWN_FINISHED(src, cloak_cooldown))
		to_chat(owner, "<span class='warning'>You must wait [COOLDOWN_TIMELEFT_TEXT(src, cloak_cooldown)] before you can cloak again.</span>")
		return FALSE
	manifested_with_cloak = FALSE
	owner.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/image/blank_image = image(icon_state = "blank", loc = owner)
	blank_image.override = TRUE
	owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/except_holoparasite, "scout_cloaking", blank_image, NONE, owner)
	cloaking = TRUE
	owner.med_hud_set_health()
	owner.med_hud_set_status()
	owner.add_traits(list(TRAIT_MUTE, TRAIT_EMOTEMUTE), HOLOPARASITE_CLOAK_TRAIT)
	to_chat(owner, span_boldnotice("You begin to cloak, you are now completely invisible to almost everyone, however you can no longer speak nor emote."))
	owner.balloon_alert(owner, "started cloaking")
	SEND_SIGNAL(owner, COMSIG_HOLOPARA_ENTER_CLOAK)

/**
 * Uncloaks the holoparasite, allowing the holoparasite to be seen by everyone again, and stop stalking.
 *
 * Arguments
 * * forced: TRUE if the uncloaking is forced, FALSE if it is not. Forced uncloaks will not start the cooldown.
 */
/datum/holoparasite_ability/major/scout/proc/stop_cloaking(forced = FALSE)
	if(!cloaking)
		return
	if(!forced && owner.is_manifested())
		to_chat(owner, span_warning("You can only toggle cloaking while recalled!"))
		return FALSE
	owner.mouse_opacity = initial(owner.mouse_opacity)
	owner.remove_alt_appearance("scout_cloaking")
	cloaking = FALSE
	REMOVE_TRAITS_IN(owner, HOLOPARASITE_CLOAK_TRAIT)
	stop_stalking(forced)
	owner.med_hud_set_health()
	owner.med_hud_set_status()
	to_chat(owner, span_boldnotice("You stop cloaking, you are mostly visible once again, and can freely speak or emote once more."))
	if(!forced)
		if(manifested_with_cloak)
			COOLDOWN_START(src, cloak_cooldown, HOLOPARA_SCOUT_CLOAK_COOLDOWN)
		owner.balloon_alert(owner, "stopped cloaking")
	manifested_with_cloak = FALSE
	SEND_SIGNAL(owner, COMSIG_HOLOPARA_EXIT_CLOAK)

/**
 * Begins to stalk a target while cloaked.
 */
/datum/holoparasite_ability/major/scout/proc/begin_stalking(mob/living/target)
	if(!cloaking || !owner.is_manifested() || !istype(target) || target.weak_reference == stalking)
		return
	if(!COOLDOWN_FINISHED(src, stalk_cooldown))
		to_chat(owner, span_warning("You must wait [COOLDOWN_TIMELEFT_TEXT(src, stalk_cooldown)] before you can stalk someone else!"))
		return
	if(isliving(stalking?.resolve()))
		stop_stalking(silent = TRUE)
	owner.incorporeal_move = FALSE
	stalking = WEAKREF(target)
	to_chat(owner,  span_notice("You begin to stalk [span_name("[target]")], following [target.p_their()] every move from behind your cloak."))
	RegisterSignals(target, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE), PROC_REF(on_stalked_moved))
	RegisterSignal(target, COMSIG_PREQDELETED, PROC_REF(on_stalked_pre_qdel))
	on_stalked_moved(target)
	deadchat_broadcast(span_ghostalert("[span_name("[owner.real_name]")] has begun to stalk [span_name("[target.real_name]")]"), follow_target = owner, turf_target = get_turf(owner))
	COOLDOWN_START(src, stalk_cooldown, 15 SECONDS)
	if(target.has_holoparasites() && prob(80))
		to_chat(target, span_holoparasite("<i>You feel a strange yet familiar feeling, as if [COLOR_TEXT(owner.accent_color, "something")] was watching you...</i>"))
		stalkee_was_notified = TRUE

/**
 * Stops stalking a target.
 */
/datum/holoparasite_ability/major/scout/proc/stop_stalking(silent = FALSE)
	var/mob/living/currently_stalking = stalking?.resolve()
	if(!istype(currently_stalking))
		return
	if(!silent)
		to_chat(owner, span_notice("You stop stalking [span_name("[currently_stalking]")]."))
	if(stalkee_was_notified)
		to_chat(currently_stalking, span_holoparasite("<i>You feel relief as the strange feeling of being watched fades away...</i"))
	var/out_and_about = scouting && owner.is_manifested()
	owner.incorporeal_move = out_and_about ? INCORPOREAL_MOVE_BASIC : FALSE
	owner.anchored = out_and_about
	UnregisterSignal(currently_stalking, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE, COMSIG_PREQDELETED))
	stalking = null
	stalkee_was_notified = FALSE
	owner.pixel_x = initial(owner.pixel_x)
	owner.pixel_y = initial(owner.pixel_y)
	owner.layer = initial(owner.layer)

/**
 * Handles the stalked target moving.
 */
/datum/holoparasite_ability/major/scout/proc/on_stalked_moved(mob/living/target)
	SIGNAL_HANDLER
	if(!can_cloak || !cloaking || !owner.is_manifested() || !istype(target))
		stop_stalking(silent = TRUE)
		return
	owner.forceMove(get_turf(target))
	owner.setDir(target.dir)
	owner.pixel_x = initial(owner.pixel_x)
	owner.pixel_y = initial(owner.pixel_y)
	switch(target.dir)
		if(NORTH)
			owner.pixel_y = -16
			owner.layer = target.layer + 0.1
		if(SOUTH)
			owner.pixel_y = 16
			owner.layer = target.layer - 0.1
		if(EAST)
			owner.pixel_x = -16
			owner.layer = target.layer
		if(WEST)
			owner.pixel_x = 16
			owner.layer = target.layer

/**
 * Handles a stalking target about to be deleted, allowing us to safely stop and clean up our stalk.
 */
/datum/holoparasite_ability/major/scout/proc/on_stalked_pre_qdel(mob/living/target)
	SIGNAL_HANDLER
	stop_stalking(silent = TRUE)

/datum/atom_hud/alternate_appearance/basic/except_holoparasite
	add_ghost_version = FALSE
	var/mob/living/basic/holoparasite/parent

/datum/atom_hud/alternate_appearance/basic/except_holoparasite/New(key, image/img, options, mob/living/basic/holoparasite/_parent)
	..()
	parent = _parent
	/*for(var/mob/mob in GLOB.mob_list)
		if(mobShouldSee(mob))
			add_hud_to(mob)
			mob.reload_huds()*/

/datum/atom_hud/alternate_appearance/basic/except_holoparasite/mobShouldSee(mob/target)
	return !isobserver(target) && !parent.has_matching_summoner(target)

/datum/action/holoparasite/toggle_scout
	name = "Enter Scout"
	desc = "Enter scout mode, allowing you to scout across the whole station while near-invisible."
	button_icon_state = "scout:on"
	var/static/cloak_name = "Begin Cloaking"
	var/static/cloak_desc = "Begin cloaking, which allows you to completely hide yourself while scouting, and gives you the ability to automatically stalk people, although you cannot talk nor emote while cloaked."
	var/static/cloak_icon = "scout:cloak"
	var/static/exit_name = "Exit Scout"
	var/static/exit_desc = "Exit scout mode, making you corporeal once more, but allowing you to attack and use abilities again."
	var/static/exit_icon = "cancel"
	var/datum/holoparasite_ability/major/scout/ability

/datum/action/holoparasite/toggle_scout/Grant(mob/living/basic/holoparasite/owner)
	. = ..()
	RegisterSignals(owner, list(COMSIG_HOLOPARA_ENTER_SCOUT, COMSIG_HOLOPARA_EXIT_SCOUT, COMSIG_HOLOPARA_ENTER_CLOAK, COMSIG_HOLOPARA_EXIT_CLOAK), PROC_REF(update_appearance))

/datum/action/holoparasite/toggle_scout/Remove(mob/living/basic/holoparasite/owner)
	. = ..()
	UnregisterSignal(owner, list(COMSIG_HOLOPARA_ENTER_SCOUT, COMSIG_HOLOPARA_EXIT_SCOUT, COMSIG_HOLOPARA_ENTER_CLOAK, COMSIG_HOLOPARA_EXIT_CLOAK))

/datum/action/holoparasite/toggle_scout/proc/update_appearance()
	SIGNAL_HANDLER
	name = ability.scouting ? (HUD_CLOAK_ELIGIBLE ? cloak_name : exit_name) : initial(name)
	desc = ability.scouting ? (HUD_CLOAK_ELIGIBLE ? cloak_desc : exit_desc) : initial(desc)
	button_icon_state = ability.scouting ? (HUD_CLOAK_ELIGIBLE ? cloak_icon : exit_icon) : initial(button_icon_state)
	update_all_buttons()

/datum/action/holoparasite/toggle_scout/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/basic/holoparasite/owner = src.owner
	if(owner.is_manifested())
		to_chat(owner, "<span class='warning'>You can only toggle scouting or cloaking while recalled!</span>")
		return
	if(ability.scouting)
		if(HUD_CLOAK_ELIGIBLE)
			ability.begin_cloaking()
		else
			ability.stop_cloaking()
			ability.exit_scout()
	else
		ability.enter_scout()

/datum/action/holoparasite/toggle_scout/should_be_transparent()
	var/mob/living/basic/holoparasite/owner = src.owner
	return ..() || owner.is_manifested()

/datum/action/holoparasite/toggle_scout/tooltip_content()
	. = ..()
	var/mob/living/basic/holoparasite/owner = src.owner
	if(owner.is_manifested())
		. += "<br><b>You must be recalled to change scouting modes!</b>"
	if(ability.can_cloak && !COOLDOWN_FINISHED(ability, cloak_cooldown))
		. += "<br><b>Cloaking is currently on cooldown!</b>"

#undef HUD_CLOAK_ELIGIBLE
