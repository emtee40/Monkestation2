/obj/item/xenoarch
	name = "parent dev item"
	icon = 'monkestation/code/modules/xenoarch/icons/xenoarch_items.dmi'

// HAMMERS

/obj/item/xenoarch/hammer
	name = "parent dev item"
	var/dig_amount = 1
	var/dig_speed = 1 SECONDS
	var/advanced = FALSE

/obj/item/xenoarch/hammer/examine(mob/user)
	. = ..()
	if(advanced)
		to_chat(user, "This is an advanced hammer. It can change its digging depth from 1 to 30. Click to change depth.")
	to_chat(user, "Current Digging Depth: [dig_amount]cm")

/obj/item/xenoarch/hammer/attack_self(mob/user, modifiers)
	. = ..()
	if(!advanced)
		to_chat(user, "This is not an advanced hammer, it cannot change its digging depth.")
		return
	var/user_choice = input(user, "Choose the digging depth. 1 to 30", "Digging Depth Selection") as null|num
	if(!user_choice)
		dig_amount = 1
		dig_speed = 1
		return
	if(dig_amount <= 0)
		dig_amount = 1
		dig_speed = 1
		return
	var/round_dig = round(user_choice)
	if(round_dig >= 30)
		dig_amount = 30
		dig_speed = 30
		return
	dig_amount = round_dig
	dig_speed = round_dig
	to_chat(user, "You change the hammer's digging depth to [round_dig]cm.")

/obj/item/xenoarch/hammer/cm1
	name = "Hammer (1cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer1"
	dig_amount = 1
	dig_speed = 0.5 SECONDS

/obj/item/xenoarch/hammer/cm2
	name = "Hammer (2cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer2"
	dig_amount = 2
	dig_speed = 1 SECONDS

/obj/item/xenoarch/hammer/cm3
	name = "Hammer (3cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer3"
	dig_amount = 3
	dig_speed = 1.5 SECONDS

/obj/item/xenoarch/hammer/cm5
	name = "Hammer (5cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer5"
	dig_amount = 5
	dig_speed = 2.5 SECONDS

/obj/item/xenoarch/hammer/cm10
	name = "Hammer (10cm)"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "hammer10"
	dig_amount = 10
	dig_speed = 5 SECONDS

/obj/item/xenoarch/hammer/adv
	name = "advanced hammer"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	icon_state = "adv_hammer"
	dig_amount = 1
	dig_speed = 0.5
	advanced = TRUE

// BRUSHES

/obj/item/xenoarch/brush
	name = "brush"
	desc = "A brush that is used to uncover the secrets of the past from strange rocks."
	var/dig_speed = 3 SECONDS
	icon_state = "brush"

/obj/item/xenoarch/brush/adv
	name = "advanced brush"
	dig_speed = 3
	icon_state = "adv_brush"

// MISC.

/obj/item/xenoarch/tape_measure
	name = "measuring tape"
	desc = "A measuring tape specifically produced to measure the depth that has been dug into strange rocks."
	icon_state = "tape"

/obj/item/storage/belt/utility/xenoarch
	name = "xenoarch toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	content_overlays = FALSE

/obj/item/storage/belt/utility/xenoarch/Initialize()
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage  = 8
	atom_storage.set_holdable(list(
		/obj/item/xenoarch/hammer,
		/obj/item/xenoarch/brush,
		/obj/item/xenoarch/tape_measure,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/mining_scanner
		))

/obj/item/storage/bag/xenoarch
	name = "xenoarch mining satchel"
	desc = "This little bugger can be used to store and transport strange rocks."
	icon = 'monkestation/code/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/mob/listeningTo
	var/range = null
	COOLDOWN_DECLARE(ore_bag_balloon_cooldown)

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/obj/item/storage/bag/xenoarch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE
	atom_storage.max_total_storage = 15
	atom_storage.numerical_stacking = TRUE
	atom_storage.allow_quick_empty = TRUE
	atom_storage.allow_quick_gather = TRUE
	atom_storage.set_holdable(list(/obj/item/xenoarch/strange_rock))
	atom_storage.silent_for_user = TRUE

/obj/item/storage/bag/xenoarch/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(pickup_rocks))
	listeningTo = user

/obj/item/storage/bag/xenoarch/dropped()
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
		listeningTo = null

/obj/item/storage/bag/xenoarch/proc/pickup_rocks(mob/living/user)
	SIGNAL_HANDLER

	var/show_message = FALSE
	var/turf/tile = get_turf(user)

	if(!isturf(tile))
		return

	if(atom_storage)
		for(var/thing in tile)
			if(!is_type_in_typecache(thing, atom_storage.can_hold))
				continue
			else if(atom_storage.attempt_insert(thing, user))
				show_message = TRUE
			else
				if(!spam_protection)
					balloon_alert(user, "bag full!")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, SFX_RUSTLE, 50, TRUE)
		if(!COOLDOWN_FINISHED(src, ore_bag_balloon_cooldown))
			return

		COOLDOWN_START(src, ore_bag_balloon_cooldown, 10)
		balloon_alert(user, "scoops ore into bag")
		user.visible_message(
			span_notice("[user] scoops up the ores beneath [user.p_them()]."),
			ignored_mobs = user
			)

	spam_protection = FALSE

/obj/item/storage/bag/xenoarch/adv
	name = "advanced xenoarch mining satchel"
	icon_state = "adv_satchel"
	insert_speed = 1

/obj/item/storage/bag/xenoarch/adv/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 25

/obj/structure/closet/xenoarch
	name = "xenoarchaeology equipment locker"
	icon_state = "science"

/obj/structure/closet/xenoarch/PopulateContents()
	. = ..()
	new /obj/item/xenoarch/hammer/cm1(src)
	new /obj/item/xenoarch/hammer/cm2(src)
	new /obj/item/xenoarch/hammer/cm3(src)
	new /obj/item/xenoarch/hammer/cm5(src)
	new /obj/item/xenoarch/hammer/cm10(src)
	new /obj/item/xenoarch/brush(src)
	new /obj/item/xenoarch/tape_measure(src)
	new /obj/item/storage/bag/xenoarch(src)
	new /obj/item/storage/belt/utility/xenoarch(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/pickaxe(src)
