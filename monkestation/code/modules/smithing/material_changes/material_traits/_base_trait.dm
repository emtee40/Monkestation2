/datum/material_trait
	var/name = "Generic Material Trait"
	var/desc = "Does generic material things."
	var/trait_flags = NONE

/datum/material_trait/proc/on_trait_add(atom/movable/parent)

/datum/material_trait/proc/on_process(atom/movable/parent, datum/component/worked_material/host)

/datum/material_trait/proc/on_mob_attack(atom/movable/parent, datum/component/worked_material/host, mob/living/target, mob/living/attacker)
