/obj/item/organ/internal/cyberimp/chest
	name = "chest-mounted implant"
	desc = "You shouldn't see this! Adminhelp and report this as an issue on github!"
	zone = BODY_ZONE_CHEST
	icon_state = "implant-toolkit"
	w_class = WEIGHT_CLASS_SMALL
	encode_info = AUGMENT_NT_LOWLEVEL

	var/double_legged = FALSE
	slot = ORGAN_SLOT_SPINAL

/datum/action/item_action/organ_action/sandy
	name = "Sandevistan Activation"
/obj/item/organ/internal/cyberimp/chest/sandevistan
	name = "Militech Apogee Sandevistan"
	desc = "This model of Sandevistan doesn't exist, at least officially. Off the record, there's gossip of secret Militech Lunar labs producing covert cyberware. It was never meant to be mass produced, but an army would only really need a few pieces like this one to dominate their enemy."
	encode_info = AUGMENT_NT_HIGHLEVEL
	icon_state = "sandy"
	actions_types = list(/datum/action/item_action/organ_action/sandy)
	icon = 'monkestation/code/modules/cybernetics/icons/implants.dmi'

	COOLDOWN_DECLARE(in_the_zone)
	/// The bodypart overlay datum we should apply to whatever mob we are put into
	visual_implant = TRUE
	bodypart_overlay = /datum/bodypart_overlay/simple/sandy
	var/cooldown_time = 45 SECONDS

/obj/item/organ/internal/cyberimp/chest/sandevistan/ui_action_click()
	if((organ_flags & ORGAN_FAILING))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be broken..."))
		return

	if(!COOLDOWN_FINISHED(src, in_the_zone))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be recharging..."))
		return
	COOLDOWN_START(src, in_the_zone, cooldown_time)

	owner.AddComponent(/datum/component/after_image, 16, 0.5, TRUE)
	owner.AddComponent(/datum/component/slowing_field, 0.1, 5, 3)
	addtimer(CALLBACK(src, PROC_REF(exit_the_zone), owner), 15 SECONDS)


/obj/item/organ/internal/cyberimp/chest/sandevistan/proc/exit_the_zone(mob/living/exiter)
	var/datum/component/after_image = exiter.GetComponent(/datum/component/after_image)
	qdel(after_image)
	var/datum/component/slowing_field = exiter.GetComponent(/datum/component/slowing_field)
	qdel(slowing_field)

/datum/bodypart_overlay/simple/sandy
	icon = 'monkestation/code/modules/cybernetics/icons/implants.dmi'
	icon_state = "sandy_overlay"
	layers = EXTERNAL_ADJACENT


/obj/item/organ/internal/cyberimp/chest/sandevistan/refurbished
	name = "refurbished sandevistan"
	desc = "The branding has been scratched off of these and it looks hastily put together."

	cooldown_time = 65 SECONDS

/obj/item/organ/internal/cyberimp/chest/sandevistan/refurbished/ui_action_click(mob/user, actiontype)
	if(prob(45))
		if(iscarbon(user))
			var/mob/living/carbon/carbon = user
			carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
			to_chat(user, span_warning("You are overloaded with information and suffer some backlash."))
	. = ..()

/obj/item/organ/internal/cyberimp/chest/sandevistan/refurbished/exit_the_zone(mob/living/exiter)
	. = ..()
	exiter.adjustBruteLoss(10)
	to_chat(exiter, span_warning("Your body was not able to handle the strain of [src] causing you to experience some minor bruising."))


/datum/reagent/medicine/brain_healer
	name = "Brain Healer"
	description = "Efficiently restores brain damage."
	taste_description = "pleasant sweetness"
	color = "#A0A0A0" //mannitol is light grey, neurine is lighter grey
	ph = 10.4
	purity = REAGENT_STANDARD_PURITY


/datum/reagent/medicine/brain_healer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5 * REM * seconds_per_tick * normalise_creation_purity(), required_organtype = affected_organtype)
	..()


/obj/item/organ/internal/cyberimp/chest/chemvat
	name = "R.A.G.E. chemical system"
	desc = "Extremely dangerous system that fills the user with a mix of potent drugs."
	encode_info = AUGMENT_TG_LEVEL
	icon_state = "chemplant"
	icon = 'monkestation/code/modules/cybernetics/icons/implants.dmi'

	var/obj/item/clothing/mask/chemvat/forced
	var/obj/item/chemvat_tank/forced_tank

	var/max_ticks_cooldown = 20 SECONDS
	var/current_ticks_cooldown = 0

	var/list/reagent_list = list(
		/datum/reagent/determination = 2,
		/datum/reagent/medicine/c2/penthrite = 3 ,
		/datum/reagent/drug/bath_salts = 3 ,
		/datum/reagent/medicine/ephedrine = 3,
		/datum/reagent/medicine/brain_healer = 5,
	)

	var/mutable_appearance/overlay

/obj/item/organ/internal/cyberimp/chest/chemvat/on_life()
	if(!check_compatibility())
		return
		//Cost of refilling is a little bit of nutrition, some blood and getting jittery
	if(owner.nutrition > NUTRITION_LEVEL_STARVING && owner.blood_volume > BLOOD_VOLUME_SURVIVE && current_ticks_cooldown > 0)

		owner.nutrition -= 5
		owner.blood_volume--
		owner.adjust_jitter(1)
		owner.adjust_dizzy(1)

		current_ticks_cooldown -= SSmobs.wait

		return

	if(current_ticks_cooldown <= 0)
		current_ticks_cooldown = max_ticks_cooldown
		on_effect()

/obj/item/organ/internal/cyberimp/chest/chemvat/proc/on_effect()
	var/obj/effect/temp_visual/chempunk/punk = new /obj/effect/temp_visual/chempunk(get_turf(owner))
	punk.color = "#77BD5D"
	owner.reagents.add_reagent_list(reagent_list)

	overlay = mutable_appearance('icons/effects/effects.dmi', "biogas", ABOVE_MOB_LAYER)
	overlay.color = "#77BD5D"

	RegisterSignal(owner,COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(update_owner_overlay))

	addtimer(CALLBACK(src, PROC_REF(remove_overlay)),max_ticks_cooldown/2)

	to_chat(owner,"<span class = 'notice'> You feel a sharp pain as the cocktail of chemicals is injected into your bloodstream!</span>")
	return


/obj/item/organ/internal/cyberimp/chest/chemvat/proc/update_owner_overlay(atom/source, list/overlays)
	SIGNAL_HANDLER

	if(overlay)
		overlays += overlay

/obj/item/organ/internal/cyberimp/chest/chemvat/proc/remove_overlay()
	QDEL_NULL(overlay)

	UnregisterSignal(owner,COMSIG_ATOM_UPDATE_OVERLAYS)

/obj/item/organ/internal/cyberimp/chest/chemvat/Insert(mob/living/carbon/receiver, special, drop_if_replaced)
	. = ..()
	forced = new
	forced_tank = new

	if(receiver.wear_mask && !istype(receiver.wear_mask,/obj/item/clothing/mask/chemvat))
		receiver.dropItemToGround(receiver.wear_mask, TRUE)
		receiver.equip_to_slot(forced, ITEM_SLOT_MASK)
	if(!receiver.wear_mask)
		receiver.equip_to_slot(forced, ITEM_SLOT_MASK)

	if(receiver.back && !istype(receiver.back,/obj/item/chemvat_tank))
		receiver.dropItemToGround(receiver.back, TRUE)
		receiver.equip_to_slot(forced_tank, ITEM_SLOT_BACK)
	if(!receiver.back)
		receiver.equip_to_slot(forced_tank, ITEM_SLOT_BACK)

/obj/item/organ/internal/cyberimp/chest/chemvat/Remove(mob/living/carbon/organ_owner, special)
	. = ..()
	organ_owner.dropItemToGround(organ_owner.wear_mask, TRUE)
	organ_owner.dropItemToGround(organ_owner.back, TRUE)
	QDEL_NULL(forced)
	QDEL_NULL(forced_tank)

/obj/item/chemvat_tank
	name = "chemvat tank"

	icon_state = "chemvat_back_held"
	icon = 'monkestation/code/modules/cybernetics/icons/implants_onmob.dmi'
	worn_icon = 'monkestation/code/modules/cybernetics/icons/implants_onmob.dmi'
	worn_icon_state = "chemvat_back"

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/chemvat_tank/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)


/obj/item/clothing/mask/chemvat
	icon_state = "chemvat_mask_held"
	icon = 'monkestation/code/modules/cybernetics/icons/implants_onmob.dmi'
	worn_icon = 'monkestation/code/modules/cybernetics/icons/implants_onmob.dmi'
	worn_icon_state = "chemvat_mask"
	lefthand_file = null
	righthand_file = null

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/mask/chemvat/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
