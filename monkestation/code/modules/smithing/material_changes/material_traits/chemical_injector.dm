/datum/material_trait/chemical_injector
	name = "Chemical Injector"
	desc = "Based on the materials liquid flow injects chemicals into the wearer and those hit (scales with liquid flow)."
	///the reagent we are doused in
	var/datum/reagent/doused_reagent
	///have we doused
	var/doused = FALSE

/datum/material_trait/chemical_injector/on_trait_add(atom/movable/parent)
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(check_douse))

/datum/material_trait/chemical_injector/on_remove(atom/movable/parent)
	if(!doused)
		UnregisterSignal(parent, COMSIG_ATOM_ATTACKBY)

/datum/material_trait/chemical_injector/on_mob_attack(atom/movable/parent, datum/material_stats/host, mob/living/target, mob/living/attacker)
	if(iscarbon(target) && doused)
		target.reagents.add_reagent(doused_reagent, 5 * (0.01 * host.liquid_flow))

/datum/material_trait/chemical_injector/proc/check_douse(datum/source, atom/movable/target, mob/living/user)
	if(!is_reagent_container(target))
		return
	var/obj/item/reagent_containers/container = target
	var/list/viable_reagents = list()
	if(container.is_open_container())
		for(var/datum/reagent/reagent as anything in container.reagents.reagent_list)
			if(reagent.volume < 100)
				continue
			viable_reagents += reagent.type
	if(!length(viable_reagents))
		return
	doused_reagent = pick(viable_reagents)
	user.visible_message(span_notice("[user] douses the [source] in [initial(doused_reagent.name)]"))
	doused = TRUE
	UnregisterSignal(source, COMSIG_ATOM_ATTACKBY)
