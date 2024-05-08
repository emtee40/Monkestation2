/datum/techweb_node/monkeysec
	id = "sec_adv"
	display_name = "Advanced Security Equipment"
	description = "Advanced equipment used by security."
	prereq_ids = list("sec_basic")
	design_ids = list(
		"rubber_c35", //Moves nonmodular sec edits to here. Might aswell.
		"stungloves_empty"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)


/datum/design/stunglove_empty //tacking this onto basic sectech
	name = "Mark-Three Stungloves"
	desc = "A specialized set of tools. Wraps around an Officer's hand, and projects an energy field while enabled - allowing punches to successfully stun a target."
	id = "stungloves_empty"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT*9, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT*6, /datum/material/titanium =SMALL_MATERIAL_AMOUNT*8) //Low titanium cost.
	build_path = /obj/item/melee/baton/security/stungloves
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE
