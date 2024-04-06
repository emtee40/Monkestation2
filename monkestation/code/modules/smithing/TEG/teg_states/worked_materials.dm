//this is essentially the base state as it triggers if nothing else can.
/datum/thermoelectric_state/worked_material
	var/initial_scale = 0

/datum/thermoelectric_state/worked_material/on_apply()
	var/obj/machinery/power/thermoelectric_generator/parent = owner.resolve()
	if(!parent.conductor)
		on_remove()
		return

	var/electrical_conductivity = 50
	var/thermal_conductivity = 50
	var/scale_shift = 0

	initial_scale = parent.base_scale
	var/datum/component/worked_material/conductor = parent.conductor.GetComponent(/datum/component/worked_material)
	if(conductor.conductivity)
		electrical_conductivity = conductor.conductivity
	if(conductor.thermal)
		thermal_conductivity = conductor.thermal


	scale_shift = clamp(((2 * electrical_conductivity / thermal_conductivity) - 2) * 10 , -20, 40)

	parent.base_scale = clamp(parent.base_scale + scale_shift, initial_scale * 0.5, initial_scale * 1.5)

/datum/thermoelectric_state/worked_material/on_remove()
	var/obj/machinery/power/thermoelectric_generator/parent = owner.resolve()
	parent.base_scale = initial_scale
