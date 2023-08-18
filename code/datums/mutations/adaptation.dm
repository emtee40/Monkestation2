/datum/mutation/human/space_adaptation //Monkestation Edit #176
	name = "Space Adaptation" //Monkestation Edit #176
	desc = "A strange mutation that renders the host immune to damage low temperature and pressure found in space." //Monkestation Edit #176
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>Your body feels warm!</span>"
	instability = 35
	//Monkestation Edit #176 conflict removed

/datum/mutation/human/space_adaptation/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut) //Monkestation Edit #176
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "fire", -MUTATIONS_LAYER))

/datum/mutation/human/space_adaptation/get_visual_indicator() //Monkestation Edit #176
	return visual_indicators[type][1]

/datum/mutation/human/space_adaptation/on_acquiring(mob/living/carbon/human/owner) //Monkestation Edit #176
	if(..())
		return
	owner.add_traits(list(TRAIT_RESISTCOLD, TRAIT_RESISTLOWPRESSURE), GENETIC_MUTATION) //Monkestation Edit #176

/datum/mutation/human/space_adaptation/on_losing(mob/living/carbon/human/owner) //Monkestation Edit #176
	if(..())
		return
	owner.remove_traits(list(TRAIT_RESISTCOLD,TRAIT_RESISTLOWPRESSURE), GENETIC_MUTATION) //Monkestation Edit #176

/datum/mutation/human/extreme_adaptation //Monkestation Edit #176
	name = "Extreme Adaptation" //Monkestation Edit #176
	desc = "A strange mutation that renders the host immune to damage from high temperatures and pressure." //Monkestation Edit #176
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>Your body feels warm!</span>"
	instability = 35
	//Monkestation Edit #176 conflict removed

/datum/mutation/human/extreme_adaptation/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut) //Monkestation Edit #176
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "fire", -MUTATIONS_LAYER))

/datum/mutation/human/extreme_adaptation/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/human/extreme_adaptation/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.add_traits(list(TRAIT_RESISTHEAT, TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION) //Monkestation Edit #176

/datum/mutation/human/extreme_adaptation/on_losing(mob/living/carbon/human/owner) //Monkestation Edit #176
	if(..())
		return
	owner.remove_traits(list(TRAIT_RESISTHEAT,TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION) //Monkestation Edit #176
