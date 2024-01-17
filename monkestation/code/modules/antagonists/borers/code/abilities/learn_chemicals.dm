/// If a borer learns this amount of chemicals from blood, it will count for their objective
#define BLOOD_CHEM_OBJECTIVE 3

/// How many chemicals does a borer need to count for the objective. We use this exclusivelly for text on the end-round-panel
GLOBAL_VAR_INIT(objective_blood_chem, 3)

/// Whats the borers progress on getting the chemical objective done?
GLOBAL_VAR_INIT(successful_blood_chem, 0)

/// How many borers should have to learn "objective_blood_chem" amount of chemicals before we count the objective as complete
GLOBAL_VAR_INIT(objective_blood_borer, 3)

/**
 * Lets borers learn pre-coded chemicals in the "potential_chemicals" list
 */
/datum/action/cooldown/borer/upgrade_chemical
	name = "Learn New Chemical"
	button_icon_state = "bloodlevel"
	chemical_evo_points = 1

/datum/action/cooldown/borer/upgrade_chemical/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!length(cortical_owner.potential_chemicals))
		owner.balloon_alert(owner, "all chemicals learned")
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.potential_chemicals)
	if(!reagent_choice)
		owner.balloon_alert(owner, "no chemical chosen")
		return
	cortical_owner.chemical_evolution -= chemical_evo_points
	cortical_owner.known_chemicals += reagent_choice
	cortical_owner.potential_chemicals -= reagent_choice
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5 * cortical_owner.host_harm_multiplier)
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	if(!HAS_TRAIT(cortical_owner.human_host, TRAIT_AGEUSIA))
		to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

/**
 * Lets borers learn chemicals that the host they reside in currently possess unless its in the "blacklisted_chemicals" list
 * This ability is required for one of the borer's objectives
 */
/datum/action/cooldown/borer/learn_bloodchemical
	name = "Learn Chemical from Blood"
	button_icon_state = "bloodchem"
	chemical_evo_points = 5

/datum/action/cooldown/borer/learn_bloodchemical/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(length(cortical_owner.human_host.reagents.reagent_list) <= 0)
		owner.balloon_alert(owner, "no reagents in host")
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.human_host.reagents.reagent_list)
	if(!reagent_choice)
		owner.balloon_alert(owner, "chemical not chosen")
		return
	if(locate(reagent_choice) in cortical_owner.known_chemicals)
		owner.balloon_alert(owner, "chemical already known")
		return
	if(locate(reagent_choice) in cortical_owner.blacklisted_chemicals)
		owner.balloon_alert(owner, "chemical blacklisted")
		return
	if(!(reagent_choice.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED))
		owner.balloon_alert(owner, "cannot learn [initial(reagent_choice.name)]")
		return
	cortical_owner.chemical_evolution -= chemical_evo_points
	cortical_owner.known_chemicals += reagent_choice.type
	cortical_owner.blood_chems_learned++
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5 * cortical_owner.host_harm_multiplier)
	if(cortical_owner.blood_chems_learned == BLOOD_CHEM_OBJECTIVE)
		GLOB.successful_blood_chem += 1
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	if(!HAS_TRAIT(cortical_owner.human_host, TRAIT_AGEUSIA))
		to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

#undef BLOOD_CHEM_OBJECTIVE
