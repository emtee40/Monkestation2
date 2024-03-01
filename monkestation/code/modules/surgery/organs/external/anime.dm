/// Anime Horns
/obj/item/organ/external/horns/anime_horns
	name = "anime horns"

/// Anime Ears

/obj/item/organ/internal/ears/anime_ears
	name = "anime ears"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "kitty"
	visual = TRUE
	var/ears_pref = null

	preference = "feature_anime_ears"

///datum/bodypart_overlay/ears/anime_ears
//	color_source = ORGAN_COLOR_ANIME
//	feature_key = "anime_ears"

/obj/item/organ/internal/ears/anime_ears/on_insert(mob/living/carbon/human/ear_owner)
	. = ..()
	if(istype(ear_owner) && ear_owner.dna)
		color = ear_owner.dna.features["animecolor"]
		ear_owner.dna.features["anime_ears"] = ear_owner.dna.species.mutant_bodyparts["anime_ears"] = "Cat"
		ear_owner.dna.update_uf_block(DNA_EARS_BLOCK)
		ear_owner.update_body()

/obj/item/organ/internal/ears/anime_ears/on_remove(mob/living/carbon/human/ear_owner)
	. = ..()
	if(istype(ear_owner) && ear_owner.dna)
		color = ear_owner.dna.features["animecolor"]
		ear_owner.dna.species.mutant_bodyparts -= "anime_ears"
		ear_owner.update_body()

///datum/bodypart_overlay/ears/anime_ears/get_global_feature_list()
//	return GLOB.anime_ears_list

/// Anime Chest

/obj/item/organ/external/anime_middle
	name = "anime implants"
	desc = "An anime implant fitted for a persons chest."
	icon_state = "antennae"

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_WINGS

	preference = "feature_anime_middle"

	bodypart_overlay = /datum/bodypart_overlay/mutant/anime_middle

/datum/bodypart_overlay/mutant/anime_middle
	color_source = ORGAN_COLOR_ANIME
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND
	feature_key = "anime_middle"

/datum/bodypart_overlay/mutant/anime_middle/get_global_feature_list()
	return GLOB.anime_middle_list

/datum/bodypart_overlay/mutant/anime_middle/get_base_icon_state()
	return sprite_datum.icon_state

/// Anime Bottom

/obj/item/organ/external/tail/anime_bottom
	name = "anime tail"
	desc = "A severed anime tail. What did you cut this off of?"
	preference = "feature_anime_bottom"

	wag_flags = WAG_ABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/anime_bottom

/datum/bodypart_overlay/mutant/tail/anime_bottom
	color_source = ORGAN_COLOR_ANIME
	feature_key = "anime_bottom"

/datum/bodypart_overlay/mutant/tail/anime_bottom/get_global_feature_list()
	return GLOB.anime_bottom_list
