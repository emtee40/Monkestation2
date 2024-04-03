///basically we need some form of storage for atoms. This is added whenever we start forging a custom material so that we don't
///need to create materials for all objects to modify.
/datum/component/worked_material
	///material conductivity [0 no conductivity - 100 no loss in energy]
	var/conductivity = 0
	///material hardness [0 super soft - 100 hard as steel]
	var/hardness = 0
	///material density [0 is light - 100 is super dense]
	var/density = 0
	///materials thermal transfer [0 means no thermal energy is transfered - 100 means all of it is]
	var/thermal = 0
	///flammability (basically incase you splice plasma) [0 not flammable - 100 will instantly ignite]
	var/flammability = 0
	///our radioactivity (from splicing uranium) [0 not radioactive - 100 god help me my skin is melting]
	var/radioactivity = 0
	///snowflake chemical transferrence for use with infusions [0 blocks all transfer - 100 is a pure stream]
	var/liquid_flow = 0
	///our refractiveness
	var/refractiveness = 0

	///list of material traits to work with
	var/list/material_traits = list()

	var/first_add = TRUE
	///our coolass color
	var/merged_color

/datum/component/worked_material/RegisterWithParent()
	. = ..()
	//RegisterSignal(parent, COMSIG_MATERIAL_STAT_CHANGE, PROC_REF(modify_stats))
	RegisterSignal(parent, COMSIG_MATERIAL_MERGE_MATERIAL, PROC_REF(merge_material))

/datum/component/worked_material/proc/merge_material(obj/item/source, obj/item/merger)
	if(merger.GetComponent(/datum/component/worked_material))
		component_merge(merger.GetComponent(/datum/component/worked_material))
	else
		if(!isstack(merger))
			return
		var/obj/item/stack/stack = merger
		var/datum/material/material = GET_MATERIAL_REF(stack.material_type)

		if(first_add)
			merged_color = material.greyscale_colors
		else
			merged_color = BlendRGB(merged_color, material.greyscale_colors)
		if(material.conductivity)
			conductivity += material.conductivity
			if(!first_add)
				conductivity *= 0.5
		if(material.hardness)
			hardness += material.hardness
			if(!first_add)
				hardness *= 0.5
		if(material.density)
			density += material.density
			if(!first_add)
				density *= 0.5
		if(material.thermal)
			thermal += material.thermal
			if(!first_add)
				thermal *= 0.5
		if(material.flammability)
			flammability += material.flammability
			if(!first_add)
				flammability *= 0.5
		if(material.radioactivity)
			radioactivity += material.radioactivity
			if(!first_add)
				radioactivity *= 0.5
		if(material.liquid_flow)
			liquid_flow += material.liquid_flow
			if(!first_add)
				liquid_flow *= 0.5
		if(material.refractiveness)
			refractiveness += material.refractiveness
			if(!first_add)
				refractiveness *= 0.5

		for(var/datum/material_trait/trait as anything in material.material_traits)
			var/passed = TRUE
			for(var/datum/material_trait/owned_traits as anything in material_traits)
				if(owned_traits.type != trait)
					continue
				passed = FALSE
				break
			if(!passed)
				continue
			var/datum/material_trait/new_trait = new trait
			material_traits |= new_trait
			new_trait.on_trait_add(parent)

		if(first_add)
			first_add = FALSE

	var/atom/movable/movable = parent
	movable.color = merged_color

/datum/component/worked_material/proc/component_merge(datum/component/worked_material/material)
	if(first_add)
		if(!material.merged_color)
			merged_color = "#FFFFFF"
		else
			merged_color = material.merged_color
	else
		merged_color = BlendRGB(merged_color, material.merged_color)

	if(material.conductivity)
		conductivity += material.conductivity
		if(!first_add)
			conductivity *= 0.5
	if(material.hardness)
		hardness += material.hardness
		if(!first_add)
			hardness *= 0.5
	if(material.density)
		density += material.density
		if(!first_add)
			density *= 0.5
	if(material.thermal)
		thermal += material.thermal
		if(!first_add)
			thermal *= 0.5
	if(material.flammability)
		flammability += material.flammability
		if(!first_add)
			flammability *= 0.5
	if(material.radioactivity)
		radioactivity += material.radioactivity
		if(!first_add)
			radioactivity *= 0.5
	if(material.liquid_flow)
		liquid_flow += material.liquid_flow
		if(!first_add)
			liquid_flow *= 0.5
	if(material.refractiveness)
		refractiveness += material.refractiveness
		if(!first_add)
			refractiveness *= 0.5

	for(var/datum/material_trait/trait as anything in material.material_traits)
		var/passed = TRUE
		for(var/datum/material_trait/owned_traits as anything in material_traits)
			if(owned_traits.type != trait.type)
				continue
			passed = FALSE
			break
		if(!passed)
			continue
		var/datum/material_trait/new_trait = new trait.type
		material_traits |= new_trait
		new_trait.on_trait_add(parent)

	if(first_add)
		first_add = FALSE

	var/atom/movable/movable = parent
	movable.color = merged_color
