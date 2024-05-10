/datum/market/auction/aftermarket_parts
	name = "Aftermarket Implants"

/datum/market_item/auction/shoddy_implant
	markets = list(/datum/market/auction/aftermarket_parts)
	stock_max = 1
	availability_prob = 100
	category = "Arm Augment"
	auction_weight = 5

/datum/market_item/auction/shoddy_implant/chest
	category = "Chest Augments"

/datum/market_item/auction/shoddy_implant/chest/sandevistan
	name = "Refurbished Sandevistan"
	desc = "A refurbished Sandevistan, has some issues but with how hard these are to get is worth it."
	item = /obj/item/organ/internal/cyberimp/chest/sandevistan/refurbished

	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 6

/datum/market_item/auction/shoddy_implant/chest/knockout
	name = "Knockout Implant"
	desc = "A crazy clown made this to prank the crew really really hard."
	item = /obj/item/organ/internal/cyberimp/chest/knockout

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
