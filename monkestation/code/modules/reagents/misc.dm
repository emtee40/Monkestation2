/datum/reagent/romerol
	restricted = TRUE

/datum/reagent/medicine/potass_iodide
	description = "Heals low toxin damage while the patient is irradiated, and will halt the damaging effects of radiation. Can be used to decontaminate irradiated items."

/datum/reagent/medicine/potass_iodide/expose_obj(obj/item/exposed_item, reac_volume)
	. = ..()
	if(reac_volume >= 1)
		decontaminate_item(exposed_item)

/datum/reagent/medicine/potass_iodide/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf) || QDELING(exposed_turf) || reac_volume < 1)
		return
	for(var/thingymajig in exposed_turf)
		decontaminate_item(thingymajig)

/datum/reagent/medicine/potass_iodide/expose_mob(mob/living/carbon/human/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(!istype(exposed_mob) || QDELING(exposed_mob) || reac_volume < 1 || !(methods & (TOUCH | VAPOR)))
		return
	for(var/thingymajig in exposed_mob)
		decontaminate_item(thingymajig)

/proc/decontaminate_item(obj/item/thingymajig)
	if(!istype(thingymajig) || QDELING(thingymajig))
		return
	var/datum/component/irradiated/chernobyl = thingymajig.GetComponent(/datum/component/irradiated)
	if(!QDELETED(chernobyl))
		qdel(chernobyl)
