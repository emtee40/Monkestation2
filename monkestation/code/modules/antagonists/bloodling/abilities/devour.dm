/datum/action/cooldown/mob_cooldown/bloodling/devour
	name = "Devour Limb"
	desc = "Allows you to consume a creatures limb."
	button_icon_state = "alien_hide"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/mob_cooldown/bloodling/devour/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return
	to_chat(on_who, span_noticealien("You prepare to swallow a limb whole. <b>Click a target to rip off a limb!</b>"))

/datum/action/cooldown/mob_cooldown/bloodling/devour/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("You steady yourself. Now is not the time to rip off their limb..."))

/datum/action/cooldown/mob_cooldown/bloodling/devour/PreActivate(atom/target)
	var/mob/living/mob = target
	if(!iscarbon(mob))
		owner.balloon_alert(owner, "only works on carbons!")
		return FALSE
	return ..()

/datum/action/cooldown/mob_cooldown/bloodling/devour/Activate(atom/target)
	StartCooldown()
	var/mob/living/basic/bloodling/our_mob = owner
	var/list/candidate_for_removal = list()
	var/mob/living/carbon/carbon_target = target

	for(var/obj/item/bodypart/bodypart in carbon_target.bodyparts)
		if(bodypart.body_zone == BODY_ZONE_CHEST)
			continue
		if(bodypart.bodypart_flags & BODYPART_UNREMOVABLE)
			continue
		candidate_for_removal += bodypart.body_zone

	if(!length(candidate_for_removal))
		return

	var/limb_to_remove = pick(candidate_for_removal)
	var/obj/item/bodypart/target_part = carbon_target.get_bodypart(limb_to_remove)

	if(isnull(target_part))
		return

	target_part.dismember()
	qdel(target_part)
	our_mob.add_biomass(20)

	our_mob.visible_message(
		span_alertalien("[our_mob] snaps its maw over [target]s [target_part] and swiftly devours it!"),
		span_noticealien("You devour [target]s [target_part]!"),
	)
