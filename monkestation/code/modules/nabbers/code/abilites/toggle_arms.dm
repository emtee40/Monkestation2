/obj/item/melee/nabber_blade
	name = "Hunting arm"
	desc = "A grotesque, sharpened blade-limb. You feel as if you had to get this from a living creature to hold it. You monster."
	icon = 'monkestation/code/modules/nabbers/icons/items.dmi'
	icon_state = "mantis_arm_r"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 15 //These still hurt.
	throwforce = 0 //Buggy.
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 15
	bare_wound_bonus = 25

/obj/item/melee/nabber_blade/alt
	icon_state = "mantis_arm_l"

/obj/item/melee/nabber_blade/Initialize(mapload,silent,synthetic)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	AddComponent(/datum/component/butchering, \
	speed = 10 SECONDS, \
	effectiveness = 80, \
	)

/obj/item/melee/nabber_blade/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/structure/table))
		var/obj/structure/table/T = target
		T.deconstruct(FALSE)
	else if(istype(target, /obj/structure/chair))
		var/obj/structure/chair/C = target
		C.deconstruct()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user)

/datum/action/cooldown/toggle_arms
	name = "Toggle mantis arms"
	desc = "Pump your Haemolyph from the rest of your body into your hunting arms, allowing you to stab at foes. This will take time to do, and can be interrupted."
	cooldown_time = 5 SECONDS

	button_icon = 'monkestation/code/modules/nabbers/icons/actions.dmi'

/datum/action/cooldown/toggle_arms/New(Target, original)
	. = ..()
	button_icon_state = "arms_off"

/datum/action/cooldown/toggle_arms/Activate(atom/target)
	var/mob/living/carbon/human/nabber = owner

	if(!nabber)
		return FALSE

	if(isdead(nabber) || nabber.incapacitated())
		nabber.balloon_alert(nabber, "Incapacitated!")
		return FALSE

	if(nabber.num_hands < 2)
		nabber.balloon_alert(nabber, "Need both hands!")
		return	FALSE

	var/obj/item/held = nabber.get_active_held_item()
	var/obj/item/inactive = nabber.get_inactive_held_item()

	if(((held || inactive) && !nabber.drop_all_held_items()) && !(istype((inactive || held), /obj/item/melee/nabber_blade)))
		nabber.balloon_alert(nabber, "Hands occupied!")
		return	FALSE

	else if(istype((inactive || held), /obj/item/melee/nabber_blade))
		StartCooldown()
		down_arms()
		return TRUE

	rise_arms()
	StartCooldown()
	return TRUE

/datum/action/cooldown/toggle_arms/proc/rise_arms()
	var/mob/living/carbon/human/nabber = owner

	nabber.balloon_alert(nabber, "Begin pumping blood in!")
	nabber.visible_message(span_danger("[nabber] starts to pump blood into their hunting arms!"), span_warning("You let out a defensive screech, raising your blade-arms!"), span_hear("You hear a sharp screech of an agitated creature!"))
	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)

	if(!do_after(nabber, 5 SECONDS, nabber))
		StartCooldown()
		nabber.balloon_alert(nabber, "Stand still!")
		return FALSE

	nabber.balloon_alert(nabber, "Arms raised!")
	nabber.visible_message(span_warning("[nabber] raised their mantid-like hunting arms in a frenzy, ready for a fight!"), span_warning("You raise your mantis arms, ready for combat."), span_hear("You hear a terrible hunting screech!"))
	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)

	var/c = nabber.dna.features["mcolor"]
	var/obj/item/melee/nabber_blade/active_hand = new
	var/obj/item/melee/nabber_blade/alt/inactive_hand = new

	active_hand.color = c
	inactive_hand.color = c

	nabber.put_in_active_hand(active_hand)
	nabber.put_in_inactive_hand(inactive_hand)

	RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_lose_hand))
	button_icon_state = "arms_on"
	nabber.update_action_buttons()

/datum/action/cooldown/toggle_arms/proc/down_arms(force = FALSE)
	var/mob/living/carbon/human/nabber = owner

	nabber.visible_message(span_notice("[nabber] starts to relax, pumping blood away from their hunting-arms!"), span_notice("You start pumping blood out your mantis arms. Stay still!"), span_hear("You hear [src] let out a quiet hissing sigh."))

	if(force)
		nabber.Stun(5 SECONDS)
		for(var/obj/item/held in nabber.held_items)
			if(istype(held, /obj/item/melee/nabber_blade))
				qdel(held)
		button_icon_state = "arms_on"
		nabber.update_action_buttons()
		return	FALSE

	nabber.balloon_alert(nabber, "Removing blood from hunting-arms!")

	if(!do_after(nabber, 5 SECONDS, nabber))
		nabber.balloon_alert(nabber, "Stand still!")
		return	FALSE

	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)
	for(var/obj/item/held in nabber.held_items)
		if(istype(held, /obj/item/melee/nabber_blade))
			qdel(held)

	UnregisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB)
	nabber.balloon_alert(nabber, "Arms down!")
	button_icon_state = "arms_off"
	nabber.update_action_buttons()

/datum/action/cooldown/toggle_arms/proc/on_lose_hand()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/nabber = owner

	if(!(nabber.num_hands < 2))
		return	FALSE

	nabber.visible_message(span_notice("[nabber] has their arm violently removed, spurting high-pressure haemolyph, the other going limp!"), span_notice("HOLY SHIT MY ARM!"), span_hear("You hear [nabber] let out a sharp hiss as they lose a limb!"))
	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)
	nabber.balloon_alert(nabber, "Lost hands!")
	nabber.Stun(5 SECONDS)
	for(var/obj/item/held in nabber.held_items)
		if(istype(held, /obj/item/melee/nabber_blade))
			qdel(held)

	button_icon_state = "arms_off"
	nabber.update_action_buttons()
