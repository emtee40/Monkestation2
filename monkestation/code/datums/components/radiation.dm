//Today we will do cool shit with the funny green
//-Atmosian moments before dying to Fusion

//HANDLES A VERY BASIC EDIT TO HELP SAVE ON PROCESSING\\

//YES IT IS MESSY
/mob/living/carbon/human
	var/cached_clothing_resistance //Literally just handles this like baycode because its cheap, dirty and efficient. Means we have to do way less processing later on in the component AND the subsystem for radiation

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(reset_resistances))

/mob/living/carbon/human/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(reset_resistances))

/mob/living/carbon/human/proc/reset_resistances()
	cached_clothing_resistance = null //I hate having to do this but it's the fastest and least painful way.

//Handles coefficients and minimum amounts involving mobs and humans
#define RADIATION_DAMAGE_COEFFICIENT 1.025 //Becquerel-based damage (immediate transfer)
#define RADIATION_LINGER_DIVISOR 2.45 //Manages Grays (total absorbed dose)
#define RADIATION_MINIMUM_BURN_AMOUNT 40 //Where the RADIATION_DAMAGE_COEFFICIENT will be utilised to determine how much burn you should recieve, unlucky sod.
#define RADIATION_MINIMUM_MUTATION 60 //You've lost or gained chromies above this point, bud.
#define RADIATION_CYCLE_COOLDOWN 25 //~25 seconds or TICKS depending on how its defined. Controls how fast radiation cycles in you.

//Handles exposure -> gray conversions and will be used to calculate the severity of effects
#define RADIATION_LIGHT_SICKNESS_EXPOSURE 0.34 //Minor effects
#define RADIATION_MEDIUM_SICKNESS_EXPOSURE 0.85 //You're starting to vomit blood and have increased chances to randomly gain a pathogen (weakened immune system)
#define RADIATION_HEAVY_SICKNESS_EXPOSURE 1.25 //1 and a Quarter Grays will render you medical-ridden for a good five to ten minutes for treatment
#define GRAY_DEATH_KNELL_EXPOSURE 4 //Over 4 Grays of exposure and you have less than a 50% chance to live, even with immediate medical attention.

//Handles the contamination system. Touch with caution.
#define RADIATION_CONTAMINATION_THRESHOLD 90 //At what input energy does radiation cause contamination?
#define RADIATION_GLOW_THRESHOLD 25 //Contam threshold to glow!
#define RADIATION_JUMP_THRESHOLD 150 //This is where shit gets real. Handles when objects are irradiated so badly from a nearby source they ALSO become radioactive. Essentially inducing an isotope to form because a heavy particle (alpha/beta) collide with a nearby atom and knock a neutron or electron out of place, causing it to potentially form a radioactive isotope.
#define RADIATION_JUMP_COOLDOWN 95 //This should stop lag from obliterating the server
#define RADIATION_MIN_SPACE_PROCESS 25 //Radiation below this limit will NOT cross space tiles when trying to contaminate.

/// This component will control the basic mechanics of applying damage to a majority of mobs, handling contamination and radiation injuries on humans.
/// Humans WILL die if left irradiated for more than ~10 minutes, and irradiation is silent. Contamination is not. Contamination (spreadable radiation) will last until cleaned off, and internal radiation must be treated via potassium iodide, or other similar toxin-cleaning chem that SPECIFICALLY removes reagents from their body.
/datum/component/irradiated
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/beginning_of_irradiation //Tracks when the irradiation first started in world ticks

	var/host_immunity //Is the host FULLY immune to rads? This doesn't mean they won't be CONTAMINATED.
	var/host_protected //Is the host merely protected? This means they won't suffer EXPOSURE but can still be CONTAMINATED.
	var/host_fucked //Is the host NOT protected and NOT immune? This means they are capable of being EXPOSED and CONTAMINATED.

	var/total_dose = 0 //total dose recieved
	var/absorbed_energy = 50 //total ENERGY - measured in seiverts - recieved. Multiplied with beginning_of_irradiation to get...
	var/absorbed_grays = 0 //Total absorbed Grays. Might also use seiverts if I'm feeling quirky
	var/held_contamination = 1 //Any goopers chat?

	var/dosebefore //important
	var/doseafter //doubly so
	COOLDOWN_DECLARE(radprocessing)
	COOLDOWN_DECLARE(absorbrads)
	COOLDOWN_DECLARE(radjumping)

/datum/component/irradiated/Initialize()
	if (CANNOT_IRRADIATE(parent)) //lol, lmao
		return COMPONENT_INCOMPATIBLE

	// Hey fun fact (rad immunity will only prevent damage here)
	if (HAS_TRAIT(parent, TRAIT_RADIMMUNE))
		host_immunity = TRUE

	if(isturf(parent)) // OH NO
		qdel(src) //You should QDEL YOURSELF... NOW!

	ADD_TRAIT(parent, TRAIT_IRRADIATED, REF(src))

	beginning_of_irradiation = world.time

	if (ishuman(parent)) // oh you are so fucked
		var/mob/living/carbon/human/human_parent = parent
		if(human_parent.cached_clothing_resistance == TRUE) //This has to be ran EVERY single tick. Keep the math simple.
			host_protected = TRUE

		START_PROCESSING(SSobj, src)

		COOLDOWN_START(src, radprocessing, RADIATION_CYCLE_COOLDOWN) //How often do we process?
		COOLDOWN_START(src, absorbrads, 15 SECONDS) //Takes 15 seconds to absorb a specific amount of radiation directly into your body
		COOLDOWN_START(src, radjumping, RADIATION_JUMP_COOLDOWN) //Anti-crash

		start_burn_splotch_timer()

		human_parent.throw_alert(ALERT_IRRADIATED, /atom/movable/screen/alert/Contaminated)

/datum/component/irradiated/RegisterWithParent()
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(on_clean))
	RegisterSignal(parent, COMSIG_GEIGER_COUNTER_SCAN, PROC_REF(on_geiger_counter_scan))

/datum/component/irradiated/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_GEIGER_COUNTER_SCAN,
	))

/datum/component/irradiated/Destroy(force, silent)
	var/atom/movable/parent_movable = parent
	if (istype(parent_movable))
		parent_movable.remove_filter("rad_glow")

	var/mob/living/carbon/human/human_parent = parent
	if (istype(human_parent))
		human_parent.clear_alert(ALERT_IRRADIATED)

	REMOVE_TRAIT(parent, TRAIT_IRRADIATED, REF(src))

	STOP_PROCESSING(SSobj, src)

	return ..()

/datum/component/irradiated/process(seconds_per_tick)
	if (COOLDOWN_FINISHED(src, radprocessing))
		if(ishuman(parent))
			process_human_effects(parent, seconds_per_tick) //No return post-call. It's a progressive condition and doesn't stop. Treat it or die.
		if(ismovable(parent) && (held_contamination >= RADIATION_GLOW_THRESHOLD || doseafter - dosebefore >= 30)) //If the doseafter && dosebefore subtracted is >= 30 that means there must have been atleast a rise of 30.
			process_contamination_effects(parent)
		COOLDOWN_START(src, radprocessing, RADIATION_CYCLE_COOLDOWN)
	if (should_halt_effects(parent))
		return

/datum/component/irradiated/proc/process_contamination_effects(var/parent)
	if(held_contamination >= RADIATION_GLOW_THRESHOLD)
		var/atom/movable/parent_movable = parent
		if(!parent_movable.get_filter("rad_glow"))
			create_glow()
		else if(parent_movable.get_filter("rad_glow"))
			remove_glow()

/datum/component/irradiated/proc/spread_to_nearby()

/datum/component/irradiated/proc/should_halt_effects(mob/living/carbon/human/target)
	if (HAS_TRAIT(target, TRAIT_STASIS))
		return TRUE

	if (HAS_TRAIT(target, TRAIT_HALT_RADIATION_EFFECTS))
		return TRUE

	return FALSE

/datum/component/irradiated/proc/process_human_effects(mob/living/carbon/human/target, seconds_per_tick)
	if (!COOLDOWN_FINISHED(src, absorbrads))
		return

/datum/component/irradiated/proc/start_burn_splotch_timer()
//	addtimer(CALLBACK(src, PROC_REF(give_burn_splotches)), rand(RADIATION_BURN_INTERVAL_MIN, RADIATION_BURN_INTERVAL_MAX), TIMER_STOPPABLE)

/datum/component/irradiated/proc/create_glow()
	var/atom/movable/parent_movable = parent
	if (!istype(parent_movable))
		return

	parent_movable.add_filter("rad_glow", 2, list("type" = "outline", "color" = "#67f04f0a", "size" = 2)) //Extremely difficult to notice (hopefully)
	addtimer(CALLBACK(src, PROC_REF(start_glow_loop), parent_movable), rand(0.1 SECONDS, 1.9 SECONDS)) // Things should look uneven

/datum/component/irradiated/proc/remove_glow()
	var/atom/movable/parent_movable = parent
	if (!istype(parent_movable))
		return
	if(parent_movable.get_filter("rad_glow"))
		parent_movable.remove_filter("rad_glow")

/datum/component/irradiated/proc/start_glow_loop(atom/movable/parent_movable)
	var/filter = parent_movable.get_filter("rad_glow")
	if (!filter)
		return

	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 25, time = 2.5 SECONDS)

/datum/component/irradiated/proc/on_clean(datum/source, clean_types)
	SIGNAL_HANDLER

	if (!(clean_types & CLEAN_TYPE_RADIATION))
		return

	if (isitem(parent))
		qdel(src)
		return COMPONENT_CLEANED

//	COOLDOWN_START(src, clean_cooldown, RADIATION_CLEAN_IMMUNITY_TIME)

/datum/component/irradiated/proc/on_geiger_counter_scan(datum/source, mob/user, obj/item/geiger_counter/geiger_counter)
	SIGNAL_HANDLER

	if (isliving(source))
		var/mob/living/living_source = source
		to_chat(user, span_boldannounce("[icon2html(geiger_counter, user)] Subject is irradiated. Contamination traces back to roughly [DisplayTimeText(world.time - beginning_of_irradiation, 5)] ago. Current toxin levels: [living_source.getToxLoss()]."))
	else
		// In case the green wasn't obvious enough...
		to_chat(user, span_boldannounce("[icon2html(geiger_counter, user)] Target is irradiated."))

	return COMSIG_GEIGER_COUNTER_SCAN_SUCCESSFUL

/atom/movable/screen/alert/Contaminated
	name = "Contaminated"
	desc = "A faint waver of heat radiates from your skin and clothing, while your stomach aches..."
	icon_state = ALERT_IRRADIATED


#undef RADIATION_DAMAGE_COEFFICIENT
#undef RADIATION_LINGER_DIVISOR
#undef RADIATION_MINIMUM_BURN_AMOUNT
#undef RADIATION_MINIMUM_MUTATION
#undef RADIATION_CYCLE_COOLDOWN

//Handles exposure -> gray conversions and will be used to calculate the severity of effects
#undef RADIATION_LIGHT_SICKNESS_EXPOSURE
#undef RADIATION_MEDIUM_SICKNESS_EXPOSURE
#undef RADIATION_HEAVY_SICKNESS_EXPOSURE
#undef GRAY_DEATH_KNELL_EXPOSURE

//Handles the contamination system. Touch with caution.
#undef RADIATION_CONTAMINATION_THRESHOLD
#undef RADIATION_JUMP_THRESHOLD
#undef RADIATION_JUMP_COOLDOWN
#undef RADIATION_MIN_SPACE_PROCESS
