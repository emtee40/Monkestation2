/obj/item/stalwartpike
	icon = 'monkestation/code/modules/lavaland/megafauna/loot/icons/items_and_weapons.dmi'
	icon_state = "stalwart_spear0"
	lefthand_file = 'monkestation/code/modules/lavaland/megafauna/loot/icons/polearms_lefthand.dmi'
	righthand_file = 'monkestation/code/modules/lavaland/megafauna/loot/icons/polearms_righthand.dmi'
	name = "ancient control rod"
	desc = "A mysterious crystaline rod of exceptional length, humming with ancient power. Too unweildy for use in one hand."
	force = 0
	w_class = WEIGHT_CLASS_SMALL
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
	/// Amount of damage we deal to the above factions (changes when wielded)
	var/faction_bonus_force = 0

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
	var/enemy = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)// if we are hitting a nemesis...
			force += faction_bonus_force
			enemy = TRUE
	. = ..()
	if(enemy) // we should delete the extra force ONLY if we hit a nemesis
		force -= faction_bonus_force
