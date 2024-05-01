//Defines. Handles what type of arm to give. Always use blank or /type to prevent issues with regular arms.
#define NABBER_ARM_TYPE_REGULAR ""
#define NABBER_ARM_TYPE_SHARPENED "/sharp"
#define NABBER_ARM_TYPE_SYNDICATE "/syndicate"
#define NABBER_ARM_TYPE_NUCLEAR 3
#define NABBER_ARM_TYPE_PACIFIED 4

//var/obj/item/stack/sheet/mineral/mineral_path = text2path("/obj/item/stack/sheet/mineral/[mineral]")

/obj/item/melee/nabber_blade
	name = "Hunting arm"
	desc = "A grotesque, sharpened blade-limb. You feel as if you had to get this from a living creature to hold it. You monster."
	icon = 'monkestation/code/modules/nabbers/icons/items.dmi'
	icon_state = "mantis_arm_r"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 14 //Temporary nerf. Original value; 17. Should no longer be able to damage reinforced windows.
	armour_penetration = 7 //Hydraulic muscle-driven arms.
	throwforce = 0 //Buggy.
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 10 //dropped from 25
	bare_wound_bonus = 10 //Dropped from 25. Now lowered due to the ability to sharpen them.
	var/icon_type_on //will manage if a blade should have custom icons.
	var/icon_type_off

/obj/item/melee/nabber_blade/Initialize(mapload,silent,synthetic)
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT) //They're designed for this
	AddComponent(/datum/component/butchering, \
	speed = 3 SECONDS, \
	effectiveness = 85, \
	)
	return ..()

/obj/item/melee/nabber_blade/Destroy()
	icon_type_on = null
	icon_type_off = null
	return ..()

/obj/item/melee/nabber_blade/alt
	icon_state = "mantis_arm_l"

/obj/item/melee/nabber_blade/sharp
	force = 18 //+4 damage to simulate whetstone usage.
	wound_bonus = 15 // Decent buff.
	bare_wound_bonus = 35 //Significant buff.
	name = "lethally sharpened hunting-arm"

/obj/item/melee/nabber_blade/sharp/alt
	icon_state = "mantis_arm_l" //todo: replace sprites

/obj/item/melee/nabber_blade/sharp/Initialize(mapload,silent,synthetic)
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT) //They're designed for this
	AddComponent(/datum/component/butchering, \
	speed = 1.5 SECONDS, \
	effectiveness = 95, \
	)
	return ..()

/obj/item/melee/nabber_blade/syndicate
	name = "energy-enhanced bladearm"
	force = 29 //Only 5 less than a DEsword, but way more utility for nabbers.
	armour_penetration = 45 //Almost half AP however
	wound_bonus = 25 //Also insane, but 18tc item.
	bare_wound_bonus = 40 //Insane, but this is a 18tc item. On-par with double-bladed esword.
	hitsound = 'sound/weapons/blade1.ogg'
	armor_type = /datum/armor/item_dualsaber
	block_chance = 75 //75% chance isn't actually that high (copium). They die to three laser shots anyway.
	block_sound = 'sound/weapons/block_blade.ogg'
	icon_type_on = "blades_on"
	icon_type_off = "blades_off"
	light_system = OVERLAY_LIGHT
	light_outer_range = 5
	light_power = 0.65 //Bright, but not awfully so.
	light_on = TRUE
	light_color = LIGHT_COLOR_INTENSE_RED //Cant forget this

/obj/item/melee/nabber_blade/syndicate/Initialize(mapload,silent,synthetic)
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT) //They're designed for this
	AddComponent(/datum/component/butchering, \
	speed = 5 SECONDS, \
	effectiveness = 60, \
	) //They suck at butchering
	return ..()

/obj/item/melee/nabber_blade/syndicate/alt
	icon_state = "mantis_arm_l" //todo: custom sprites.

/obj/item/melee/nabber_blade/pre_attack(atom/W, mob/living/user, params) //Handles whetstoning your limbs. TODO: Maybe add nabber-specific traitor item for this?
	if (istype(W, /obj/item/sharpener))
		var/obj/item/sharpener/poorstone = W
		for(var/datum/action/cooldown/toggle_arms/arms in user.actions)
			if(arms.blade_type != NABBER_ARM_TYPE_REGULAR)
				user.visible_message(span_notice("[user] tries to sharpen their blade-arms... But fails, like a doofus."),
										span_notice("You can't sharpen these!"))
				return FALSE
		if(poorstone.uses >= 1)
			user.visible_message(span_notice("[user] begins to sharpen their massive blade-arms."),
									span_notice("You begin to sharpen your natural weaponry."))
			if(do_after(user, 7 SECONDS, target = src))
				user.visible_message(span_notice("[user] sharpens the large, sharp underside of their bladearms..."),
										span_notice("You sharpen the large underside of your bladearm, ready to kill..."))
				playsound(src, 'sound/items/unsheath.ogg', 100, TRUE)
				poorstone.uses-- //Make sure you cant sharpen both for a single whetstone!
				poorstone.name = "thoroughly ruined whetstone"
				poorstone.desc = "A whetstone, ruined seemingly by sharpening both sides of a massive, bladed limb - ground utterly smooth." //Give a forensic hint as to what ruined it.
				for(var/datum/action/cooldown/toggle_arms/arms in user.actions) //Should only ever be one instance. Make sure to handle it, though
					arms.blade_type = NABBER_ARM_TYPE_SHARPENED
					arms.held_desc = span_notice("has sharpened their blade-arms with what appears to be crude whetstoning, the honed edge gleaming with a dangerous tint...")
			return
		else
			user.visible_message(span_notice("[user] attempts to sharpen their arms, only to find the whetstone too smooth to do so!"),
									span_notice("You fail to even grind the burr away from your chitinous limbs. Use a better stone."))


	if (istype(W, /obj/item/nabber_energyblades)) //Ideally turn this into a component in the future.
		user.visible_message(span_notice("[user] begins to carefully run their blade-arms through the suspicious case, an ominous red glow present..."),
								span_notice("You lower your arms into the case, utilising the inbuilt autosurgeon to attach several energy-projectors to the undersides."))
		if(do_after(user, 7 SECONDS, target = src))
			user.visible_message(span_notice("[user] raises their blade-arms, a new black-and-red set of projectors providing an ominous nimbus..."),
									span_notice("With your new energy-blades, you're more than ready to kill."))
			playsound(src, 'sound/weapons/saberon.ogg', 100, TRUE)
			qdel(W) //Destroy the evidence!
			for(var/datum/action/cooldown/toggle_arms/arms in user.actions) //Should only ever be one instance. Make sure to handle it, though
				arms.blade_type = NABBER_ARM_TYPE_SYNDICATE
				arms.held_desc = span_bolddanger("has clearly been modified - several large energy projectors attached to their blade-arms, glowing with the classic red nimbus of syndicate technology...")
		return
	return ..()

/obj/item/melee/nabber_blade/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	else if(istype(target, /obj/structure/chair))
		var/obj/structure/chair/C = target
		C.deconstruct()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user)

/datum/action/cooldown/toggle_arms
	name = "Toggle mantis arms"
	desc = "Pump your Haemolyph from the rest of your body into your hunting arms, allowing you to stab at foes. This will take time to do, and can be interrupted."
	cooldown_time = 3 SECONDS

	button_icon = 'monkestation/code/modules/nabbers/icons/actions.dmi'
	var/blade_type = NABBER_ARM_TYPE_REGULAR //Need to hold this here.
	var/held_desc // Manages any custom blade messages on examine

/datum/action/cooldown/toggle_arms/Destroy()
	blade_type = null
	held_desc = null
	return ..()

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
	nabber.visible_message(span_danger("[nabber] starts to pump blood into their hunting arms!"), span_warning("You let out a aggressive screech, raising your blade-arms!"), span_hear("You hear a sharp screech of an agitated creature!"))
	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)

	if(!do_after(nabber, 1.5 SECONDS, nabber))
		StartCooldown()
		nabber.balloon_alert(nabber, "Stand still!")
		return FALSE

	nabber.balloon_alert(nabber, "Arms raised!")
	nabber.visible_message(span_warning("[nabber] raised their mantid-like hunting arms in a frenzy, ready for a fight!"), span_warning("You raise your mantis arms, ready for combat."), span_hear("You hear a terrible hunting screech!"))
	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)

	var/c = nabber.dna.features["mcolor"]
	var/active_path = text2path("/obj/item/melee/nabber_blade[blade_type]")
	var/inactive_path = text2path("/obj/item/melee/nabber_blade[blade_type]/alt")
	var/obj/item/melee/nabber_blade/active_hand =  new active_path
	var/obj/item/melee/nabber_blade/inactive_hand = new inactive_path

	active_hand.color = c
	inactive_hand.color = c

	nabber.put_in_active_hand(active_hand)
	nabber.put_in_inactive_hand(inactive_hand)
	if(blade_type) //Rather than just having these be items that can cause huge problems, ensure we delete them and just recreate with the force neccessary.
		RegisterSignal(nabber, COMSIG_ATOM_EXAMINE, PROC_REF(examined))
		if(active_hand.icon_type_on)
			nabber.modify_accessory_overlay(active_hand.icon_type_on)
	RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_lose_hand))
	button_icon_state = "arms_on"
	nabber.update_action_buttons()

/datum/action/cooldown/toggle_arms/proc/down_arms(force = FALSE)
	var/mob/living/carbon/human/nabber = owner
	nabber.visible_message(span_notice("[nabber] starts to relax, pumping blood away from their hunting-arms!"), span_notice("You start pumping blood out your mantis arms. Stay still!"), span_hear("You hear [src] let out a quiet hissing sigh."))

	if(force)
		nabber.Stun(5 SECONDS)
		for(var/obj/item/held in nabber.held_items)
			var/obj/item/melee/nabber_blade/held_temp = held
			if(held_temp.icon_type_off)
				nabber.modify_accessory_overlay(held_temp.icon_type_off)
			qdel(held)
		button_icon_state = "arms_on"
		nabber.update_action_buttons()
		return	FALSE

	nabber.balloon_alert(nabber, "Removing blood from hunting-arms!")

	if(!do_after(nabber, 0.5 SECONDS, nabber))
		nabber.balloon_alert(nabber, "Stand still!")
		return	FALSE

	playsound(nabber, 'monkestation/code/modules/nabbers/sounds/nabberscream.ogg', 70)
	if(blade_type)
		UnregisterSignal(nabber, COMSIG_ATOM_EXAMINE, PROC_REF(examined))
	for(var/obj/item/held in nabber.held_items)
		var/obj/item/melee/nabber_blade/held_temp = held
		if(held_temp.icon_type_off)
			nabber.modify_accessory_overlay(held_temp.icon_type_off)
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
	if(blade_type)
		UnregisterSignal(nabber, COMSIG_ATOM_EXAMINE, PROC_REF(examined))
	for(var/obj/item/held in nabber.held_items)
		var/obj/item/melee/nabber_blade/held_temp = held
		if(held_temp.icon_type_off)
			nabber.modify_accessory_overlay(held_temp.icon_type_off)
		qdel(held)

	button_icon_state = "arms_off"
	nabber.update_action_buttons()

/datum/action/cooldown/toggle_arms/proc/examined(mob/living/carbon/examined, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/examine_text = span_bolditalic("[examined] [held_desc]")
	examine_list += examine_text
