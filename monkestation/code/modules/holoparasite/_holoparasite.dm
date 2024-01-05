GLOBAL_LIST_EMPTY_TYPED(holoparasites, /mob/living/basic/holoparasite) //! All currently existing holoparasites.

/mob/living/basic/holoparasite
	name = "Holoparasite"
	real_name = "Holoparasite"
	desc = "A sentient bluespace crystallization of someone's willpower, this being will forever protect and serve its host, standing guard until the last embers of their life are extinguished."
	speak_emote = list("emanates", "radiates")
	gender = NEUTER
	mob_biotypes = MOB_HUMANOID | MOB_SPIRIT
	bubble_icon = "guardian"
	icon = 'monkestation/icons/mob/holoparasite.dmi'
	icon_state = "magicOrange"
	icon_living = "magicOrange"
	icon_dead = "magicOrange"
	speed = 0
	light_system = MOVABLE_LIGHT
	light_outer_range = 4
	light_power = 1
	light_on = FALSE
	movement_type = FLYING // Immunity to chasms and landmines, etc.
	maxHealth = INFINITY // The spirit itself is invincible
	health = INFINITY
	damage_coeff = list(BRUTE = 0.5, BURN = 0.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0) // How much damage from each damage type we transfer to the owner
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 40
	hud_type = /datum/hud/holoparasite
	faction = list()
	see_in_dark = 10
	/**
	 * The name of the holoparasite, formatted with the [accent_color] in a <font> tag.
	 * Automatically set by [set_holopara_name()].
	 */
	var/color_name
	/// Notes left by the summoner of the holoparasite.
	var/notes = ""
	/**
	 * The accent color of the holoparasite, usually used to color an overlay.
	 * If [recolor_entire_sprite] is TRUE, it will instead be used to recolor the entire sprite.
	 */
	var/accent_color
	/// A list of accent color overlays.
	var/list/mutable_appearance/accent_overlays = list()
	/// Whether this holoparasite has emissive overlays or not.
	var/emissive = FALSE
	/// Whether to recolor the entire holoparasite with the [accent_color], or just the overlay.
	var/recolor_entire_sprite = FALSE
	/// The theme of this holoparasite.
	var/datum/holoparasite_theme/theme
	/**
	 * The range, in tiles, that this holoparasite can go from its summoner while manifested.
	 * A range of 1 will be permanently attached to its summoner.
	 * A range below 1 will have infinite range.
	 */
	var/range = 10
	/**
	 * The mind that summoned this holoparasite.
	 * The holoparasite is completely and utterly loyal to this user.
	 */
	var/datum/mind/summoner
	/// The stats associated with this holoparasite.
	var/datum/holoparasite_stats/stats
	/// The summoner's holoparasite holder.
	var/datum/holoparasite_holder/parent_holder
	/**
	 * The 'battle cry' the holoparasite uses when attacking.
	 * If blank, no battle cry will be shouted at all.
	 */
	var/battlecry = "AT"
	/**
	 * Whether the holoparasite is attached to its summoner when manifested or not.
	 * This does not affect range=1 holoparasites, those will always be permanently attached,
	 * this is used for 'manual' attaching.
	 */
	var/attached_to_summoner = FALSE
	/// The amount of HUD elements on the base "toolbar" at the bottom.
	var/toolbar_element_count = 0
	/// If the holoparasite talks out loud (rather than privately with its summoner) whenever it talks while recalled.
	var/talk_out_loud = FALSE
	/// The base action paths all holoparasites get by default.
	var/static/list/base_ability_paths = list(
		/datum/action/holoparasite/info,
		/datum/action/holoparasite/communicate,
		/datum/action/innate/holoparasite/toggle_light,
		/datum/action/innate/holoparasite/manifest_recall,
		/datum/action/holoparasite/set_battlecry
	)

/mob/living/basic/holoparasite/Initialize(_mapload, _key, _name, datum/holoparasite_theme/_theme, _accent_color, _notes, datum/mind/_summoner, datum/holoparasite_stats/_stats)
	. = ..()
	if(!istype(_summoner))
		stack_trace("Holoparasite initialized without a valid summoner!")
		return INITIALIZE_HINT_QDEL
	if(!istype(_stats))
		stack_trace("Holoparasite initialized without valid stats!")
		return INITIALIZE_HINT_QDEL
	if(!istype(_theme))
		stack_trace("Holoparasite initialized without a valid theme!")
		return INITIALIZE_HINT_QDEL
	GLOB.holoparasites += src
	set_accent_color(_accent_color || GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)], silent = TRUE)
	set_theme(_theme)
	if(length(_name))
		set_holopara_name(_name, internal = TRUE)
	if(length(_notes))
		notes = _notes
	set_summoner(_summoner)
	stats = _stats
	stats.apply(src)
	set_battlecry(pick("ORA", "MUDA", "DORA", "ARRI", "VOLA", "AT"), silent = TRUE)
	if(length(_key))
		key = _key
	// Setup signals, elements, and and such.
	RegisterSignal(src, COMSIG_LIVING_PRE_WABBAJACKED, PROC_REF(on_pre_wabbajacked))
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/basic_inhands)
	// TODO: /datum/component/life_link
	// TODO: /datum/component/projectile_parry
	// TODO: /datum/component/ranged_attacks
	// TODO: /datum/component/revenge_ability
	add_traits(list(TRAIT_TRUE_NIGHT_VISION, TRAIT_CAN_STRIP, TRAIT_LITERATE), INNATE_TRAIT)
	for(var/action_path in base_ability_paths)
		var/datum/action/holopara_action = new action_path(src)
		holopara_action.Grant(src)
	update_sight()

/mob/living/basic/holoparasite/Destroy()
	GLOB.holoparasites -= src
	QDEL_LIST(accent_overlays)
	parent_holder?.remove_holoparasite(src)
	return ..()

/mob/living/basic/holoparasite/Login()
	var/datum/antagonist/holoparasite/first_time_show_popup
	if(mind && key && key != mind.key) // Ooh, new player!
		first_time_show_popup = mind.has_antag_datum(/datum/antagonist/holoparasite)
	. = ..()
	if(mind)
		mind.name = "[real_name]"
	if(QDELETED(summoner?.current))
		message_admins("BUG: [ADMIN_LOOKUPFLW(src)], a holoparasite, somehow either has no summoner, or is in their body while their summoner is dead. This is <b>very bad</b>, and unless you caused this by screwing around with holoparasites using admin tools, is most definitely a bug, in which case <a href='byond://winset?command=report-issue'><i>please</i> report this ASAP!!</a>")
		log_runtime("BUG: [key_name(src)], a holoparasite, somehow either has no summoner, or is in their body while their summoner is dead. This is very bad and is most definitely a bug!!")
		to_chat(src, "<span class='userdanger'>For some reason, somehow, you have no summoner. <a href='byond://winset?command=report-issue'>Please report this bug immediately</a>, because this should <i>never</i> be possible! (outside of admins screwing with stuff they don't fully understand)</span>")
		ghostize(FALSE)
		return
	var/list/info_block = list()
	info_block += span_big(span_holoparasite("You can use :[MODE_KEY_HOLOPARASITE] or .[MODE_KEY_HOLOPARASITE] to privately communicate with your summoner!"))
	info_block += span_holoparasite("You are [color_name], bound to serve [span_name(summoner.name)]")
	info_block += span_holoparasite("You are capable of manifesting or recalling to your summoner with the buttons on your HUD. You will also find a button to communicate with [summoner.current.p_them()] privately there.")
	info_block += span_holoparasite("While personally invincible, you will die if <span class='name'>[summoner.name]</span> does, and any damage dealt to you will have a portion passed on to [summoner.current.p_them()] as you feed upon [summoner.current.p_them()] to sustain yourself.")
	info_block += span_boldholoparasite("Click the INFO button on your HUD in order to learn more about your stats, abilities, and your summoner.")
	setup_barriers()
	first_time_show_popup?.ui_interact(src)

/mob/living/basic/holoparasite/get_status_tab_items()
	. = ..()
	if(summoner.current)
		var/mob/living/current = summoner.current
		var/health_percent
		if(iscarbon(current))
			health_percent = round((abs(HEALTH_THRESHOLD_DEAD - current.health) / abs(HEALTH_THRESHOLD_DEAD - current.maxHealth)) * 100)
		else
			health_percent = round((current.health / current.maxHealth) * 100, 0.5)
		var/stat_text = "[health_percent]%"
		if(HAS_TRAIT(summoner, TRAIT_CRITICAL_CONDITION))
			stat_text += " (!! CRITICAL !!)"
		. += "Summoner Health: [stat_text]"
	if(!COOLDOWN_FINISHED(src, manifest_cooldown))
		. += "Manifest/Recall Cooldown Remaining: [COOLDOWN_TIMELEFT_TEXT(src, manifest_cooldown)]"
	SEND_SIGNAL(src, COMSIG_HOLOPARA_STAT, .)

/mob/living/basic/holoparasite/can_suicide()
	return FALSE

/mob/living/basic/holoparasite/suicide()
	set hidden = TRUE
	to_chat(src, span_warning("You cannot commit suicide! Reset yourself (or contact an admin) if you wish to stop being a holoparasite!"))

/mob/living/basic/holoparasite/set_resting(new_resting, silent = TRUE, instant = FALSE)
	return FALSE

/mob/living/basic/holoparasite/can_use_guns(obj/item/gun)
	if(SEND_SIGNAL(src, COMSIG_HOLOPARA_CAN_FIRE_GUN, gun) & HOLOPARA_CAN_FIRE_GUN)
		return TRUE
	balloon_alert(src, "cannot fire [gun]")
	return FALSE // No... just... no.

// TODO: codeword_hearing

/mob/living/basic/holoparasite/examine(mob/user)
	. = ..()
	if(isobserver(user) || has_matching_summoner(user))
		if(!stats.weapon.hidden)
			. += span_holoparasite("[span_bold("WEAPON:")] [stats.weapon.name] - [replacetext(stats.weapon.desc, "$theme", lowertext(theme.name))]")
		if(stats.ability)
			. += span_holoparasite("[span_bold("SPECIAL ABILITY:")] [stats.ability.name] - [replacetext(stats.ability.desc, "$theme", lowertext(theme.name))]")
		for(var/datum/holoparasite_ability/lesser/ability as() in stats.lesser_abilities)
			. += span_holoparasite("[span_bold("LESSER ABILITY:")] [ability.name] - [replacetext(ability.desc, "$theme", lowertext(theme.name))]")
		. += "<span data-component=\"RadarChart\" data-width=\"300\" data-height=\"300\" data-area-color=\"[accent_color]\" data-axes=\"Damage,Defense,Speed,Potential,Range\" data-stages=\"1,2,3,4,5\" data-values=\"[stats.damage],[stats.defense],[stats.speed],[stats.potential],[stats.range]\" />"

/mob/living/basic/holoparasite/get_idcard(hand_first = TRUE)
	// IMPORTANT: don't use ?. for these, because held_item might be 0 for some reason!!
	var/obj/item/card/id/id_card
	var/obj/item/held_item
	held_item = get_active_held_item()
	if(!QDELETED(held_item))
		id_card = held_item.GetID() //Check active hand
	if(QDELETED(id_card)) //If there is no id, check the other hand
		held_item = get_inactive_held_item()
		if(!QDELETED(held_item))
			id_card = held_item.GetID()

	if(!QDELETED(id_card))
		if(hand_first)
			return id_card
		. = id_card

	// Check inventory slot
	if(istype(stats.weapon, /datum/holoparasite_ability/weapon/dextrous))
		var/datum/holoparasite_ability/weapon/dextrous/dextrous_ability = stats.weapon
		var/obj/item/internal_item = dextrous_ability.internal_storage
		if(!QDELETED(internal_item))
			return internal_item.GetID()

/* TODO: [Shion Holoparas] intent fixup
/mob/living/basic/holoparasite/CtrlClickOn(atom/target)
	. = ..()
	if(a_intent != INTENT_HELP && is_manifested() && isobj(target) && Adjacent(target))
		if(target.ui_interact(src) != FALSE) // unimplemented ui_interact returns FALSE, while implemented typically just returns... nothing.
			to_chat(src, "<span class='notice'>You take a closer look at [costly_icon2html(target, src)] [target]...</span>")
			return
*/

/mob/living/basic/holoparasite/shared_ui_interaction(host)
	if(isobj(host))
		var/obj/obj_host = host
		if(obj_host.loc != src && !is_manifested())
			return UI_CLOSE
	. = ..()
	if(incorporeal_move)
		. = min(., UI_UPDATE)

/mob/living/basic/holoparasite/proc/toggle_light()
	if(emissive)
		set_light_on(is_manifested() || !light_on)
		if(light_outer_range != initial(light_outer_range) || light_power != initial(light_power))
			set_light_range(initial(light_outer_range))
			set_light_power(initial(light_power))
			balloon_alert(src, "light activated")
		else
			set_light_range(0)
			set_light_power(0.1)
			balloon_alert(src, "light deactivated")
	else
		set_light_on(!light_on)
		var/prefix = light_on ? "" : "de"
		balloon_alert(src, "light [prefix]activated")

/**
 * Recreates the holoparasite's HUD.
 */
/mob/living/basic/holoparasite/proc/recreate_hud()
	QDEL_NULL(hud_used)
	if(!client)
		return
	create_mob_hud()
	if(hud_used)
		hud_used.show_hud(hud_used.hud_version)
