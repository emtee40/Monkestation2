/obj/item/seeds/watermelon/honeydew
	name = "pack of honeydew melon seeds"
	desc = "These seeds grow into sweet honeydew melon plants."
	icon_state = "seed-honeydew"
	species = "honeydew"
	plantname = "Honeydew Melon Vines"
	product = /obj/item/food/grown/honeydew
	lifespan = 60
	endurance = 40
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.1, /datum/reagent/consumable/nutriment = 0.15)
	rarity = 20
	graft_gene = /datum/plant_gene/trait/repeated_harvest

/obj/item/food/grown/honeydew
	seed = /obj/item/seeds/watermelon/honeydew
	desc = "A sweet melon variant that, bizarrely, distills into honey."
	icon_state = "honeydew"
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/consumable/honey
