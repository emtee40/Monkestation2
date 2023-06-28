/datum/disease
	//Flags
	var/visibility_flags = 0
	var/disease_flags = CURABLE|CAN_CARRY|CAN_RESIST
	var/spread_flags = DISEASE_SPREAD_AIRBORNE | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN

	//Fluff
	var/form = "Virus"
	var/name = "No disease"
	var/desc = ""
	var/agent = "some microbes"
	var/spread_text = ""
	var/cure_text = ""

	//Stages
	var/stage = 1
	var/max_stages = 0
	/// The probability of this infection advancing a stage every second the cure is not present.
	var/stage_prob = 2

	//Other
	var/list/viable_mobtypes = list() //typepaths of viable mobs
	var/mob/living/carbon/affected_mob = null
	var/list/cures = list() //list of cures if the disease has the CURABLE flag, these are reagent ids
	/// The probability of spreading through the air every second
	var/infectivity = 41
	/// The probability of this infection being cured every second the cure is present
	var/cure_chance = 4
	var/carrier = FALSE //If our host is only a carrier
	var/bypasses_immunity = FALSE //Does it skip species virus immunity check? Some things may diseases and not viruses
	var/spreading_modifier = 1
	var/severity = DISEASE_SEVERITY_NONTHREAT
	var/list/required_organs = list()
	var/needs_all_cures = TRUE
	var/list/strain_data = list() //dna_spread special bullshit
	var/infectable_biotypes = MOB_ORGANIC //if the disease can spread on organics, synthetics, or undead
	var/process_dead = FALSE //if this ticks while the host is dead
	var/copy_type = null //if this is null, copies will use the type of the instance being copied

/datum/disease/Destroy()
	. = ..()
	if(affected_mob)
		remove_disease()
	SSdisease.active_diseases.Remove(src)

//add this disease if the host does not already have too many
/datum/disease/proc/try_infect(mob/living/infectee, make_copy = TRUE)
	infect(infectee, make_copy)
	return TRUE

//add the disease with no checks
/datum/disease/proc/infect(mob/living/infectee, make_copy = TRUE)
	var/datum/disease/D = make_copy ? Copy() : src
	LAZYADD(infectee.diseases, D)
	D.affected_mob = infectee
	SSdisease.active_diseases += D //Add it to the active diseases list, now that it's actually in a mob and being processed.

	D.after_add()
	infectee.med_hud_set_status()

	var/turf/source_turf = get_turf(infectee)
	log_virus("[key_name(infectee)] was infected by virus: [src.admin_details()] at [loc_name(source_turf)]")


///Proc to process the disease and decide on whether to advance, cure or make the sympthoms appear. Returns a boolean on whether to continue acting on the symptoms or not.
/datum/disease/proc/stage_act(seconds_per_tick, times_fired)
	var/slowdown = affected_mob.reagents.has_reagent(/datum/reagent/medicine/spaceacillin) ? 0.5 : 1 // spaceacillin slows stage speed by 50%

	if(has_cure())
		if(disease_flags & CHRONIC && SPT_PROB(cure_chance, seconds_per_tick))
			update_stage(1)
			to_chat(affected_mob, span_notice("Your chronic illness is alleviated a little, though it can't be cured!"))
			return
		if(SPT_PROB(cure_chance, seconds_per_tick))
			update_stage(max(stage - 1, 1))
		if(disease_flags & CURABLE && SPT_PROB(cure_chance, seconds_per_tick))
			cure()
			return FALSE
	else if(SPT_PROB(stage_prob*slowdown, seconds_per_tick))
		update_stage(min(stage + 1, max_stages))

	return !carrier


/datum/disease/proc/update_stage(new_stage)
	stage = new_stage

/datum/disease/proc/has_cure()
	if(!(disease_flags & CURABLE | CHRONIC))
		return FALSE

	. = cures.len
	for(var/C_id in cures)
		if(!affected_mob.reagents.has_reagent(C_id))
			.--
	if(!. || (needs_all_cures && . < cures.len))
		return FALSE

//Airborne spreading
/datum/disease/proc/spread(force_spread = 0)
	if(!affected_mob)
		return

	if(!(spread_flags & DISEASE_SPREAD_AIRBORNE) && !force_spread)
		return

	if(affected_mob.reagents.has_reagent(/datum/reagent/medicine/spaceacillin) || (affected_mob.satiety > 0 && prob(affected_mob.satiety/10)))
		return

	var/spread_range = 2

	if(force_spread)
		spread_range = force_spread

	var/turf/T = affected_mob.loc
	if(istype(T))
		for(var/mob/living/carbon/C in oview(spread_range, affected_mob))
			var/turf/V = get_turf(C)
			if(disease_air_spread_walk(T, V))
				C.AirborneContractDisease(src, force_spread)

/proc/disease_air_spread_walk(turf/start, turf/end)
	if(!start || !end)
		return FALSE
	while(TRUE)
		if(end == start)
			return TRUE
		var/turf/Temp = get_step_towards(end, start)
		if(!TURFS_CAN_SHARE(end, Temp)) //Don't go through a wall
			return FALSE
		end = Temp


/datum/disease/proc/cure(add_resistance = TRUE)
	if(severity == DISEASE_SEVERITY_UNCURABLE) //aw man :(
		return
	if(affected_mob)
		if(add_resistance && (disease_flags & CAN_RESIST))
			LAZYOR(affected_mob.disease_resistances, GetDiseaseID())
	qdel(src)

/datum/disease/proc/IsSame(datum/disease/D)
	if(istype(D, type))
		return TRUE
	return FALSE


/datum/disease/proc/Copy()
	//note that stage is not copied over - the copy starts over at stage 1
	var/static/list/copy_vars = list("name", "visibility_flags", "disease_flags", "spread_flags", "form", "desc", "agent", "spread_text",
									"cure_text", "max_stages", "stage_prob", "viable_mobtypes", "cures", "infectivity", "cure_chance",
									"bypasses_immunity", "spreading_modifier", "severity", "required_organs", "needs_all_cures", "strain_data",
									"infectable_biotypes", "process_dead")

	var/datum/disease/D = copy_type ? new copy_type() : new type()
	for(var/V in copy_vars)
		var/val = vars[V]
		if(islist(val))
			var/list/L = val
			val = L.Copy()
		D.vars[V] = val
	return D

/datum/disease/proc/after_add()
	return


/datum/disease/proc/GetDiseaseID()
	return "[type]"

/datum/disease/proc/remove_disease()
	LAZYREMOVE(affected_mob.diseases, src) //remove the datum from the list
	affected_mob.med_hud_set_status()
	affected_mob = null

/**
 * Checks the given typepath against the list of viable mobtypes.
 *
 * Returns TRUE if the mob_type path is derived from of any entry in the viable_mobtypes list.
 * Returns FALSE otherwise.
 *
 * Arguments:
 * * mob_type - Type path to check against the viable_mobtypes list.
 */
/datum/disease/proc/is_viable_mobtype(mob_type)
	for(var/viable_type in viable_mobtypes)
		if(ispath(mob_type, viable_type))
			return TRUE

	// Let's only do this check if it fails. Did some genius coder pass in a non-type argument?
	if(!ispath(mob_type))
		stack_trace("Non-path argument passed to mob_type variable: [mob_type]")

	return FALSE

//Use this to compare severities
/proc/get_disease_severity_value(severity)
	switch(severity)
		if(DISEASE_SEVERITY_UNCURABLE)
			return 0
		if(DISEASE_SEVERITY_POSITIVE)
			return 1
		if(DISEASE_SEVERITY_NONTHREAT)
			return 2
		if(DISEASE_SEVERITY_MINOR)
			return 3
		if(DISEASE_SEVERITY_MEDIUM)
			return 4
		if(DISEASE_SEVERITY_HARMFUL)
			return 5
		if(DISEASE_SEVERITY_DANGEROUS)
			return 6
		if(DISEASE_SEVERITY_BIOHAZARD)
			return 7
