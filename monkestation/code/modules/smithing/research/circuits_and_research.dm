/datum/design/board/material_analyzer
	name = "Material Analyzer Circuitboard"
	desc = "The circuit board for a slime market pad."
	id = "mat_analyzer"
	build_path = /obj/item/circuitboard/machine/material_analyzer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/circuitboard/machine/material_analyzer
	name = "Material Analyzer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/material_analyzer
	req_components = list(
		/datum/stock_part/matter_bin = 3,
		/datum/stock_part/manipulator = 2)
	needs_anchored = FALSE
