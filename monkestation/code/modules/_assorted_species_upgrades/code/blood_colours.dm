/obj/effect/decal/cleanable/blood
	color = "#b60a0a" //Backup of a backup. Should handle when all blood instances are created and not recoloured.

/atom/transfer_mob_blood_dna(mob/living/injected_mob, should_colour)
	..()
	if(ishuman(injected_mob))
		var/mob/living/carbon/human/mob = injected_mob
		var/colour = mob.dna.species.blood_colours
		if(colour != null && should_colour == TRUE) //fast fast fast
			src.color = colour //Switch the blood-colour last moment!
		else
			src.color = "#b60a0a" //default blood color. Careful on editing this, as it has to apply to all species without blood_colours. Differs from backup for runtime/debug testing

/turf/proc/add_blood_DNA_special(list/blood_dna, list/datum/disease/diseases, var/colour) //Whenever we have a VERY SPECIFIC need
	var/obj/effect/decal/cleanable/blood/splatter/blood_splatter = locate() in src
	if(!blood_splatter)
		blood_splatter = new /obj/effect/decal/cleanable/blood/splatter(src, diseases)
		if(colour != null)
			blood_splatter.color = colour
		else
			blood_splatter.color = "#b60a0a"
	if(!QDELETED(blood_splatter))
		blood_splatter.add_blood_DNA(blood_dna) //give blood info to the blood decal.
		if(colour != null)
			blood_splatter.color = colour
		else
			blood_splatter.color = "#b60a0a"
		return TRUE //we bloodied the floor
	return FALSE

/obj/effect/decal/cleanable/blood/dry()
	..()
	if(src.color == null) //uncoloured
		src.color = "#ac0e0e" //Fallback to ensure mapped blood will ALWAYS be red, without potentially causing problems for species-based blood
