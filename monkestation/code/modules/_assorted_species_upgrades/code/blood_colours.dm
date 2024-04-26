/atom/transfer_mob_blood_dna(mob/living/injected_mob, should_colour)
	..()
	if(ishuman(injected_mob))
		var/mob/living/carbon/human/mob = injected_mob
		var/colour = mob.dna.species.blood_colours
		if(!(colour == null) && should_colour == TRUE) //fast fast fast
			src.color = colour //Switch the blood-colour last moment!
		else
			src.color = "#ff0a0a" //default blood color. Careful on editing this, as it has to apply to all species without blood_colours

/obj/effect/decal/cleanable/blood
	color = "#ff0a0a" //FALLBACK incase blood doesn't call transfer_mob_blood_dna, e.g mapped blood.
