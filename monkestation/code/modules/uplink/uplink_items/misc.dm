/datum/uplink_item/device_tools/syndie_glue
	name = "Glue"
	desc = "A cheap bottle of one use syndicate brand super glue. \
			Use on any item to make it undroppable. \
			Be careful not to glue an item you're already holding!"
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	item = /obj/item/syndie_glue
	cost = 2

/datum/uplink_item/device_tools/neutered_borer_egg
	name = "Neutered borer egg"
	desc = "A borer egg specifically bred to aid operatives. \
			It will obey every command and protect whatever operative they first see when hatched. \
			Unfortunately due to extreme radiation exposure, they cannot reproduce."
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/neutered
	cost = 20

/datum/uplink_item/device_tools/borer_egg
	name = "Hive queen borer egg"
	desc = "A borer egg of a queen we captured and safely stored away. \
			Be warned, the borer queen is not necessarily allied to you."
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	item = /obj/effect/mob_spawn/ghost_role/borer_egg
	cost = 30
