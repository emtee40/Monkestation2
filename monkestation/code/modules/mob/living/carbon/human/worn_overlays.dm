/**
 * Setup the final version of accessory_overlay given custom species options.
 */
/obj/item/clothing/under/proc/modify_accessory_overlay()
	if(!ishuman(loc))
		return accessory_overlay

	//var/mob/living/carbon/human/human_wearer = loc


	// Apply an offset only if we didn't apply a different appearance.
	/* if(OFFSET_ACCESSORY in human_wearer.dna.species.offset_features)
		accessory_overlay.pixel_x = human_wearer.dna.species.offset_features[OFFSET_ACCESSORY][1]
		accessory_overlay.pixel_y = human_wearer.dna.species.offset_features[OFFSET_ACCESSORY][2]
	else
		accessory_overlay.pixel_x = 0
		accessory_overlay.pixel_y = 0 */
// Look, this is currently unused, I dont know what it is intended to be used for but use
// /mob/living/carbon/human/update_worn_id() in code\modules\mob\living\carbon\human\human_update_icons.dm as a template i guess
	return accessory_overlay
