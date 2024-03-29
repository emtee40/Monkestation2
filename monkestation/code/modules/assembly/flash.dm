/obj/item/assembly/flash/examine(mob/user)
	. = ..()
	if(user?.mind?.has_antag_datum(/datum/antagonist/brother))
		. += span_boldnotice("In order to convert someone into your blood brother, you must <i>directly flash them</i>, not AoE flash!")
