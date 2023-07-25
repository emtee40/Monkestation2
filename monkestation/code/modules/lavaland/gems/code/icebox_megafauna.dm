/**
 * This file contains all gems that can be obtained on icebox via killing megafauna
 */

/obj/item/gem/brass // Clockwork Defender's
	name = "\improper Densified Brass"
	desc = "Rat'vars influence over this world has been longer than any species may ever comprehend, yet nar'sie finally banished rat'var into his realm. Locking him out of this world.The clockwork defender's powersource was this gem you extracted, its still vibrant with energy"
	icon_state = "brass"
	sheet_type = /obj/item/stack/sheet/bronze{amount = 150} // its basically worse iron, lets give them a good bit of it
	point_value = 1000
	light_outer_range = 4
	light_power = 4
	light_color = "#FFBF00"

/obj/item/gem/bananium // wendigo's
	name = "\improper Condensed Bananium"
	desc = "Wendigo's famously feed on humans, this one seems to have been a primarily clown diet resulting in bananium atmos condensing themselfes in their stomach. This gem is the result"
	icon_state = "magma"
	sheet_type = /obj/item/stack/sheet/mineral/bananium{amount = 10}
	point_value = 1800
	light_outer_range = 3
	light_power = 1
	light_color = "#ffee00"

/obj/item/gem/demon // frost miner's
	name = "\improper Demon Core"
	desc = "A gem extracted from the core of a demon, its primary use is to negate any magic the enemy may have. Seems to not work against miner nanotrasen weaponry"
	icon_state = "void"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal{amount = 50}
	point_value = 3000
	light_outer_range = 3
	light_power = 3
	light_color = "#380a41"

/obj/item/gem/demon/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)
