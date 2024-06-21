/obj/item/book/granter/crafting_recipe/maintgodgranter
	name = "maintenance encyclopedia"
	icon_state = "book1"
	desc = "A burnt and damaged tome? Where did this come from?"
	crafting_recipe_types = list(
		/datum/crafting_recipe/pipegun_prime,
		/datum/crafting_recipe/laser_musket_prime,
		/datum/crafting_recipe/smoothbore_disabler_prime,
		/datum/crafting_recipe/trash_cannon,
		/datum/crafting_recipe/trashball,
	)
	remarks = list(
		"Seems they found a way to strap a bomb to a spear.",
		"This doesnt seem very safe.",
		"How do I survive a point blank impact from this?",
		"Whats a bomb suit and why would I need one?",
		"Just tie a bomb to a spear?",
		"I just realised why this book is charred.",
	)

/obj/item/book/granter/crafting_recipe/maintgodgranter/recoil(mob/living/user)
	to_chat(user, span_warning("The book turns to dust in your hands."))
	qdel(src)
