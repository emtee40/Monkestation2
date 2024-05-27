/datum/crafting_recipe/lance
	name = "Explosive Lance (Grenade)"
	result = /obj/item/spear/explosive
	reqs = list(
		/obj/item/spear = 1,
		/obj/item/grenade = 1
	)
	blacklist = list(/obj/item/spear/bonespear, /obj/item/spear/bamboospear)
	parts = list(
		/obj/item/spear = 1,
		/obj/item/grenade = 1
	)
	time = 1.5 SECONDS
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/pipegun_prime
	reqs = list(
		/obj/item/gun/ballistic/rifle/boltaction/pipegun = 1,
		/obj/item/food/deadmouse = 1,
		/datum/reagent/consumable/grey_bull = 20,
		/obj/item/storage/toolbox = 1,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	tool_paths = list(/obj/item/spear = 1)
	time = 20 SECONDS //contemplate for a bit
	
/datum/crafting_recipe/laser_musket_prime
	time = 20

/datum/crafting_recipe/smoothbore_disabler_prime
	reqs = list(
		/obj/item/gun/energy/disabler/smoothbore = 1,
		/obj/item/stack/sheet/mineral/gold = 5,
		/obj/item/stock_parts/cell/super = 1,
	)

/datum/crafting_recipe/riflestock
	tool_behaviors = list(TOOL_KNIFE)
