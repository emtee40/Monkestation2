//handles species upgrades
/datum/species
	var/uses_offsets = FALSE //This will determine if the offset system is active or not.

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
//vvvvvv UPDATE_INV PROCS vvvvvv

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

/mob/living/carbon/human/update_worn_head(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/head_overlay = head.build_worn_icon(default_layer = HEAD_LAYER)
	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	my_head?.worn_head_offset?.apply_offset(head_overlay)

/mob/living/carbon/human/update_worn_belt(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/belt_overlay = belt.build_worn_icon(default_layer = BELT_LAYER)
	var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
	my_chest?.worn_belt_offset?.apply_offset(belt_overlay)

/mob/living/carbon/human/update_worn_back(update_obscured = TRUE)
	. = ..()
	if(src.dna.species.uses_offsets == FALSE)
		return
	var/mutable_appearance/back_overlay = back.build_worn_icon(default_layer = BACK_LAYER)
	var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
	my_chest?.worn_back_offset?.apply_offset(back_overlay)
