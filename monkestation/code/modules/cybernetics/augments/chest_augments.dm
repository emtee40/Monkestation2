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

/obj/item/organ/internal/cyberimp/chest/sandevistan/ui_action_click()
	if((organ_flags & ORGAN_FAILING))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be broken..."))
		return

	if(!COOLDOWN_FINISHED(src, in_the_zone))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be recharging..."))
		return
	COOLDOWN_START(src, in_the_zone, 45 SECONDS)

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
