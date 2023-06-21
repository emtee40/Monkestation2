
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

// -----------------------------
//           Stalwart
// -----------------------------

/obj/structure/closet/crate/necropolis/stalwart
	name = "stalwart chest"

/obj/structure/closet/crate/necropolis/stalwart/PopulateContents()
	switch(rand(1,2)) // switch back to 1,2 when the spear works
		if(1)
			new /obj/item/gun/energy/plasmacutter/scatter/stalwart(src)
		if(2)
			new /obj/item/stalwartpike(src)

	new /obj/effect/spawner/random/megafauna_ore(src)

//	new /obj/item/gem/X(src)

/obj/structure/closet/crate/necropolis/stalwart/crusher
	name = "Mundane stalwart chest" // change the name when we get an actual crusher trophy for him

/obj/structure/closet/crate/necropolis/stalwart/crusher/PopulateContents()
	..()
//	new /obj/item/crusher_trophy/X(src)


// Megafauna loot


/obj/item/stalwartpike
	icon = 'monkestation/icons/obj/items_and_weapons.dmi'
	icon_state = "stalwart_spear0"
	lefthand_file = 'monkestation/icons/mob/inhands/polearms_lefthand.dmi'
	righthand_file = 'monkestation/icons/mob/inhands/polearms_righthand.dmi'
	name = "ancient control rod"
	desc = "A mysterious crystaline rod of exceptional length, humming with ancient power. Too unweildy for use in one hand."
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	max_integrity = 2000
	block_chance = 25
	reach = 3
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	item_flags = NO_BLOOD_ON_ITEM // It cleans itself! how convinient

	var/w_class_on = WEIGHT_CLASS_BULKY
	var/two_hand_force = 5
	/// List of factions we deal bonus damage to
	var/list/nemesis_factions = list(FACTION_MINING, FACTION_BOSS)
	/// Amount of damage we deal to the above factions
	var/faction_bonus_force = 0
	//var/faction_bonus_force = 55

/obj/item/stalwartpike/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = force, \
		force_wielded = two_hand_force, \
		wieldsound = 'sound/magic/summonitems_generic.ogg', \
		unwieldsound = 'sound/magic/teleport_diss.ogg', \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/// Triggered on wield of two handed item
/obj/item/stalwartpike/proc/on_wield(obj/item/source, mob/living/carbon/user)
	faction_bonus_force = 55
	w_class = w_class_on

/// Triggered on unwield of two handed item
/obj/item/stalwartpike/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	faction_bonus_force = initial(faction_bonus_force)
	w_class = initial(w_class)

/obj/item/stalwartpike/update_icon_state()
	icon_state = inhand_icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "stalwart_spear[HAS_TRAIT(src, TRAIT_WIELDED)]" : "stalwart_spear0"
	return ..()

/obj/item/stalwartpike/attack(mob/living/target, mob/living/carbon/human/user, proximity)
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)
			force += faction_bonus_force
	. = ..()
	force -= faction_bonus_force
