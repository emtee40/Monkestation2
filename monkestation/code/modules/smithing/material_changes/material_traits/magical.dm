/datum/material_trait/magical
	name = "Magical"
	desc = "Makes this item magical."
	trait_flags = MATERIAL_NO_STACK_ADD

/datum/material_trait/magical/on_trait_add(atom/movable/parent)
	. = ..()
	parent.AddComponent(/datum/component/fantasy)

/datum/material_trait/magical/on_remove(atom/movable/parent)
	qdel(parent.GetComponent(/datum/component/fantasy))
