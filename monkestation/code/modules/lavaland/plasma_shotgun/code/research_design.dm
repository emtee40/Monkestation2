/datum/design/plasmacutter_shotgun
	name = "plasma cutter shotgun"
	desc = "An industrial-grade heavy-duty mining shotgun"
	id = "plasmacutter_shotgun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 1000, /datum/material/plasma = 20000, /datum/material/diamond = 10000) // extremelly expensive diamond wise
	build_path = /obj/item/gun/energy/plasmacutter/scatter
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
