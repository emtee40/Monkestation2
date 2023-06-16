
/*

Template for future megafauna chests:

// -----------------------------
//              X
// -----------------------------

/obj/structure/closet/crate/necropolis/X
	name = "X chest"

/obj/structure/closet/crate/necropolis/X/PopulateContents()

	new /obj/item/X(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

//	new /obj/item/gem/X(src)

/obj/structure/closet/crate/necropolis/X/crusher
	name = "[additional word] X chest"

/obj/structure/closet/crate/necropolis/X/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/X(src)


*/

// -----------------------------
//            Legion
// -----------------------------

/obj/structure/closet/crate/necropolis/legion
	name = "legion chest"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()

	new /obj/item/storm_staff

	new /obj/effect/spawner/random/megafauna_ore(src)

//	new /obj/item/gem/X(src)

/obj/structure/closet/crate/necropolis/legion/crusher
	name = "united legion chest"

/obj/structure/closet/crate/necropolis/legion/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/malformed_bone(src)

// -----------------------------
//         Blood-drunk
// -----------------------------

/obj/structure/closet/crate/necropolis/bdm
	name = "blood-drunk miner chest"

/obj/structure/closet/crate/necropolis/bdm/PopulateContents()

	new /obj/item/melee/cleaving_saw(src)

	new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
	new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
	new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
	new /obj/item/disk/design_disk/modkit_disc/bounty(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

	new /obj/item/gem/phoron(src)

/obj/structure/closet/crate/necropolis/bdm/crusher
	name = "bloodier-drunks miner chest"

/obj/structure/closet/crate/necropolis/bdm/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/miner_eye(src)

// -----------------------------
//          Hierophant
// -----------------------------

/obj/structure/closet/crate/necropolis/hierophant
	name = "hierophant chest"

/obj/structure/closet/crate/necropolis/hierophant/PopulateContents()

	new /obj/item/hierophant_club(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

	new /obj/item/gem/purple(src)

/obj/structure/closet/crate/necropolis/hierophant/crusher
	name = "phasing hierophant chest"

/obj/structure/closet/crate/necropolis/hierophant/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/vortex_talisman(src)

// -----------------------------
//      Clockwork Defender
// -----------------------------

/obj/structure/closet/crate/necropolis/clockwork_defender
	name = "clockwork defenders chest"

/obj/structure/closet/crate/necropolis/clockwork_defender/PopulateContents()

	new /obj/item/clockwork_alloy(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

	new /obj/item/gem/brass(src)

/obj/structure/closet/crate/necropolis/clockwork_defender/crusher
	name = "Ticking clockwork defenders chest"

/obj/structure/closet/crate/necropolis/clockwork_defender/crusher/PopulateContents()
	..()
//	new /obj/item/crusher_trophy/X(src)

// -----------------------------
//           Wendigo
// -----------------------------

/obj/structure/closet/crate/necropolis/wendigo
	name = "Wendigo chest"

/obj/structure/closet/crate/necropolis/wendigo/PopulateContents()

	new /obj/item/wendigo_blood(src)
	new /obj/item/wendigo_skull(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

	new /obj/item/gem/bananium(src)

/obj/structure/closet/crate/necropolis/wendigo/crusher
	name = "bloodied wendigo chest"

/obj/structure/closet/crate/necropolis/wendigo/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/wendigo_horn(src)

// -----------------------------
//      Demonic frost miner
// -----------------------------

/obj/structure/closet/crate/necropolis/frost_miner
	name = "Demonic frost miner chest"

/obj/structure/closet/crate/necropolis/frost_miner/PopulateContents()

	new /obj/item/ice_energy_crystal(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

	new /obj/item/gem/demon(src)

/obj/structure/closet/crate/necropolis/frost_miner/crusher
	name = "Ultra-demonic frost miner chest"

/obj/structure/closet/crate/necropolis/frost_miner/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/ice_block_talisman(src)
