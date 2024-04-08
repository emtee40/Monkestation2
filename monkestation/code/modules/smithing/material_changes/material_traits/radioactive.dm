/datum/material_trait/radioactive
	name = "Radioactive"

/datum/material_trait/radioactive/on_process(atom/movable/parent, datum/component/worked_material/host)
	radiation_pulse(get_turf(parent), max_range = 2 * host.radioactivity * 0.01, threshold = 0.05)
