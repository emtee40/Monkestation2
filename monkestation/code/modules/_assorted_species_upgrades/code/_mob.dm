//handles species upgrades
/datum/species
	var/uses_offsets = FALSE //This will determine if the offset system is active or not.
	var/blood_colours = "#b60a0a" //This is the default blood colour used by the backup blood system. Until changed on subtypes, this is what is used to handle bleeding.

/datum/species/lizard
	blood_colours = "#476d0a"

/// Updates features and clothing attached to a specific limb with limb-specific offsets


/mob/living/carbon/proc/update_features(feature_key) //absolutely vital this loads first
	switch(feature_key)
		if(OFFSET_UNIFORM)
			update_worn_undersuit()
		if(OFFSET_ID)
			update_worn_id()
		if(OFFSET_GLOVES)
			update_worn_gloves()
		if(OFFSET_GLASSES)
			update_worn_glasses()
		if(OFFSET_EARS)
			update_inv_ears() //why is this inv_ears
		if(OFFSET_SHOES)
			update_worn_shoes()
		if(OFFSET_S_STORE)
			update_suit_storage()
		if(OFFSET_FACEMASK)
			update_worn_mask()
		if(OFFSET_HEAD)
			update_worn_head()
		if(OFFSET_FACE)
			dna?.species?.handle_body(src) // updates eye icon
			update_worn_mask()
		if(OFFSET_BELT)
			update_worn_belt()
		if(OFFSET_BACK)
			update_worn_back()
		if(OFFSET_SUIT)
			update_worn_oversuit()
		if(OFFSET_NECK)
			update_worn_neck()
		if(OFFSET_HELD)
			update_held_items()
//Manages a ton of modular update_icons
//Why god why

/* --------------------------------------- */
// VVVV THIS CODE IS FUCKING ASS BUT MODULAR. VVVV
// REMEMBER THIS IS THE LESSER OF TWO EVILS. IT WAS THIS OR DOING A NOVA SECTOR AND REPLACING THE BASE PROCS
//vvvvvv UPDATE_INV PROCS vvvvvv

/mob/living/carbon/human/update_worn_back(update_obscured = TRUE) //We're going to the fucking asylum with this one boys. This is how you should handle all future update_ if you wish to add more than custom backpack positions.
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	remove_overlay(BACK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1]
		inv.update_icon()

	if(back)
		var/obj/item/worn_item = back
		var/mutable_appearance/back_overlay
		update_hud_back(worn_item)
		var/icon_file = 'icons/mob/clothing/back.dmi'

		var/mutant_override = FALSE
		if(dna.species.bodytype & BODYTYPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(LOADOUT_ITEM_MISC, back)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE

		back_overlay = back.build_worn_icon(default_layer = BACK_LAYER, default_icon_file = icon_file , override_file = mutant_override ? icon_file : null)
		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_back_offset?.apply_offset(back_overlay) // BILLIONS MUST ..()
		if(!back_overlay)
			return
		if(!mutant_override &&(OFFSET_BACK in dna.species.offset_features))
			back_overlay.pixel_x += dna.species.offset_features[OFFSET_BACK][1]
			back_overlay.pixel_y += dna.species.offset_features[OFFSET_BACK][2]
		overlays_standing[BACK_LAYER] = back_overlay
	apply_overlay(BACK_LAYER)


/mob/living/carbon/human/update_worn_head(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	remove_overlay(HEAD_LAYER)
	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_icon()

	if(head)
		var/obj/item/worn_item = head
		update_hud_head(worn_item)

		if(check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_HEAD)
			return

		var/icon_file = 'icons/mob/clothing/head/default.dmi' // billions must ignore checks

		var/mutable_appearance/head_overlay = head.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = icon_file)
		var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
		my_head?.worn_head_offset?.apply_offset(head_overlay)
		if((OFFSET_HEAD in dna.species.offset_features))
			head_overlay.pixel_x += dna.species.offset_features[OFFSET_HEAD][1]
			head_overlay.pixel_y += dna.species.offset_features[OFFSET_HEAD][2]
		overlays_standing[HEAD_LAYER] = head_overlay

	update_mutant_bodyparts()
	apply_overlay(HEAD_LAYER) // you should overwrite, NOW


/mob/living/carbon/human/update_worn_belt(update_obscured = TRUE)
	. = ..() //This technically doubles processing needed for nabbers but honestly I do not know how to do this any better.
	if(src.dna.species.uses_offsets == FALSE) //make sure there's no chance of a runtime on species this shouldn't be running on.
		return
	remove_overlay(BELT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BELT) + 1]
		inv.update_icon()

	if(belt)
		var/obj/item/worn_item = belt
		update_hud_belt(worn_item)

		if(check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_BELT)
			return

		var/icon_file = 'icons/mob/clothing/belt.dmi'

		var/mutant_override = FALSE
		if(dna.species.bodytype & BODYTYPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(LOADOUT_ITEM_BELT, belt)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE

		var/mutable_appearance/belt_overlay = belt.build_worn_icon(default_layer = BELT_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null)
		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_belt_offset?.apply_offset(belt_overlay)
		if(!mutant_override &&(OFFSET_BELT in dna.species.offset_features))
			belt_overlay.pixel_x += dna.species.offset_features[OFFSET_BELT][1]
			belt_overlay.pixel_y += dna.species.offset_features[OFFSET_BELT][2]
		overlays_standing[BELT_LAYER] = belt_overlay

	apply_overlay(BELT_LAYER)

/mob/living/carbon/human/update_worn_mask()
	. = ..() //This technically doubles processing needed for nabbers but honestly I do not know how to do this any better.
	if(src.dna.species.uses_offsets == FALSE) //make sure there's no chance of a runtime on species this shouldn't be running on.
		return
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_icon()

	if(wear_mask)
		var/obj/item/worn_item = wear_mask
		update_hud_wear_mask(worn_item)

		if(check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_MASK)
			return

		var/icon_file = 'icons/mob/clothing/mask.dmi'

		var/mutable_appearance/mask_overlay = wear_mask.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = icon_file)
		var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
		my_head?.worn_mask_offset?.apply_offset(mask_overlay)
		if((OFFSET_FACEMASK in dna.species.offset_features))
			mask_overlay.pixel_x += dna.species.offset_features[OFFSET_FACEMASK][1]
			mask_overlay.pixel_y += dna.species.offset_features[OFFSET_FACEMASK][2]
		overlays_standing[FACEMASK_LAYER] = mask_overlay

	apply_overlay(FACEMASK_LAYER)
	update_mutant_bodyparts() //e.g. upgate needed because mask now hides lizard snout


/*
/mob/living/carbon/human/update_worn_id(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/id_overlay = overlays_standing[ID_LAYER]
	var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
	my_chest?.worn_id_offset?.apply_offset(id_overlay)

/mob/living/carbon/human/update_worn_glasses(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/glasses_overlay = glasses.build_worn_icon(default_layer = GLASSES_LAYER)
	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	my_head.worn_glasses_offset?.apply_offset(glasses_overlay)

/mob/living/carbon/human/update_inv_ears(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/ears_overlay = ears.build_worn_icon(default_layer = EARS_LAYER)
	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	my_head.worn_ears_offset?.apply_offset(ears_overlay)

/mob/living/carbon/human/update_worn_neck(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/neck_overlay = wear_neck.build_worn_icon(default_layer = NECK_LAYER)
	var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
	my_chest?.worn_belt_offset?.apply_offset(neck_overlay)

*/
