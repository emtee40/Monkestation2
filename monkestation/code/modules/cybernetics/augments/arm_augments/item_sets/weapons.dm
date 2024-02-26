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
	name = "arm-mounted laser implant"
	desc = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_laser"
	items_to_create = list(/obj/item/gun/energy/laser/mounted/augment)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/Initialize()
	. = ..()
	var/obj/item/organ/internal/cyberimp/arm/item_set/gun/laser/laserphasergun = locate(/obj/item/gun/energy/laser/mounted) in contents
	laserphasergun.icon = icon //No invisible laser guns kthx
	laserphasergun.icon_state = icon_state


/obj/item/organ/internal/cyberimp/arm/item_set/gun/taser
	name = "arm-mounted taser implant"
	desc = "A variant of the arm cannon implant that fires electrodes and disabler shots. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_taser"
	items_to_create = list(/obj/item/gun/energy/e_gun/advtaser/mounted)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/gun/taser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/esword
	name = "arm-mounted energy blade"
	desc = "An illegal and highly dangerous cybernetic implant that can project a deadly blade of concentrated energy."
	items_to_create = list(/obj/item/melee/energy/blade/hardlight)
	encode_info = AUGMENT_SYNDICATE_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/medibeam
	name = "integrated medical beamgun"
	desc = "A cybernetic implant that allows the user to project a healing beam from their hand."
	items_to_create = list(/obj/item/gun/medbeam)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/flash
	name = "integrated high-intensity photon projector" //Why not
	desc = "An integrated projector mounted onto a user's arm that is able to be used as a powerful flash."
	items_to_create = list(/obj/item/assembly/flash/armimplant)
	encode_info = AUGMENT_NT_HIGHLEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/flash/Initialize(mapload)
	. = ..()
	for(var/datum/weakref/created_item in items_list)
		var/obj/potential_flash = created_item.resolve()
		if(!istype(potential_flash, /obj/item/assembly/flash/armimplant))
			continue
		var/obj/item/assembly/flash/armimplant/flash = potential_flash
		flash.arm = WEAKREF(src) // Todo: wipe single letter vars out of assembly code

/obj/item/organ/internal/cyberimp/arm/item_set/flash/Extend()
	. = ..()
	active_item.set_light_range(7)
	active_item.set_light_on(TRUE)

/obj/item/organ/internal/cyberimp/arm/item_set/flash/Retract()
	if(active_item)
		active_item.set_light_on(FALSE)
	return ..()

/obj/item/organ/internal/cyberimp/arm/item_set/baton
	name = "arm electrification implant"
	desc = "An illegal combat implant that allows the user to administer disabling shocks from their arm."
	items_to_create = list(/obj/item/borg/stun)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/mantis
	name = "C.H.R.O.M.A.T.A. mantis blade implants"
	desc = "High tech mantis blade implants, easily portable weapon, that has a high wound potential."
	items_to_create = list(/obj/item/mantis_blade/chromata)
	encode_info = AUGMENT_TG_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/syndie_mantis
	name = "A.R.A.S.A.K.A. mantis blade implants"
	desc = "Modernized mantis blade designed coined by Tiger operatives, much sharper blade with energy actuators makes it a much deadlier weapon."
	items_to_create = list(/obj/item/mantis_blade/syndicate)
	encode_info = AUGMENT_SYNDICATE_LEVEL

/obj/item/organ/internal/cyberimp/arm/item_set/syndie_mantis/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/razorwire
	name = "razorwire spool implant"
	desc = "An integrated spool of razorwire, capable of being used as a weapon when whipped at your foes. \
		Built into the back of your hand, try your best to not get it tangled."
	items_to_create = list(/obj/item/melee/razorwire)
	encode_info = AUGMENT_SYNDICATE_LEVEL
	icon = 'monkestation/code/modules/cybernetics/icons/implants.dmi'
	icon_state = "razorwire"
	visual_implant = TRUE
	bodypart_overlay = /datum/bodypart_overlay/simple/razorwire

/obj/item/organ/internal/cyberimp/arm/item_set/razorwire/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/internal/cyberimp/arm/item_set/razorwire/Retract()
	if(active_item)
		var/obj/item/melee/razorwire/wire = active_item
		wire.disconnect()
	return ..()

/datum/bodypart_overlay/simple/razorwire
	icon = 'monkestation/code/modules/cybernetics/icons/implants.dmi'
	icon_state = "razorwire_right"
	layers = EXTERNAL_FRONT

/datum/bodypart_overlay/simple/razorwire/unique_properties(obj/item/organ/internal/cyberimp/called_from)
	if(called_from.zone == BODY_ZONE_L_ARM)
		icon_state = "razorwire_left"
