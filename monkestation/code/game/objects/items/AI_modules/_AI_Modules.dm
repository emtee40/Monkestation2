/obj/item/ai_module/core/full
	var/law_id // if non-null, loads the laws from the ai_laws datums

/obj/item/ai_module/core/full/Initialize(mapload)
	. = ..()
	if(!law_id)
		return
	var/lawtype = lawid_to_type(law_id)
	if(!lawtype)
		return
	var/datum/ai_laws/core_laws = new lawtype
	laws = core_laws.inherent
