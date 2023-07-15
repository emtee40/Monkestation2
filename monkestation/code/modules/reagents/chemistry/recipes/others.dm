//prevents the altering of disease symptoms
/datum/chemical_reaction/mix_virus/preserve_virus
	required_reagents = list(/datum/reagent/cryostylane = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/preserve_virus/on_reaction(datum/reagents/holder, created_volume)

	var/datum/reagent/blood/blood = locate(/datum/reagent/blood) in holder.reagent_list
	if(blood?.data)
		var/datum/disease/advance/diseasem = locate(/datum/disease/advance) in blood.data["viruses"]
		if(diseasem)
			diseasem.mutable = FALSE

//prevents the disease from spreading via symptoms
/datum/chemical_reaction/mix_virus/falter_virus
	required_reagents = list(/datum/reagent/medicine/spaceacillin = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/falter_virus/on_reaction(datum/reagents/holder, created_volume)

	var/datum/reagent/blood/blood = locate(/datum/reagent/blood) in holder.reagent_list
	if(blood?.data)
		var/datum/disease/advance/diseasem = locate(/datum/disease/advance) in blood.data["viruses"]
		if(diseasem)
			diseasem.faltered = TRUE
			diseasem.spread_flags = DISEASE_SPREAD_FALTERED
			diseasem.spread_text = "Intentional Injection"
