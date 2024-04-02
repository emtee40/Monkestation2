/datum/material
	// THESE VARS ARE GLOBAL NEVER NEVER NEVER ADJUST THIS AS IT WILL AFFECT EVERYTHING THAT USES THE STATS OF THIS

	///material conductivity [0 no conductivity - 100 no loss in energy]
	var/conductivity = 50
	///material hardness [0 super soft - 100 hard as steel]
	var/hardness = 50
	///material density [0 is light - 100 is super dense]
	var/density = 50
	///materials thermal transfer [0 means no thermal energy is transfered - 100 means all of it is]
	var/thermal = 50
	///flammability (basically incase you splice plasma) [0 not flammable - 100 will instantly ignite]
	var/flammability = 0
	///our radioactivity (from splicing uranium) [0 not radioactive - 100 god help me my skin is melting]
	var/radioactivity = 0
	///snowflake chemical transferrence for use with infusions [0 blocks all transfer - 100 is a pure stream]
	var/liquid_flow = 0
	///list of material traits to work with
	var/list/material_traits = list()
