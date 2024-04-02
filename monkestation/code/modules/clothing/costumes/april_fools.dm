

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

/obj/item/clothing/suit/jacket/tailcoat/detective
	name = "detective's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "detective"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/detective
	name = "tie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "tie_collar_det_tied"
	tie_type = "tie_collar_det"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/head/playbunnyears/detective/noir
	name = "noir bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "detective_noir"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/detective/noir
	name = "noir tailcoat"
	desc = ""
	icon_state = "detective_noir"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Head of Security
/obj/item/clothing/under/rank/security/head_of_security/bunnysuit
	name = "head of security's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_hos"
	worn_icon = "bunnysuit_hos"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/head_of_security
	name = "head of security's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "hos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	armor_type = /datum/armor/hats_hos
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/jacket/tailcoat/security/head_of_security
	name = "head of security's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "hos"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Prisoner
/obj/item/clothing/under/rank/prisoner/bunnysuit
	name = "prisoner's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_prisoner"
	worn_icon = "bunnysuit_prisoner"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/prisoner/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/prisoner
	name = "prisoner's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "prisoner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/neck/tie/bunnytie/prisoner
	name = "prisoner's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_prisoner_tied"
	tie_type = "bowtie_collar_prisoner"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/// ENGINEERING JOBS ///

//Chief Engineer
/obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit
	name = "chief engineer's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_ce"
	worn_icon = "bunnysuit_ce"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/chief_engineer
	name = "chief engineer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "ce"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/chief_engineer
	name = "chief engineer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "ce"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/chief_engineer
	name = "chief engineer's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_ce_tied"
	tie_type = "bowtie_collar_ce"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Atmospheric Technician
/obj/item/clothing/under/rank/engineering/atmospheric_technician/bunnysuit
	name = "atmospheric technician's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_atmos"
	worn_icon = "bunnysuit_atmos"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/atmospheric_technician
	name = "atmospheric technician's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "atmos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/atmospheric_technician
	name = "firefighter's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "atmos"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/atmospheric_technician
	name = "atmospheric technician's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_atmos_tied"
	tie_type = "bowtie_collar_atmos"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Engineer
/obj/item/clothing/under/rank/engineering/engineer/bunnysuit
	name = "engineer's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_engi"
	worn_icon = "bunnysuit_engi"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/engineer/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/engineer
	name = "engineer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "engi"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/engineer
	name = "engineer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "engi"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/engineer
	name = "engineer's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_engi_tied"
	tie_type = "bowtie_collar_engi"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/shoes/workboots/heeled
	name = "heeled work boots"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/heeled_shoes.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/heeled_shoes_worn.dmi'
	icon_state = "workboots_heeled"
	worn_icon = "workboots_heeled"

/// MEDICAL JOBS ///

//Doctor
/obj/item/clothing/under/rank/medical/doctor/bunnysuit
	name = "medical doctor's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_doctor"
	worn_icon = "bunnysuit_doctor"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/doctor/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/doctor
	name = "medical doctor's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "doctor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/doctor
	name = "medical doctor's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "doctor"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/doctor
	name = "medical doctor's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_doctor_tied"
	tie_type = "bowtie_collar_doctor"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Chief Medical Officer
/obj/item/clothing/under/rank/medical/chief_medical_officer/bunnysuit
	name = "chief medical officer's  bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_cmo"
	worn_icon = "bunnysuit_cmo"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/chief_medical_officer/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/chief_medical_officer
	name = "chief medical officer's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "cmo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/chief_medical_officer
	name = "chief medical officer's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "cmo"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/chief_medical_officer
	name = "chief medical officer's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_cmo_tied"
	tie_type = "bowtie_collar_cmo"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Virologist
/obj/item/clothing/under/rank/medical/virologist/bunnysuit
	name = "virologist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_viro"
	worn_icon = "bunnysuit_viro"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/virologist/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/virologist
	name = "virologist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "virologist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/virologist
	name = "virologist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "virologist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/virologist
	name = "virologist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_virologist_tied"
	tie_type = "bowtie_collar_virologist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Chemist
/obj/item/clothing/under/rank/medical/chemist/bunnysuit
	name = "chemist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_chem"
	worn_icon = "bunnysuit_chem"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/chemist/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/chemist
	name = "chemist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "chem"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/chemist
	name = "chemist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "chem"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/chemist
	name = "chemist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_chem_tied"
	tie_type = "bowtie_collar_chem"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Paramedic
/obj/item/clothing/under/rank/medical/paramedic/bunnysuit
	name = "paramedic's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_paramedic"
	worn_icon = "bunnysuit_paramedic"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/paramedic/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/paramedic
	name = "paramedic's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "paramedic"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/paramedic
	name = "paramedic's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "paramedic"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/paramedic
	name = "paramedic's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_paramedic_tied"
	tie_type = "bowtie_collar_paramedic"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Psychologist
/obj/item/clothing/under/suit/black/bunnysuit
	name = "psychologist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_psychologist"
	worn_icon = "bunnysuit_psychologist"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/suit/black/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/suit/jacket/tailcoat/psychologist
	name = "psychologist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "psychologist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/// SCIENCE JOBS ///

//Research Director
/obj/item/clothing/under/rank/rnd/research_director/bunnysuit
	name = "research director's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_rd"
	worn_icon = "bunnysuit_rd"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	can_adjust = TRUE

/obj/item/clothing/under/rank/rnd/research_director/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/research_director
	name = "research director's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "rd"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/research_director
	name = "research director's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "rd"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

//Scientist
/obj/item/clothing/under/rank/rnd/scientist/bunnysuit
	name = "research director's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_sci"
	worn_icon = "bunnysuit_sci"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/scientist/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/scientist
	name = "scientist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/scientist
	name = "scientist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "science"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/scientist
	name = "scientist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_science_tied"
	tie_type = "bowtie_collar_science"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Roboticist
/obj/item/clothing/under/rank/rnd/roboticist/bunnysuit
	name = "roboticist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_roboticist"
	worn_icon = "bunnysuit_roboticist"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/roboticist/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/roboticist
	name = "roboticist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "genetics"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/roboticist
	name = "roboticist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "genetics"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/roboticist
	name = "roboticist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_roboticist_tied"
	tie_type = "bowtie_collar_roboticist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//Geneticist
/obj/item/clothing/under/rank/rnd/geneticist/bunnysuit
	name = "geneticist's bunnysuit"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunnysuits.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunnysuits_worn.dmi'
	icon_state = "bunnysuit_genetics"
	worn_icon = "bunnysuit_genetics"
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/geneticist/bunnysuit/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny)

/obj/item/clothing/head/playbunnyears/geneticist
	name = "geneticist's bunny ears headband"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/bunny_ears.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/bunny_ears_worn.dmi'
	icon_state = "genetics"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/suit/jacket/tailcoat/geneticist
	name = "geneticist's tailcoat"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/tailcoats.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/tailcoats_worn.dmi'
	icon_state = "genetics"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digitigrade = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/geneticist
	name = "geneticist's bowtie collar"
	desc = ""
	icon = 'monkestation/icons/obj/clothing/april_fools/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/april_fools/neckwear_worn.dmi'
	icon_state = "bowtie_collar_genetics_tied"
	tie_type = "bowtie_collar_genetics"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
