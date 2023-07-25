
// Gems dropped by megafauna and rare mobs (magmawing watchers and such)

/obj/item/gem
	name = "\improper Gem"
	desc = "Oooh! Shiny!"
	icon = 'monkestation/code/modules/lavaland/gems/icons/gems.dmi'
	icon_state = "rupee"
	w_class = WEIGHT_CLASS_SMALL

	///Have we been analysed with an ID card?
	var/analysed = FALSE
	///How many points we grant to the person who claimed us.
	var/point_value = 100
	///the thing that spawns in the item.
	var/sheet_type = /obj/item/stack/sheet/iron{amount = 1} // tactical iron failsafe
	//shows this overlay when not scanned.
	var/image/shine_overlay

/obj/item/gem/Initialize()
	. = ..()
	shine_overlay = image(icon = 'monkestation/code/modules/lavaland/gems/icons/gems.dmi',icon_state = "shine")
	add_overlay(shine_overlay)
	pixel_x = rand(-8,8)
	pixel_y = rand(-8,8)

/obj/item/gem/examine(mob/user)
	. = ..()
	. += span_notice("Its value of [point_value] mining points can be registered by hitting it with an ID.")

/obj/item/gem/attackby(obj/item/item, mob/living/user, params) //Stolen directly from geysers, removed the internal gps
	if(!istype(item, /obj/item/card/id))
		return ..()

	if(analysed)
		to_chat(user, span_warning("This gem has already been analysed!"))
		return

	to_chat(user, span_notice("You analyse the precious gemstone!"))

	analysed = TRUE

	if(shine_overlay)
		cut_overlay(shine_overlay)
		qdel(shine_overlay)

	if(isliving(user))
		var/mob/living/living = user

		var/obj/item/card/id/card = living.get_idcard()
		if(card)
			to_chat(user, span_notice("[point_value] mining points have been paid out!"))
			card.registered_account.mining_points += point_value
			playsound(src, 'sound/machines/ping.ogg', 15, TRUE)

/obj/item/gem/welder_act(mob/living/user, obj/item/I) //Jank code that detects if the gem in question has a sheet_type and spawns the items specifed in it
	if(I.use_tool(src, user, 0, volume=50))
		new src.sheet_type(user.loc)
		to_chat(user, span_notice("You carefully cut [src]."))
		qdel(src)
	return TRUE

/obj/structure/closet/crate/necropolis/debug_gems // Used to get all the gems at once for debugging purposes
	name = "Debug gem chest"

/obj/structure/closet/crate/necropolis/debug_gems/PopulateContents()
	for(var/gem in subtypesof(/obj/item/gem)) // gives all gems
		new gem(src)

// -----------------------------
//         Un-used gems
// -----------------------------

/obj/item/gem/ruby
	name = "\improper Ruby"
	icon_state = "ruby"
	point_value = 200

/obj/item/gem/sapphire
	name = "\improper Sapphire"
	icon_state = "sapphire"
	point_value = 200

/obj/item/gem/emerald
	name = "\improper Emerald"
	icon_state = "emerald"
	point_value = 200

/obj/item/gem/topaz
	name = "\improper Topaz"
	icon_state = "topaz"
	point_value = 200

/obj/item/gem/dark
	name = "\improper Dark Salt Lick"
	desc = "An ominous cylinder that glows with an unnerving aura, seeming to hungrily draw in the space around it. The round edges of the lick are uneven patches of rough texture. Its only known property is that of anti-magic."
	icon_state = "dark"
	point_value = 3000
	light_outer_range = 3
	light_power = 3
	light_color = "#380a41"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gem/dark/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)
