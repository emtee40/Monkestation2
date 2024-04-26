/atom/transfer_mob_blood_dna(mob/living/injected_mob, should_colour)
	..()
	if(ishuman(injected_mob))
		var/mob/living/carbon/human/mob = injected_mob
		var/colour = mob.dna.species.blood_colours
		if(!(colour == null) && should_colour == TRUE) //fast fast fast
			src.color = colour //curse of british upon you
		else
			src.color = "#cc1111" //default blood color
