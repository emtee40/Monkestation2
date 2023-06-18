
// Gems dropped by megafauna and rare mobs (magmawing watchers and such)

/obj/item/gem
	name = "\improper Gem"
	desc = "Oooh! Shiny!"
	icon = 'monkestation/icons/obj/gems.dmi'
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
	shine_overlay = image(icon = 'monkestation/icons/obj/gems.dmi',icon_state = "shine")
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
//	var/list/gems = typesof(/obj/item/gem)
//	new gems

/// un-used gems
	new /obj/item/gem/ruby(src)
	new /obj/item/gem/sapphire(src)
	new /obj/item/gem/emerald(src)
	new /obj/item/gem/topaz(src)
/// Basic mob gems
	new /obj/item/gem/rupee(src)
	new /obj/item/gem/magma(src)
	new /obj/item/gem/diamond(src)
/// Lavaland megafauna gems
	new /obj/item/gem/phoron(src)     // blood-drunk's
	new /obj/item/gem/purple(src)     // hierophant's
	new /obj/item/gem/amber(src)      // ashdrake's
	new /obj/item/gem/void(src)       // collosus's
	new /obj/item/gem/bloodstone(src) // bubblegum's
	new /obj/item/gem/dark(src)       // King goat's
//	new /obj/item/gem/X(src)       // X's
/// Icebox megafauna gems
	new /obj/item/gem/brass(src)      // Clockwork Defender's
	new /obj/item/gem/bananium(src)   // wendigo's
	new /obj/item/gem/demon(src)      // frost miner's
/// Boosted holographic gems
	new /obj/item/gem/phoron/refined(src)     // blood-drunk's
	new /obj/item/gem/purple/refined(src)     // hierophant's
	new /obj/item/gem/amber/refined(src)      // ashdrake's
	new /obj/item/gem/void/refined(src)       // collosus's
	new /obj/item/gem/bloodstone/refined(src) // bubblegum's
	new /obj/item/gem/dark/refined(src)       // King goat's
//	new /obj/item/gem/X/refined(src)       // X's

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

// -----------------------------
//        Basic mob gems
// -----------------------------

/obj/item/gem/rupee
	name = "\improper Ruperium Crystal"
	desc = "A radioactive, crystalline compound rarely found in the goldgrubs. While able to be cut into sheets of uranium, the mineral's true value is in its resonating, humming properties, often sought out by ethereal musicians to work into their gem-encrusted instruments. As a result, they fetch a fine price in most exchanges."
	icon_state = "rupee"
	sheet_type = /obj/item/stack/sheet/mineral/uranium{amount = 10}
	point_value = 300

/obj/item/gem/magma
	name = "\improper Calcified Auric"
	desc = "A hot, lightly glowing mineral born from the inner workings of magmawing watchers. It is most commonly smelted down into deposits of pure gold. However, it also possesses powerful conductivity, leading some to believe it a major power component utilized by the Vxtvul Empire."
	icon_state = "magma"
	sheet_type = /obj/item/stack/sheet/mineral/gold{amount = 25}
	point_value = 450
	light_range = 2
	light_power = 1
	light_color = "#ff7b00"

/obj/item/gem/diamond
	name = "\improper Frost Diamond"
	desc = "A unique diamond that is produced within icewing watchers. Rarely used in traditional marriage bands, various gemstone companies now try to effect a monopoly on it, to little success. It looks like it can be cut into smaller sheets of diamond ore."
	icon_state = "diamond"
	sheet_type = /obj/item/stack/sheet/mineral/diamond{amount = 15}
	point_value = 750

// -----------------------------
//    Lavaland Megafauna gems
// -----------------------------

/obj/item/gem/phoron // blood-drunk's
	name = "\improper Stabilized Baroxuldium"
	desc = "A soft, glowing crystal only found in the deepest veins of plasma. Famed for its exceptional durability and uncommon beauty: widely considered to be a jackpot by mining crews. It looks like it could be destructively analyzed to extract the condensed materials within."
	icon_state = "phoron"
	sheet_type = /obj/item/stack/sheet/mineral/plasma{amount = 50}
	point_value = 1200
	light_range = 2
	light_power = 2
	light_color = "#62326a"

/obj/item/gem/purple // hierophant's
	name = "\improper Densified Dilithium"
	desc = "A strange mass of dilithium which pulses to a steady rhythm. Its strange surface exudes a unique radio signal detectable by GPS. It looks like it could be destructively analyzed to extract the condensed materials within...\
	actually upon closer inspection it appears its just colored purple glass, what a scam"
	icon_state = "purple"
	sheet_type = /obj/item/stack/sheet/glass{amount = 500} // im sorry, we dont have dilithium and there is no good replacement. So have 500 sheets of glass instead
	point_value = 1600
	light_range = 2
	light_power = 1
	light_color = "#b714cc"

	var/obj/item/gps/internal //stolen from the yog's world anvil

/obj/item/gem/purple/Initialize()
	. = ..()
	internal = new /obj/item/gps/internal/purple(src)

/obj/item/gps/internal/purple
	icon_state = null
	gpstag = "Harmonic Signal"
	desc = "It's ringing."
	invisibility = 100

/obj/item/gem/amber // ashdrake's
	name = "\improper Draconic Amber"
	desc = "A brittle, strange mineral that forms when an ash drake's blood hardens after death. Cherished by gemcutters for its faint glow and unique, soft warmth. Poacher tales whisper of the dragon's strength being bestowed to one that wears a necklace of this amber, though such rumors are fictitious."
	icon_state = "amber"
	sheet_type = /obj/item/stack/sheet/mineral/gold{amount = 50}
	point_value = 1600
	light_range = 2
	light_power = 2
	light_color = "#FFBF00"

/obj/item/gem/void // collosus's
	name = "\improper Null Crystal"
	desc = "A shard of stellar, crystallized energy. These strange objects occasionally appear spontaneously in areas where the bluespace fabric is largely unstable. Its surface gives a light jolt to those who touch it. Despite its size, it's absurdly light."
	icon_state = "void"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal{amount = 20}
	point_value = 1800
	light_range = 2
	light_power = 1
	light_color = "#4785a4"

/obj/item/gem/bloodstone // bubblegum's
	name = "\improper Ichorium"
	desc = "A weird, sticky substance, known to coalesce in the presence of otherwordly phenomena. While shunned by most spiritual groups, this gemstone has unique ties to the occult which find it handsomely valued by mysterious patrons."
	icon_state = "red"
	sheet_type = /obj/item/stack/sheet/runed_metal{amount = 25} // its only use is golems, you can already get runed metal from the lavaland cult ruin so it shouldnt be that big of a deal
	point_value = 2000
	light_range = 2
	light_power = 3
	light_color = "#800000"

/obj/item/gem/dark
	name = "\improper Dark Salt Lick"
	desc = "An ominous cylinder that glows with an unnerving aura, seeming to hungrily draw in the space around it. The round edges of the lick are uneven patches of rough texture. Its only known property is that of anti-magic."
	icon_state = "dark"
	point_value = 3000
	light_range = 3
	light_power = 3
	light_color = "#380a41"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gem/dark/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

// -----------------------------
//    Icebox Megafauna gems
// -----------------------------

/obj/item/gem/brass // Clockwork Defender's
	name = "\improper Densified Brass"
	desc = "Rat'vars influence over this world has been longer than any species may ever comprehend, yet nar'sie finally banished rat'var into his realm. Locking him out of this world.The clockwork defender's powersource was this gem you extracted, its still vibrant with energy"
	icon_state = "brass"
	sheet_type = /obj/item/stack/sheet/bronze{amount = 150} // its basically worse iron, lets give them a good bit of it
	point_value = 1000
	light_range = 4
	light_power = 4
	light_color = "#FFBF00"

/obj/item/gem/bananium // wendigo's
	name = "\improper Condensed Bananium"
	desc = "Wendigo's famously feed on humans, this one seems to have been a primarily clown diet resulting in bananium atmos condensing themselfes in their stomach. This gem is the result"
	icon_state = "magma"
	sheet_type = /obj/item/stack/sheet/mineral/bananium{amount = 10}
	point_value = 1800
	light_range = 3
	light_power = 1
	light_color = "#ffee00"

/obj/item/gem/demon // frost miner's
	name = "\improper Demon Core"
	desc = "A gem extracted from the core of a demon, its primary use is to negate any magic the enemy may have. Seems to not work against miner nanotrasen weaponry"
	icon_state = "void"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal{amount = 50}
	point_value = 3000
	light_range = 3
	light_power = 3
	light_color = "#380a41"

/obj/item/gem/demon/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

// -----------------------------------
//   Boosted megafauna lavaland gems
// -----------------------------------

/obj/item/gem/phoron/refined     // blood-drunk's
	name = "\improper Refined Stabilized Baroxuldium"

/obj/item/gem/purple/refined     // hierophant's
	name = "\improper Refined Densified Dilithium"

/obj/item/gem/amber/refined     // ashdrake's
	name = "\improper Refined Draconic Amber"

/obj/item/gem/void/refined      // collosus's
	name = "\improper Refined Null Crystal"

/obj/item/gem/bloodstone/refined // bubblegum's
	name = "\improper Refined Ichorium"

/obj/item/gem/dark/refined // bubblegum's
	name = "\improper Refined Dark Salt Lick"


/*

/obj/item/gem/dark/refined      // King goat's


/obj/item/gem/X/refined       // X's


*/
