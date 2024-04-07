/datum/material_trait/honk_blessed
	name = "Honkmother's Blessing"

/datum/material_trait/honk_blessed/on_trait_add(atom/movable/parent)
	. = ..()
	parent.AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg'=1), 50, falloff_exponent = 20)

/datum/material_trait/honk_blessed/on_mob_attack(atom/movable/parent, datum/component/worked_material/host, mob/living/target, mob/living/attacker)
	if(iscarbon(target))
		target.reagents.add_reagent(/datum/reagent/consumable/laughter, 5 * (0.01 * host.liquid_flow))

/datum/material_trait/honk_blessed/on_remove(atom/movable/parent)
	qdel(parent.GetComponent(/datum/component/squeak))
