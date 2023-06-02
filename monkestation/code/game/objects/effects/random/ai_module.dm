/obj/effect/spawner/random/aimodule
	name = "AI module spawner"
	desc = "State laws human."
	icon_state = "circuit"
	spawn_loot_double = FALSE
	spawn_loot_count = 3
	spawn_loot_split = TRUE


/obj/effect/spawner/random/aimodule/syndicate
	name = "syndicate weaponized AI module spawner"
	loot = list( // lootdrop for syndicate nuclear operative owned AI Modules
		/obj/item/ai_module/core/full/consumebz
		/obj/item/ai_module/core/full/modifiedvirusprototype
		/obj/item/ai_module/core/full/onlysyndicate
		/obj/item/ai_module/core/full/virusprototype
		/obj/item/ai_module/core/full/automalf
	)
