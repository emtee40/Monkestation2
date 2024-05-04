/datum/techweb_node/sec_basic
	design_ids = list(
		"bola_energy",
		"evidencebag",
		"pepperspray",
		"seclite",
		"zipties",
		"inspector",
		"rubber_c35" //Moves nonmodular sec edits to here. Might aswell.
		//"stungloves_empty"
	)

/datum/design/stunglove_empty //tacking this onto basic sectech
	name = "Mark-Three Stungloves"
	desc = "A specialized set of tools. Wraps around an Officer's hand, and projects an energy field while enabled - allowing hugs, punches, and disarms to successfully stun a target."
	id = "stungloves_empty"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT*3, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SMALL_MATERIAL_AMOUNT*2) //Low titanium cost.
	build_path = /obj/item/melee/baton/security/stungloves
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE
