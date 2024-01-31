/obj/item/neutered_borer_spawner
	name = "syndicate cortical borer cage"
	desc = "The opposite of a harmless cage that is intended to capture cortical borer, \
			as this one contains a borer trained to assist anyone who it first sees in completing their goals."
	icon = 'monkestation/code/modules/antagonists/borers/icons/items.dmi'
	icon_state = "cage"
	var/opened = FALSE // used purelly for sprite manipulation

/obj/item/neutered_borer_spawner/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/neutered_borer_spawner/update_overlays()
	. = ..()
	. += "borer"
	if(opened)
		. += "doors_open"
	else
		. += "doors_closed"

/obj/item/neutered_borer_spawner/attack_self(mob/living/user)
	user.visible_message("[user] opens [src].", "You have opened the [src], awaiting for the borer to come out.", "You hear a metallic thunk.")
	opened = TRUE
	playsound(src, 'sound/machines/boltsup.ogg', 30, TRUE)
	var/list/mob/dead/observer/candidates = poll_ghost_candidates(
		"Do you want to play as a neutered cortical borer?",
		ROLE_BORER,
		poll_time = 10 SECONDS
	)
	if(!LAZYLEN(candidates))
		opened = FALSE
		to_chat(user, "... After waiting the borer does not seem to come out, maybe try again a bit later?")
		playsound(src, 'sound/machines/boltsup.ogg', 30, TRUE)

	var/mob/dead/observer/spawned_borer = pick(candidates)
	var/mob/living/basic/cortical_borer/neutered/new_mob = new /mob/living/basic/cortical_borer/neutered(get_turf(src))
	spawned_borer.mind.transfer_to(new_mob, TRUE)
	if(!new_mob.mind.has_antag_datum(/datum/antagonist/cortical_borer/neutered))
		var/datum/antagonist/cortical_borer/neutered/borer_antagonist_datum = new
		new_mob.mind.add_antag_datum(borer_antagonist_datum)

	new /obj/item/cortical_cage(get_turf(src))
	QDEL_NULL(src)
