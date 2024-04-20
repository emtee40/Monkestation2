/datum/bounty/item/virus // Monkestation Edit: Dish
	reward = CARGO_CRATE_VALUE * 10
	//var/shipped = FALSE Monkesation Removal: Item
	//var/stat_value = 0 Monkestation Removal: no stats
	//var/stat_name = "" Monkestation Removal: no stats
	var/datum/symptom/requested_symptom

/datum/bounty/item/virus/New() // Monkestation Edit: Dish
	..()
	/* Monkestation Removal: no stats
	stat_value = rand(4, 11)
	if(rand(3) == 1)
		stat_value *= -1
	name = "Virus ([stat_name] of [stat_value])"
	description = "Nanotrasen is interested in a virus with a [stat_name] stat of exactly [stat_value]. Central Command will pay handsomely for such a virus."
	End Monkestation Removal */
	// Monkestation Addition: CC wants dishes
	requested_symptom = randomize_symptom()
	name = "Virus ([requested_symptom.name])"
	description = "Nanotrasen is interested in a virus with [requested_symptom.name] as a symptom. Central Command will pay handsomely for such a virus dish."
	// End Monkestation Addition
	reward += rand(0, 4) * CARGO_CRATE_VALUE

//Monkestation Addition: get a random symptom
/datum/bounty/item/virus/proc/randomize_symptom()
	var/datum/symptom/symptom = pick(subtypesof(/datum/symptom))
	if(symptom.restricted)
		symptom = randomize_symptom()
	return symptom
// End Monkestation Addition

/* Monkestation Removal: Dish
/datum/bounty/item/virus/can_claim()
	return ..() && shipped
End Monkesation Removal */

/datum/bounty/item/virus/applies_to(obj/O) // Monkestation Edit: Dish
/* Monkestation Removal: Dish
	if(shipped)
		return FALSE
End Monkesation Removal */
	if(O.flags_1 & HOLOGRAM_1)
		return FALSE
	/* Monkestation Removal: no stats
	if(!istype(O, /obj/item/reagent_containers || !O.reagents || !O.reagents.reagent_list))
		return FALSE
	var/datum/reagent/blood/B = locate() in O.reagents.reagent_list
	if(!B)
		return FALSE
	for(var/V in B.get_diseases())
		if(!istype(V, /datum/disease/advance))
			continue
		if(accepts_virus(V))
			return TRUE
	End Monkestation Removal */
	//Monkestation Addition: Send in dishes
	if(istype(O, /obj/item/weapon/virusdish))
		var/obj/item/weapon/virusdish/dish = O
		if(accepts_virus(dish.contained_virus))
			return TRUE
	//End Monkestation Addition
	return FALSE

/datum/bounty/item/virus/ship(obj/O) // Monkestation Edit: Dish
	if(!applies_to(O))
		return
	//shipped = TRUE Monkestation Removal: Dish
	shipped_count += 1 // Monkestation Addition: Dish

/datum/bounty/item/virus/proc/accepts_virus(V) // Monkestation Edit: Dish
	//return TRUE Monkestation Removal: Check for symptom
	var/datum/disease/advance/A = V
	for(var/datum/symptom/symptom in A.symptoms)
		if(symptom.name == requested_symptom.name)
			return TRUE
	return FALSE

/* Monkestation Removal: no stats
/datum/bounty/virus/resistance
	stat_name = "resistance"

/datum/bounty/virus/resistance/accepts_virus(V)
	var/datum/disease/advance/A = V
	return A.totalResistance() == stat_value

/datum/bounty/virus/stage_speed
	stat_name = "stage speed"

/datum/bounty/virus/stage_speed/accepts_virus(V)
	var/datum/disease/advance/A = V
	return A.totalStageSpeed() == stat_value

/datum/bounty/virus/stealth
	stat_name = "stealth"

/datum/bounty/virus/stealth/accepts_virus(V)
	var/datum/disease/advance/A = V
	return A.totalStealth() == stat_value

/datum/bounty/virus/transmit
	stat_name = "transmissible"

/datum/bounty/virus/transmit/accepts_virus(V)
	var/datum/disease/advance/A = V
	return A.totalTransmittable() == stat_value
Monkestation Removal: no stats */
