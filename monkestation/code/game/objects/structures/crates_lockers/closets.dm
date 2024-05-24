/obj/structure/closet
	/// If TRUE, the closet will anchored by default, if it spawns on the station's z-level.
	var/roundstart_anchor = TRUE

/obj/structure/closet/Initialize(mapload)
	. = ..()
	if(mapload && roundstart_anchor && anchorable && is_station_level(loc?.z))
		set_anchored(TRUE)

/obj/structure/closet/crate
	roundstart_anchor = FALSE

/obj/structure/closet/supplypod
	roundstart_anchor = FALSE
