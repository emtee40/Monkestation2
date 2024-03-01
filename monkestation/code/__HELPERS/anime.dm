/proc/is_cat_enough(mob/living/user, include_all_anime = FALSE)
	. = FALSE
	if(iscat(user)) // there's nothing more cat than a cat
		return TRUE
	if(include_all_anime && HAS_TRAIT(user, TRAIT_ANIME))
		return TRUE
	if(HAS_TRAIT(user, TRAIT_CAT))
		return TRUE
	if(istype(user.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/costume/kitty)) // combine with glue for hilarity
		return TRUE
	//var/obj/item/organ/internal/ears/anime_ears/anime_ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	//var/obj/item/organ/external/tail/anime_bottom/anime_bottom = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	//if(istype(anime_ears?.bodypart_overlay?.sprite_datum, /datum/sprite_accessory/anime_ears/cat) && istype(anime_bottom?.bodypart_overlay?.sprite_datum, /datum/sprite_accessory/tails/anime_bottom/cat)) // cat ears AND tail? aight then, you're very much cat
	//	return TRUE

/proc/is_shark_enough(mob/living/user, include_all_anime = FALSE)
	var/obj/item/organ/external/tail/anime_bottom/anime_bottom = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(istype(anime_bottom?.bodypart_overlay?.sprite_datum, /datum/sprite_accessory/tails/anime_bottom/shark)) // checks if user has a shark tail
		return TRUE
