/datum/material/gold
	conductivity = 70
	density = 50
	hardness = 15
	refractiveness = 45
	thermal = 70
	material_traits = list(/datum/material_trait/shiny)

/datum/material/iron
	density = 40
	hardness = 30

/datum/material/diamond
	hardness = 80
	refractiveness = 70
	conductivity = 1
	density = 80

/datum/material/plasma //this will combust like crazy so its hard to use but worth it if you can
	flammability = 100
	hardness = 10
	conductivity = 85
	density = 10

/datum/material/uranium
	radioactivity = 100
	hardness = 45
	density = 90
	thermal = 80
	material_traits = list(/datum/material_trait/radioactive)

/datum/material/bananium
	radioactivity = 45
	conductivity = 30
	density = 60
	hardness = 70
	thermal = 1
	liquid_flow = 65
	material_traits = list(/datum/material_trait/honk_blessed)

/datum/material/mythril
	liquid_flow = 80
	thermal = 85
	refractiveness = -25
	hardness = 100
	density = 100
	material_traits = list(/datum/material_trait/magical, /datum/material_trait/weak_weapon)
