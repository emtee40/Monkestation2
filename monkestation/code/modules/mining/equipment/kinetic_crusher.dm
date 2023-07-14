/// Crusher trophy's
//Legion (Megafauna)
/obj/item/crusher_trophy/malformed_bone
	name = "malformed bone"
	desc = "A piece of bone caught in the act of division. Suitable as a trophy for a kinetic crusher."
	icon_state = "malf_bone"
	denied_type = /obj/item/crusher_trophy/malformed_bone
	bonus_value = 40

/obj/item/crusher_trophy/malformed_bone/effect_desc()
	return "mark detonation to have a <b>[bonus_value]</b>% chance to mark nearby creatures."

/obj/item/crusher_trophy/malformed_bone/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/hammer_synced)
	for(var/mob/living/L in oview(2,user)) // take every mob, including yourself as possible targets
		if(prob(bonus_value) && !L.has_status_effect(/datum/status_effect/crusher_mark))
			L.apply_status_effect(/datum/status_effect/crusher_mark, hammer_synced)
