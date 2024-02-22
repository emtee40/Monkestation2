/datum/reagent/consumable/ethanol/wine_voltaic
	name = "Voltaic Yellow Wine"
	description = "Electrically charged wine. Recharges etherials, but also nontoxic."
	boozepwr = 30
	color = "#FFAA00"
	taste_description = "static with a hint of sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/wine_voltaic
	required_drink_type = /datum/reagent/consumable/ethanol/wine_voltaic
	name = "Voltaic Yellow Wine"
	desc = "Electrically charged wine. Recharges etherials, but also nontoxic."
	icon = 'monkestation/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "wine_voltaic"

/datum/reagent/consumable/ethanol/wine_voltaic/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/internal/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 3)

/datum/reagent/consumable/ethanol/telepole
	name = "Telepole"
	description = "A grounding rod in the form of a drink.  Recharges etherials, and gives temporary shock resistance."
	boozepwr = 50
	color = "#b300ff"
	quality = DRINK_NICE
	taste_description = "the howling storm"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/telepole
	required_drink_type = /datum/reagent/consumable/ethanol/telepole
	name = "Telepole"
	desc = "A liquid grounding rod. Recharges etherials and grants temporary shock resistance."
	icon = 'monkestation/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "telepole"

/datum/reagent/consumable/ethanol/telepole/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	ADD_TRAIT(affected_mob, TRAIT_SHOCKIMMUNE, type)

/datum/reagent/consumable/ethanol/telepole/on_mob_end_metabolize(mob/living/affected_mob)
	REMOVE_TRAIT(affected_mob, TRAIT_SHOCKIMMUNE, type)
	return ..()

/datum/reagent/consumable/ethanol/telepole/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/internal/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 2)

/datum/reagent/consumable/ethanol/pod_tesla
	name = "Pod Tesla"
	description = "Ride the lightning!  Recharges etherials, suppresses phobias, and gives strong temporary shock resistance."
	boozepwr = 80
	color = "#00fbff"
	quality = DRINK_FANTASTIC
	taste_description = "victory, with a hint of insanity"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/pod_tesla
	required_drink_type = /datum/reagent/consumable/ethanol/pod_tesla
	name = "Pod Tesla"
	desc = "Ride the lightning! Recharges etherials, suppresses phobias, and grants strong temporary shock resistance."
	icon = 'monkestation/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pod_tesla"

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_metabolize(mob/living/affected_mob)
	..()
	affected_mob.add_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_end_metabolize(mob/living/affected_mob)
	..()
	affected_mob.remove_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/internal/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 5)
