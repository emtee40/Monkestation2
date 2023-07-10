/datum/mutation/human/Space_adaptation
	name = "Space Adaptation"
	desc = "A strange mutation that renders the host immune to damage from extreme temperatures and pressure."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>Your body feels warm!</span>"
	instability = 35

/datum/mutation/human/Space_adaptation/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "fire", -MUTATIONS_LAYER))

/datum/mutation/human/Space_adaptation/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/human/Space_adaptation/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.add_traits(list(TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION)

/datum/mutation/human/Space_adaptation/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.remove_traits(list(TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION)
