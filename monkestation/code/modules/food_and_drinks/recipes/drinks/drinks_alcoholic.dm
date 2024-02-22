/datum/chemical_reaction/drink/telepole
	results = list(/datum/reagent/consumable/ethanol/telepole = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/wine_voltaic = 1, /datum/reagent/consumable/ethanol/dark_and_stormy = 2, /datum/reagent/consumable/ethanol/sake = 1)
	mix_message = "You swear you saw a spark fly from the glass..."

/datum/chemical_reaction/drink/pod_tesla
	results = list(/datum/reagent/consumable/ethanol/pod_tesla = 15)
	required_reagents = list(/datum/reagent/consumable/ethanol/telepole = 5, /datum/reagent/consumable/ethanol/brave_bull = 3, /datum/reagent/consumable/ethanol/admiralty = 5)
	mix_message = "Arcs of lightning fly from the mixture."
	mix_sound = 'sound/weapons/zapbang.ogg'
