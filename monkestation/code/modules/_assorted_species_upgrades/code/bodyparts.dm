//May the lord forgive me.
//For I sure as shit won't.
//This handles management of specific offsets, and ensures we can change things around for weird and wacky species things. Like Lizards getting tailbags instead of backpacks (frills hurt when compressed!!!)
//Generally this is very useful to not have to resprite the same item over and over, as you can now instead off-set it on a species/bodypart by bodypart basis.
//A majority of these will be unused until said species are added, and may never be used, but are still good to define for adminbus.

/obj/item/bodypart/chest
	/// Offset to apply to equipment worn as a uniform
	var/datum/worn_feature_offset/worn_uniform_offset
	/// Offset to apply to equipment worn on the id slot
	var/datum/worn_feature_offset/worn_id_offset
	/// Offset to apply to equipment worn in the suit slot
	var/datum/worn_feature_offset/worn_suit_storage_offset
	/// Offset to apply to equipment worn on the hips
	var/datum/worn_feature_offset/worn_belt_offset
	/// Offset to apply to overlays placed on the back
	var/datum/worn_feature_offset/worn_back_offset
	/// Offset to apply to equipment worn as a suit
	var/datum/worn_feature_offset/worn_suit_offset
	/// Offset to apply to equipment worn on the neck
	var/datum/worn_feature_offset/worn_neck_offset
	/// The offset datum for our accessory overlay.
	var/datum/worn_feature_offset/worn_accessory_offset

/obj/item/bodypart/head
	/// Offset to apply to equipment worn on the ears
	var/datum/worn_feature_offset/worn_ears_offset
	/// Offset to apply to equipment worn on the eyes
	var/datum/worn_feature_offset/worn_glasses_offset
	/// Offset to apply to equipment worn on the mouth
	var/datum/worn_feature_offset/worn_mask_offset
	/// Offset to apply to equipment worn on the head
	var/datum/worn_feature_offset/worn_head_offset
	/// Offset to apply to overlays placed on the face
	var/datum/worn_feature_offset/worn_face_offset

/obj/item/bodypart/head/Destroy()
	. = ..()
	for(var/datum/worn_feature_offset/i in src)
		i = null
		QDEL_NULL(i)

/obj/item/bodypart/chest/Destroy()
	. = ..()
	for(var/datum/worn_feature_offset/i in src)
		i = null
		QDEL_NULL(i)
