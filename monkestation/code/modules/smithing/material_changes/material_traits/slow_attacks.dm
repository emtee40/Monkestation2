/datum/material_trait/slow_attacks
	name = "Bulky"
	reforges = 6

/datum/material_trait/slow_attacks/on_trait_add(atom/movable/parent)
	. = ..()
	if(isitem(parent))
		var/obj/item/item = parent
		item.attack_speed *= 1.5
		item.attack_speed = round(item.attack_speed)

/datum/material_trait/slow_attacks/on_remove(atom/movable/parent)
	if(isitem(parent))
		var/obj/item/item = parent
		item.attack_speed /= 1.5
		item.attack_speed = round(item.attack_speed)
