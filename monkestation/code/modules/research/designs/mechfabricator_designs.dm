/datum/design/borg_upgrade_uwu
	name = "Cyborg UwU-speak \"Upgrade\""
	id = "borg_upgrade_cringe"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/uwu
	materials = list(/datum/material/gold = 2000, /datum/material/diamond = 1000, /datum/material/bluespace = 500)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

//IPC Parts//

//Bodyparts//
/datum/design/ipc_part_head
	name = "IPC Replacement Head"
	id = "ipc_head"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 500)
	build_path = /obj/item/bodypart/head/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_part_chest
	name = "IPC Replacement Chest"
	id = "ipc_chest"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 5000)
	build_path = /obj/item/bodypart/chest/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_part_arm_left
	name = "IPC Replacement Left Arm"
	id = "ipc_arm_left"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/bodypart/arm/left/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_part_arm_right
	name = "IPC Replacement Right Arm"
	id = "ipc_arm_right"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/bodypart/arm/right/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_part_leg_left
	name = "IPC Replacement Left Leg"
	id = "ipc_leg_left"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/bodypart/leg/left/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_part_leg_right
	name = "IPC Replacement Right Leg"
	id = "ipc_leg_right"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 250
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/bodypart/leg/right/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

//Organs
/datum/design/ipc_organ_heart
	name = "IPC Replacement Heart"
	id = "ipc_heart"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 40
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/internal/heart/cybernetic/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_organ_liver
	name = "IPC Replacement Substance Processor"
	id = "ipc_liver"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 40
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/internal/liver/cybernetic/upgraded/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_organ_stomach
	name = "IPC Replacement Micro-Cell"
	id = "ipc_stomach"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 40
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/internal/stomach/ethereal/battery/ipc
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_organ_ears
	name = "IPC Replacement Auditory Sensors"
	id = "ipc_ears"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 40
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/internal/ears/robot
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/ipc_organ_butt
	name = "IPC Replacement Flatulence Simulator"
	id = "ipc_butt"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 40
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/internal/butt/cyber
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

//IPC eyes are just regular robotic ones. so theyre not added here.
