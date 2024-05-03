/datum/design/security_blades
	name = "C.H.R.O.M.A.T.A. mantis blade implants"
	desc =  "High tech mantis blade implants, easily portable weapon, that has a high wound potential."
	id = "ci-set-mantis"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 3 SECONDS
	materials = list(/datum/material/iron = 2500, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/organ/internal/cyberimp/arm/item_set/mantis
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/security_itemset
	name = "combat cybernetics implant"
	desc =  "A powerful cybernetic implant that contains combat modules built into the user's arm."
	id = "ci-set-combat"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 3 SECONDS
	materials = list(/datum/material/iron = 2500, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/organ/internal/cyberimp/arm/item_set/combat
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

