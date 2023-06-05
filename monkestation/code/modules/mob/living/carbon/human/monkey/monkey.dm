/mob/living/carbon/human/species/monkey/ook
	name = "Ook"
	unique_name = FALSE
	use_random_name = FALSE
	ai_controller = /datum/ai_controller/monkey/ook
	var/ancestor_name
	var/ancestor_chain = 1
	var/relic_hat
	var/relic_mask
	var/memory_saved = FALSE

/mob/living/carbon/human/species/monkey/ook/Initialize(mapload)
	var/name_to_use = name

	if(ancestor_name)
		name_to_use = ancestor_name
		if(ancestor_chain > 1)
			name_to_use += " \Roman[ancestor_chain]"
	else if(prob(10))
		name_to_use = pick(list("Ook Man", "Monke Boy", "The Duke of Ook"))

	. = ..()

	fully_replace_character_name(real_name, name_to_use)

	//These have to be after the parent new to ensure that the monkey
	//bodyparts are actually created before we try to equip things to
	//those slots
	if(ancestor_chain > 1)
		generate_fake_scars(rand(ancestor_chain, ancestor_chain * 4))
	if(relic_hat)
		equip_to_slot_or_del(new relic_hat, ITEM_SLOT_HEAD)
	if(relic_mask)
		equip_to_slot_or_del(new relic_mask, ITEM_SLOT_MASK)
