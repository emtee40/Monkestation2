/datum/material_trait/weak_weapon
	name = "Weak Weapon"

/datum/material_trait/weak_weapon/on_trait_add(atom/movable/parent)
	. = ..()
	if(isobj(parent))
		var/obj/obj = parent
		obj.force *= 0.5
