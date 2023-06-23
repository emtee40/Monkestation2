/obj/item/reagent_containers/cup/filter
	name = "seperatory funnel"
	desc = "A crude tool created by connecting several beakers. It would probably be useful for seperating reagents."
	icon = 'monkestation/icons/obj/ghetto_chem.dmi'
	icon_state = "beakerfilter"
	fill_icon_state = "beakerfilter"
	fill_icon = 'monkestation/icons/obj/ghetto_chem.dmi'
	inhand_icon_state = "beaker"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	fill_icon_thresholds = list(1, 20, 40, 60, 80, 100)

/obj/item/reagent_containers/cup/filter/afterattack(obj/target, mob/user, proximity) //overrides the standard version of this, only difference is that it only transfers one chem at a time
	if((!proximity) || !check_allowed_items(target,target_self=1))
		return
	if(!spillable)
		return
	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src] is empty!</span>")
			return
		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return
		to_chat(user, "<span class='notice'>You begin to drain something from [src].")
		if(do_after(user, 25, target = src))
			var/trans = reagents.trans_id_to(target, reagents.get_master_reagent_id(), amount_per_transfer_from_this,)
			to_chat(user, "<span class='notice'>You filter off [trans] unit\s of the solution into [target].</span>")
	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='warning'>[target] is empty and can't be refilled!</span>")
			return
		if(reagents.holder_full())
			to_chat(user, "<span class='warning'>[src] is full.</span>")
			return
		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, "<span class='notice'>You fill [src] with [trans] unit\s of the contents of [target].</span>")
	else if(reagents.total_volume)
		if(user.istate & !ISTATE_HARM)
			var/trans = reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			to_chat(user, span_notice("You transfer [trans] unit\s of the solution to [target]."))
		if(user.istate & ISTATE_HARM)
			user.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [target]!</span>", \
								"<span class='notice'>You splash the contents of [src] onto [target].</span>")
			reagents.expose(target, TOUCH)
			reagents.clear_reagents()
			playsound(src, 'sound/effects/slosh.ogg', 50, 1)

/datum/crafting_recipe/filter
	name = "seperatory funnel"
	result = /obj/item/reagent_containers/cup/filter
	reqs = list(
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/stack/cable_coil = 5,
	)
	time = 3 SECONDS
	category = CAT_CHEMISTRY

/obj/item/reagent_scanner //essentially just the code from the PDA reagent scanner, but shoved into this object, and specifies amount
	name = "reagent scanner"
	icon = 'monkestation/icons/obj/ghetto_chem.dmi'
	icon_state = "chemscanner"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "healthanalyzer"
	desc = "A health analyzer that looks to be modified to be capable of analyzing the reagents in a container."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)

/obj/item/reagent_scanner/afterattack(atom/A as mob|obj|turf|area, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!isnull(A.reagents))
		if(A.reagents.reagent_list.len > 0)
			playsound(src, 'sound/machines/ping.ogg', 15, 1)
			var/reagents_length = A.reagents.reagent_list.len
			to_chat(user, "<span class='notice'>[reagents_length] chemical agent[reagents_length > 1 ? "s" : ""] found.</span>")
			for (var/re in A.reagents.reagent_list)
				var/datum/reagent/R = re
				var/amount = R.volume
				to_chat(user, "<span class='notice'>\t [amount] units of [re].</span>")
		else
			to_chat(user, "<span class='notice'>No active chemical agents found in [A].</span>")
	else
		to_chat(user, "<span class='notice'>No significant chemical agents found in [A].</span>")

/datum/crafting_recipe/reagent_scanner
	name = "reagent scanner"
	result = /obj/item/reagent_scanner
	reqs = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/cable_coil = 5,
	)
	time = 3 SECONDS
	category = CAT_CHEMISTRY
