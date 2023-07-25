/**
 * This file contains all gems that can be obtained on lavaland via killing megafauna
 */

/obj/item/gem/phoron // blood-drunk's
	name = "\improper Stabilized Baroxuldium"
	desc = "A soft, glowing crystal only found in the deepest veins of plasma. Famed for its exceptional durability and uncommon beauty: widely considered to be a jackpot by mining crews. It looks like it could be destructively analyzed to extract the condensed materials within."
	icon_state = "phoron"
	sheet_type = /obj/item/stack/sheet/mineral/plasma{amount = 50}
	point_value = 1200
	light_outer_range = 2
	light_power = 2
	light_color = "#62326a"

/obj/item/gem/purple // hierophant's
	name = "\improper Densified Dilithium"
	desc = "A strange mass of dilithium which pulses to a steady rhythm. Its strange surface exudes a unique radio signal detectable by GPS. It looks like it could be destructively analyzed to extract the condensed materials within...\
	actually upon closer inspection it appears its just colored purple glass, what a scam"
	icon_state = "purple"
	sheet_type = /obj/item/stack/sheet/glass{amount = 500} // im sorry, we dont have dilithium and there is no good replacement. So have 500 sheets of glass instead
	point_value = 1600
	light_outer_range = 2
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
	light_outer_range = 2
	light_power = 2
	light_color = "#FFBF00"

/obj/item/gem/void // collosus's
	name = "\improper Null Crystal"
	desc = "A shard of stellar, crystallized energy. These strange objects occasionally appear spontaneously in areas where the bluespace fabric is largely unstable. Its surface gives a light jolt to those who touch it. Despite its size, it's absurdly light."
	icon_state = "void"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal{amount = 20}
	point_value = 1800
	light_outer_range = 2
	light_power = 1
	light_color = "#4785a4"

/obj/item/gem/bloodstone // bubblegum's
	name = "\improper Ichorium"
	desc = "A weird, sticky substance, known to coalesce in the presence of otherwordly phenomena. While shunned by most spiritual groups, this gemstone has unique ties to the occult which find it handsomely valued by mysterious patrons."
	icon_state = "red"
	sheet_type = /obj/item/stack/sheet/runed_metal{amount = 25} // its only use is golems, you can already get runed metal from the lavaland cult ruin so it shouldnt be that big of a deal
	point_value = 2000
	light_outer_range = 2
	light_power = 3
	light_color = "#800000"

/obj/item/gem/data // bubblegum's
	name = "\improper Bluespace Data Crystal"
	desc = "A large bluespace crystal, etched internally with nano-circuits, it seemingly draws power from nowhere. Once acting as the brain of the Stalwart."
	icon_state = "cpu"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal{amount = 20}
	point_value = 2000
	light_outer_range = 2
	light_power = 6
	light_color = "#0004ff"
