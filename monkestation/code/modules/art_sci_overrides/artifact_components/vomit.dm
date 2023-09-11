/datum/component/artifact/vomit
	associated_object = /obj/structure/artifact/vomit
	weight = ARTIFACT_UNCOMMON
	type_name = "Vomiting Inducer"
	activation_message = "starts emitting disgusting imagery!"
	deactivation_message = "falls silent, its aura dissipating!"
	valid_origins = list(
		/datum/artifact_origin/narsie,
		/datum/artifact_origin/wizard,
		/datum/artifact_origin/martian,
	) //silicons dont like organic stuff or something
	var/range = 0
	var/spew_range = 1
	var/spew_organs = FALSE
	var/constructed_flags = (MOB_VOMIT_MESSAGE)
	COOLDOWN_DECLARE(cooldown)

/datum/component/artifact/vomit/setup()
	switch(rand(1,100))
		if(1 to 84)
			range = rand(2,3)
		if(85 to 100) //15%
			range = rand(2,7)
	if(prob(12))
		constructed_flags |= MOB_VOMIT_STUN
		potency += 20
	if(prob(40))
		spew_range = rand(1,5)
		potency += spew_range
	if(prob(50))
		constructed_flags |= MOB_VOMIT_BLOOD
	potency += (range) * 4
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/component/artifact, artifact_deactivate)), round(30 * (potency * 10) SECONDS))

/datum/component/artifact/vomit/on_examine(atom/source, mob/user, list/examine_list)
	. = ..()
	var/mob/living/carbon/carbon = user
	if(active && istype(carbon) && carbon.stat < UNCONSCIOUS)
		//need to add a flag to an argument if it doesnt already exist and passes a prob(25)
		examine_list += span_warning("It has an [spew_organs ? "extremely" : ""] disgusting aura! [prob(20) ? "..is that a felinid?" : ""]")
		if(prob(25))
			carbon.vomit(vomit_flags = constructed_flags | MOB_VOMIT_STUN, distance = spew_range)
		else
			carbon.vomit(vomit_flags = constructed_flags, distance = spew_range)
		if(spew_organs && prob(40))
			carbon.spew_organ()

/datum/component/artifact/vomit/effect_process()
	for(var/mob/living/carbon/viewed in view(range, src))
		if(prob(100 - potency))
			continue
		if(prob(25))
			viewed.vomit(vomit_flags = constructed_flags | MOB_VOMIT_STUN, distance = spew_range)
		else
			viewed.vomit(vomit_flags = constructed_flags, distance = spew_range)
		if(spew_organs && prob(10))
			viewed.spew_organ()
