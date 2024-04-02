//Just in time for easter too!

/// CIVILIAN JOBS ///

//Bartender
/obj/item/clothing/under/rank/civilian/bartender/bunnysuit
	name = "bartender's bunnysuit"
	desc = "The staple of any bunny themed bartenders. Looks even more stylish than the standard bunny suit."
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_bar"
	worn_icon = "bunnysuit_bar"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/bartender/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/bartender
	name = "bartender's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "bar"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

//Chaplain
/obj/item/clothing/under/rank/civilian/chaplain/bunnysuit
	name = "chaplain's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_chaplain"
	worn_icon = "bunnysuit_chaplain"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/civilian/chaplain/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/chaplain
	name = "chaplain's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "chaplain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null


/obj/item/clothing/suit/jacket/tailcoat/chaplain
	name = "chaplain's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "chaplain"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Chef

/obj/item/clothing/under/rank/civilian/chef/bunnysuit
	name = "chef's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_chef"
	worn_icon = "bunnysuit_chef"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/chef/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/chef
	name = "chef's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "chef"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/chef
	name = "chef's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "chef"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/chef
	name = "chef's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_chef_tied"
	tie_type = "bowtie_collar_chef"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Head of Personnel
/obj/item/clothing/under/rank/civilian/head_of_personnel/bunnysuit
	name = "head of personnel's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_hop"
	worn_icon = "bunnysuit_hop"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/head_of_personnel
	name = "head of personnel's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "hop"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	armor_type = /datum/armor/hats_hopcap

/obj/item/clothing/suit/jacket/tailcoat/head_of_personnel
	name = "head of personnel's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "hop"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/head_of_personnel
	name = "head of personnel's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_hop_tied"
	tie_type = "bowtie_collar_hop"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Botanist
/obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit
	name = "botanist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_botany"
	worn_icon = "bunnysuit_botany"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/hydroponics
	name = "botanist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "botany"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/hydroponics
	name = "botanist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "botany"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/hydroponics
	name = "botanist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_botany_tied"
	tie_type = "bowtie_collar_botany"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Janitor
/obj/item/clothing/under/rank/civilian/janitor/bunnysuit
	name = "janitor's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_janitor"
	worn_icon = "bunnysuit_janitor"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/janitor/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/janitor
	name = "janitor's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "janitor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/janitor
	name = "janitor's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "janitor"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/janitor
	name = "janitor's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_janitor_tied"
	tie_type = "bowtie_collar_janitor"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/shoes/galoshes/heeled
	name = "heeled galoshes"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/heeled_shoes.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/heeled_shoes_worn.dmi'
	icon_state = "galoshes_heeled"
	worn_icon = "galoshes_heeled"

//Lawyer Suits
/obj/item/clothing/under/rank/civilian/lawyer/black/bunnysuit
	name = "lawyer's black bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_law_black"
	worn_icon = "bunnysuit_law_black"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/black/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/lawyer/black
	name = "lawyer's black bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "lawyer_black"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer/black
	name = "lawyer's black tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "lawyer_black"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/lawyer/black
	name = "black tie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "tie_collar_lawyer_black_tied"
	tie_type = "tie_collar_lawyer_black"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/rank/civilian/lawyer/beige/bunnysuit
	name = "good lawyer's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_good"
	worn_icon = "bunnysuit_good"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/beige/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/lawyer/beige
	name = "good lawyer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "lawyer_good"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer/beige
	name = "good lawyer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "lawyer_good"
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/lawyer/beige
	name = "good tie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "tie_collar_lawyer_good_tied"
	tie_type = "tie_collar_lawyer_good"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/rank/civilian/lawyer/red/bunnysuit
	name = "lawyer's red bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_law_red"
	worn_icon = "bunnysuit_law_red"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/red/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/lawyer/red
	name = "lawyer's red bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "lawyer_red"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer/red
	name = "lawyer's red tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "lawyer_red"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/lawyer/red
	name = "red tie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "tie_collar_lawyer_red_tied"
	tie_type = "tie_collar_lawyer_red"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/rank/civilian/lawyer/blue/bunnysuit
	name = "lawyer's blue bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_law_blue"
	worn_icon = "bunnysuit_law_blue"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/blue/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/lawyer/blue
	name = "lawyer's blue bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "lawyer_blue"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer/blue
	name = "lawyer's blue tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "lawyer_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/lawyer/blue
	name = "blue tie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "tie_collar_lawyer_blue_tied"
	tie_type = "tie_collar_lawyer_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Curator
/obj/item/clothing/under/rank/civilian/curator/bunnysuit
	name = "curator's bunnysuit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_curator_red"
	worn_icon = "bunnysuit_curator_red"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/civilian/curator/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/under/rank/civilian/curator/bunnysuit/teal
	icon_state = "bunnysuit_curator_green"
	worn_icon = "bunnysuit_curator_green"

/obj/item/clothing/under/rank/civilian/curator/bunnysuit/green
	icon_state = "bunnysuit_curator_teal"
	worn_icon = "bunnysuit_curator_teal"

/obj/item/clothing/head/playbunnyears/curator
	name = "curator's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "curator_red"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/playbunnyears/curator/teal
	icon_state = "curator_teal"

/obj/item/clothing/head/playbunnyears/curator/green
	icon_state = "curator_green"

/obj/item/clothing/suit/jacket/tailcoat/curator
	name = "curator's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "curator_red"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator/teal
	icon_state = "curator_teal"

/obj/item/clothing/suit/jacket/tailcoat/curator/green
	icon_state = "curator_green"

//Clown
/obj/item/clothing/under/rank/civilian/clown/bunnysuit
	name = "clown's bunnysuit"
	desc = "Now this is just ridiculous."
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_clown"
	worn_icon = "bunnysuit_clown"
	female_sprite_flags = FEMALE_UNIFORM_FULL
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/clown/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/clown
	name = "clown's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "clown"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	strip_delay = 60
	armor_type = /datum/armor/hats_caphat

/obj/item/clothing/suit/jacket/tailcoat/clown
	name = "clown's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "clown"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/shoes/clown_shoes/honk_heels
	name = "honk heels"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/heeled_shoes.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/heeled_shoes_worn.dmi'
	icon_state = "honk_heels"
	worn_icon = "honk_heels"

//Mime
/obj/item/clothing/under/rank/civilian/mime/bunnysuit
	name = "mime's bunnysuit"
	desc = "The staple of any bunny themed mimes. Includes black and white stockings in order to comply with mime federation outfit regulation."
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_mime"
	worn_icon = "bunnysuit_mime"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/mime/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/mime
	name = "mime's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "mime"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/mime
	name = "mime's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "mime"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/// CAPTAIN ///

/obj/item/clothing/under/rank/captain/bunnysuit
	name = "captain's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_captain"
	worn_icon = "bunnysuit_captain"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/captain/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/captain
	name = "captain's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "captain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	strip_delay = 60
	armor_type = /datum/armor/hats_caphat

/obj/item/clothing/suit/jacket/tailcoat/captain
	name = "captain's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "captain"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/captain
	name = "captain's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_captain_tied"
	tie_type = "bowtie_collar_captain"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/// CARGO JOBS ///

//Quartermaster
/obj/item/clothing/under/rank/cargo/qm/bunnysuit
	name = "quartermaster's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_qm"
	worn_icon = "bunnysuit_qm"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/qm/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/qm
	name = "quartermaster's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "qm"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/qm
	name = "quartermaster's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "qm"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Cargo Technician
/obj/item/clothing/under/rank/cargo/tech/bunnysuit
	name = "cargo technician's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_cargo"
	worn_icon = "bunnysuit_cargo"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/tech/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/cargo_tech
	name = "cargo technician's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "cargo_tech"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/cargo_tech
	name = "cargo technician's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "cargo_tech"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/cargo_tech
	name = "cargo bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_cargo_tied"
	tie_type = "bowtie_collar_cargo"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Miner
/obj/item/clothing/under/rank/cargo/miner/lavaland/bunnysuit
	name = "explorer's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_miner"
	worn_icon = "bunnysuit_miner"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/miner/lavaland/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/miner_lavaland
	name = "explorer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "explorer"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/miner_lavaland
	name = "explorer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "explorer"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/miner_lavaland
	name = "explorer's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_explorer_tied"
	tie_type = "bowtie_collar_explorer"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/shoes/workboots/mining/heeled
	name = "heeled mining boots"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/heeled_shoes.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/heeled_shoes_worn.dmi'
	icon_state = "explorer_heeled"
	worn_icon = "explorer_heeled"

//Bitrunner
/obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit
	name = "bitrunner's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_bitrunner"
	worn_icon = "bunnysuit_bitrunner"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/bitrunner
	name = "bitrunner's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "bitrunner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/bitrunner
	name = "bitrunner's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "bitrunner"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/bitrunner
	name = "bitrunner's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_bitrunner_tied"
	tie_type = "bowtie_collar_bitrunner"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Mailman
/obj/item/clothing/under/misc/mailman/bunnysuit
	name = "mailman's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_mail"
	worn_icon = "bunnysuit_mail"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/misc/mailman/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/mailman
	name = "mailman's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "mail"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/neck/tie/bunnytie/mailman
	name = "mailman's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_mail_tied"
	tie_type = "bowtie_collar_mail"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/// SECURITY JOBS ///

//Security Officer
/obj/item/clothing/under/rank/security/officer/bunnysuit
	name = "security officer's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_sec"
	worn_icon = "bunnysuit_sec"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/officer/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/security
	name = "security officer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "sec"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	armor_type = /datum/armor/soft_sec
	strip_delay = 60

/obj/item/clothing/suit/jacket/tailcoat/security/warden
	name = "security officer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "sec"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/security
	name = "security bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_sec_tied"
	tie_type = "bowtie_collar_sec"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Warden
/obj/item/clothing/under/rank/security/warden/bunnysuit
	name = "warden's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_warden"
	worn_icon = "bunnysuit_warden"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/warden/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/security/warden
	name = "warden's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "warden"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/security/warden
	name = "warden's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "warden"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Detective
/obj/item/clothing/under/rank/security/detective/bunnysuit
	name = "hard-worn bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_det"
	worn_icon = "bunnysuit_det"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/detective/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/under/rank/security/detective/noir/bunnysuit
	name = "noir bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_det_noir"
	worn_icon = "bunnysuit_det_noir"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/detective/noir/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/detective
	name = "detective's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "detective"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	armor_type = /datum/armor/fedora_det_hat

