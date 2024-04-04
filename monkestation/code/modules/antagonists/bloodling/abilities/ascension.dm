/datum/action/cooldown/bloodling/ascension
	name = "Ascend"
	desc = "We reach our last form...Mass consumption is required. Costs 250 Biomass and takes 5 minutes for you to ascend."
	button_icon_state = "dissonant_shriek"
	biomass_cost = 250

/datum/action/cooldown/bloodling/ascension/Activate(atom/target)
	force_event(/datum/round_event_control/bloodling_ascension, "A bloodling is ascending")

	return TRUE


/datum/round_event_control/bloodling_ascension
	name = "Bloodling Ascension"
	typepath = /datum/round_event/bloodling_ascension
	max_occurrences = 0
	weight = 0
	alert_observers = FALSE
	category = EVENT_CATEGORY_SPACE

/datum/round_event/bloodling_ascension/announce(fake)

	priority_announce("What the heELl is going on?! WEeE have detected  massive up-spikes in ##@^^?? coming fr*m yoOourr st!*i@n! GeEeEEET out of THERE NOW!!","?????????", 'monkestation/sound/bloodsuckers/monsterhunterintro.ogg')

/datum/round_event/bloodling_ascension/start()
	for(var/i = 1, i < 16, i++)
		new /obj/effect/anomaly/dimensional/flesh(get_safe_random_station_turf(), null, FALSE)

/obj/effect/anomaly/dimensional/flesh
	range = 5
	immortal = TRUE
	drops_core = FALSE
	relocations_left = -1

/obj/effect/anomaly/dimensional/flesh/Initialize(mapload, new_lifespan, drops_core)
	INVOKE_ASYNC(src, PROC_REF(prepare_area), /datum/dimension_theme/meat)
	return ..()

/obj/effect/anomaly/dimensional/flesh/relocate()
	var/datum/anomaly_placer/placer = new()
	var/area/new_area = placer.findValidArea()
	var/turf/new_turf = placer.findValidTurf(new_area)
	src.forceMove(new_turf)
	prepare_area(new_theme_path = /datum/dimension_theme/meat)
