/obj/item/organ/internal/cyberimp/arm
	encode_info = AUGMENT_NT_LOWLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/Initialize()
	. = ..()
	if(ispath(active_item))
		active_item = new active_item(src)

	for(var/typepath in items_to_create)
		var/atom/new_item = new typepath(src)
		items_list += WEAKREF(new_item)

/obj/item/organ/internal/cyberimp/arm/item_set/update_implants()
	if(!check_compatibility())
		Retract()

	owner.visible_message("<span class='notice'>[owner] retracts [active_item] back into [owner.p_their()] [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='notice'>[active_item] snaps back into your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='hear'>You hear a short mechanical noise.</span>")

	owner.transferItemToLoc(active_item, src, TRUE)
	active_item = null
	playsound(get_turf(owner), 'sound/mecha/mechmove03.ogg', 50, TRUE)

/obj/item/organ/internal/cyberimp/arm/item_set/ui_action_click()
	if((organ_flags & ORGAN_FAILING) || (!active_item && !contents.len))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be broken..."))
		return

	if(!active_item || (active_item in src))
		active_item = null
		if(contents.len == 1)
			Extend(contents[1])
		else
			var/list/choice_list = list()
			for(var/datum/weakref/augment_ref in items_list)
				var/obj/item/augment_item = augment_ref.resolve()
				if(!augment_item)
					items_list -= augment_ref
					continue
				choice_list[augment_item] = image(augment_item)
			var/obj/item/choice = show_radial_menu(owner, owner, choice_list)
			if(owner && owner == usr && owner.stat != DEAD && (src in owner.organs) && !active_item && (choice in contents))
				// This monster sanity check is a nice example of how bad input is.
				Extend(choice)
	else
		Retract()


/obj/item/organ/internal/cyberimp/arm/item_set/gun/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(30/severity) && owner && !(organ_flags & ORGAN_FAILING))
		Retract()
		owner.visible_message(span_danger("A loud bang comes from [owner]\'s [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm!"))
		playsound(get_turf(owner), 'sound/weapons/flashbang.ogg', 100, TRUE)
		to_chat(owner, span_userdanger("You feel an explosion erupt inside your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm as your implant breaks!"))
		owner.adjust_fire_stacks(20)
		owner.ignite_mob()
		owner.adjustFireLoss(25)
		organ_flags |= ORGAN_FAILING


/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/Initialize()
	. = ..()
	var/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/laserphasergun = locate(/obj/item/gun/energy/laser/mounted) in contents
	laserphasergun.icon = icon //No invisible laser guns kthx
	laserphasergun.icon_state = icon_state

/obj/item/organ/internal/cyberimp/arm/item_set/gun/taser
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/gun/taser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/toolset
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/toolset/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/esword
	encode_info = AUGMENT_SYNDICATE_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/medibeam
	encode_info = AUGMENT_TG_LEVEL


/obj/item/organ/internal/cyberimp/arm/item_set/flash
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/baton
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/combat
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/surgery
	name = "surgical toolset implant"
	desc = "A set of surgical tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(/obj/item/retractor/augment, /obj/item/hemostat/augment, /obj/item/cautery/augment, /obj/item/surgicaldrill/augment, /obj/item/scalpel/augment, /obj/item/circular_saw/augment, /obj/item/surgical_drapes)
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/cook
	name = "kitchenware toolset implant"
	desc = "A set of kitchen tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/kitchen/rollingpin,
		/obj/item/knife/kitchen,
		/obj/item/reagent_containers/cup/beaker
	)
	encode_info = AUGMENT_NT_LOWLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/janitor
	name = "janitorial toolset implant"
	desc = "A set of janitorial tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/mop/advanced,
		/obj/item/reagent_containers/cup/bucket,
		/obj/item/soap,
		/obj/item/reagent_containers/spray/cleaner
	)
	encode_info = AUGMENT_NT_LOWLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/detective
	name = "detective's toolset implant"
	desc = "A set of detective tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/evidencebag,
		/obj/item/evidencebag,
		/obj/item/evidencebag,
		/obj/item/detective_scanner,
		/obj/item/lighter
	)
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/detective/Destroy()
	on_destruction()
	return ..()

/obj/item/organ/internal/cyberimp/arm/item_set/detective/proc/on_destruction()
	//We need to drop whatever is in the evidence bags
	for(var/obj/item/evidencebag/baggie in contents)
		var/obj/item/located = locate() in baggie
		if(located)
			located.forceMove(drop_location())

/obj/item/organ/internal/cyberimp/arm/item_set/chemical
	name = "chemical toolset implant"
	desc = "A set of chemical tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/dropper
	)
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/atmospherics
	name = "atmospherics toolset implant"
	desc = "A set of atmospheric tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(
		/obj/item/extinguisher,
		/obj/item/analyzer,
		/obj/item/crowbar,
		/obj/item/holosign_creator/atmos
	)
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/connector
	name = "universal connection implant"
	desc = "Special inhand implant that allows you to connect your brain directly into the protocl sphere of implants, which allows for you to hack them and make the compatible."
	icon_state = "hand_implant"
	implant_overlay = "hand_implant_overlay"
	implant_color = "#39992d"
	encode_info = AUGMENT_NO_REQ
	items_to_create = list(/obj/item/cyberlink_connector)

/obj/item/organ/internal/cyberimp/arm/item_set/mantis
	name = "C.H.R.O.M.A.T.A. mantis blade implants"
	desc = "High tech mantis blade implants, easily portable weapon, that has a high wound potential."
	items_to_create = list(/obj/item/mantis_blade)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/syndie_mantis
	name = "A.R.A.S.A.K.A. mantis blade implants"
	desc = "Modernized mantis blade designed coined by Tiger operatives, much sharper blade with energy actuators makes it a much deadlier weapon."
	items_to_create = list(/obj/item/mantis_blade/syndicate)
	encode_info = AUGMENT_SYNDICATE_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/syndie_mantis/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/ammo_counter
	name = "S.M.A.R.T. ammo logistics system"
	desc = "Special inhand implant that allows transmits the current ammo and energy data straight to the user's visual cortex."
	icon_state = "hand_implant"
	implant_overlay = "hand_implant_overlay"
	implant_color = "#750137"
	encode_info = AUGMENT_NT_HIGHLEVEL

	var/atom/movable/screen/cybernetics/ammo_counter/counter_ref
	var/obj/item/gun/our_gun

/obj/item/organ/internal/cyberimp/arm/ammo_counter/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	RegisterSignal(M,COMSIG_CARBON_ITEM_PICKED_UP, PROC_REF(add_to_hand))
	RegisterSignal(M,COMSIG_CARBON_ITEM_DROPPED, PROC_REF(remove_from_hand))

/obj/item/organ/internal/cyberimp/arm/ammo_counter/Remove(mob/living/carbon/M, special)
	. = ..()
	UnregisterSignal(M,COMSIG_CARBON_ITEM_PICKED_UP)
	UnregisterSignal(M,COMSIG_CARBON_ITEM_DROPPED)
	our_gun = null
	update_hud_elements()

/obj/item/organ/internal/cyberimp/arm/ammo_counter/update_implants()
	update_hud_elements()

/obj/item/organ/internal/cyberimp/arm/ammo_counter/proc/update_hud_elements()
	SIGNAL_HANDLER
	if(!owner || !owner?.hud_used)
		return

	if(!check_compatibility())
		return

	var/datum/hud/H = owner.hud_used

	if(!our_gun)
		if(!H.cybernetics_ammo[zone])
			return
		H.cybernetics_ammo[zone] = null

		counter_ref.hud = null
		H.infodisplay -= counter_ref
		H.mymob.client.screen -= counter_ref
		QDEL_NULL(counter_ref)
		return

	if(!H.cybernetics_ammo[zone])
		counter_ref = new()
		counter_ref.screen_loc =  zone == BODY_ZONE_L_ARM ? ui_hand_position(1,1,9) : ui_hand_position(2,1,9)
		H.cybernetics_ammo[zone] = counter_ref
		counter_ref.hud = H
		H.infodisplay += counter_ref
		H.mymob.client.screen += counter_ref

	var/display
	if(istype(our_gun,/obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/balgun = our_gun
		display = balgun.magazine.ammo_count(FALSE)
	else
		var/obj/item/gun/energy/egun = our_gun
		var/obj/item/ammo_casing/energy/shot = egun.ammo_type[egun.select]
		display = FLOOR(egun.cell.charge / shot.e_cost,1)
	counter_ref.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='white'>[display]</font></div>")

/obj/item/organ/internal/cyberimp/arm/ammo_counter/proc/add_to_hand(datum/source,obj/item/maybegun)
	SIGNAL_HANDLER

	var/obj/item/bodypart/bp = owner.get_active_hand()

	if(bp.body_zone != zone)
		return

	if(istype(maybegun,/obj/item/gun/ballistic))
		our_gun = maybegun
		RegisterSignal(owner,COMSIG_MOB_FIRED_GUN, PROC_REF(update_hud_elements))

	if(istype(maybegun,/obj/item/gun/energy))
		var/obj/item/gun/energy/egun = maybegun
		our_gun = egun
		RegisterSignal(egun.cell,COMSIG_CELL_CHANGE_POWER, PROC_REF(update_hud_elements))

	update_hud_elements()

/obj/item/organ/internal/cyberimp/arm/ammo_counter/proc/remove_from_hand(datum/source,obj/item/maybegun)
	SIGNAL_HANDLER

	if(our_gun != maybegun)
		return

	if(istype(maybegun,/obj/item/gun/ballistic))
		UnregisterSignal(owner,COMSIG_MOB_FIRED_GUN)

	if(istype(maybegun,/obj/item/gun/energy))
		var/obj/item/gun/energy/egun = maybegun
		UnregisterSignal(egun.cell,COMSIG_CELL_CHANGE_POWER)


	our_gun = null
	update_hud_elements()

/obj/item/organ/internal/cyberimp/arm/ammo_counter/syndicate
	encode_info = AUGMENT_SYNDICATE_LEVEL

/obj/item/organ/internal/cyberimp/arm/cooler
	name = "sub-dermal cooling implant"
	desc = "Special inhand implant that cools you down if overheated."
	icon_state = "hand_implant"
	implant_overlay = "hand_implant_overlay"
	implant_color = "#00e1ff"
	encode_info = AUGMENT_NT_LOWLEVEL

/obj/item/organ/internal/cyberimp/arm/cooler/on_life()
	. = ..()
	if(!check_compatibility())
		return
	var/amt = BODYTEMP_NORMAL - owner.get_body_temp_normal()
	if(amt == 0)
		return
	owner.add_body_temperature_change("dermal_cooler_[zone]",clamp(amt,-1,0))

/obj/item/organ/internal/cyberimp/arm/cooler/Remove(mob/living/carbon/M, special)
	. = ..()
	owner.remove_body_temperature_change("dermal_cooler_[zone]")

/obj/item/organ/internal/cyberimp/arm/heater
	name = "sub-dermal heater implant"
	desc = "Special inhand implant that heats you up if overcooled."
	icon_state = "hand_implant"
	implant_overlay = "hand_implant_overlay"
	implant_color = "#ff9100"
	encode_info = AUGMENT_NT_LOWLEVEL

/obj/item/organ/internal/cyberimp/arm/heater/on_life()
	. = ..()
	if(!check_compatibility())
		return
	var/amt = BODYTEMP_NORMAL - owner.get_body_temp_normal()
	if(amt == 0)
		return
	owner.add_body_temperature_change("dermal_heater_[zone]",clamp(amt,0,1))

/obj/item/organ/internal/cyberimp/arm/heater/Remove(mob/living/carbon/M, special)
	. = ..()
	owner.remove_body_temperature_change("dermal_heater_[zone]")
