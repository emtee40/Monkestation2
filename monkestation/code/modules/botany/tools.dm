/obj/item/shovel/spade/pre_attack(atom/A, mob/living/user, params)
	if(A.GetComponent(/datum/component/plant_growing))
		if(!do_after(user, 3 SECONDS, A))
			return ..()
		SEND_SIGNAL(A, COMSIG_PLANTER_REMOVE_PLANTS)
		return TRUE
	. = ..()

/obj/item/cultivator/pre_attack(atom/A, mob/living/user, params)
	if(SEND_SIGNAL(A, COMSIG_GROWING_ADJUST_WEED, -10))
		return TRUE
	. = ..()
