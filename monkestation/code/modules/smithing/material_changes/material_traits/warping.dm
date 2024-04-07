/datum/material_trait/warping
	name = "Warping"
	reforges = 2

/datum/material_trait/warping/on_process(atom/movable/parent, datum/component/worked_material/host)
	. = ..()
	if(prob(90))
		return

	var/list/turfs = list()
	for(var/turf/turf in view(7,get_turf(parent)))
		turfs |= turf

	var/turf/picked = pick(turfs)
	if(isturf(parent.loc))
		do_teleport(parent, picked)

	else
		if(ismob(parent.loc))
			var/mob/living/location = parent.loc
			do_teleport(location, picked)
