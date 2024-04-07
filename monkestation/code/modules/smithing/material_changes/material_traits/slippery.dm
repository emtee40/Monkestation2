/datum/material_trait/slippery
	name = "Slippery"
	reforges = 2

/datum/material_trait/slippery/on_process(atom/movable/parent, datum/component/worked_material/host)
	. = ..()
	if(prob(50))
		return
	var/atom/parent_source = parent.loc
	if(istype(parent_source, /obj/machinery/electroplater))
		return
	if(ismob(parent_source))
		var/mob/mob = parent_source
		mob.dropItemToGround(parent, TRUE)

	parent_source.slipped_out(parent)
	parent.forceMove(get_turf(parent))


/atom/proc/slipped_out(atom/movable/slipped)
	return

/obj/machinery/power/thermoelectric_generator/slipped_out(atom/movable/slipped)
	if(slipped == conductor)
		remove_teg_state(/datum/thermoelectric_state/worked_material)
		conductor = null
