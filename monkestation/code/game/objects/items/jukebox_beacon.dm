/obj/item/jukebox_beacon
	name = "jukebox beacon"
	desc = "N.T. jukebox beacon, toss it down and you will have a complementary jukebox delivered to you. It comes with a free wrench to move it after deployment."
	icon = 'monkestation/icons/obj/items_and_weapons.dmi'
	icon_state = "music_beacon"
	var/used

/obj/item/jukebox_beacon/attack_self()
	if(used)
		return
	loc.visible_message(span_warning("\The [src] begins to beep loudly!"))
	used = TRUE
	addtimer(CALLBACK(src, PROC_REF(launch_payload)), 40)

/obj/item/jukebox_beacon/proc/launch_payload()
	var/obj/structure/closet/supplypod/centcompod/toLaunch = new()

	new /obj/machinery/media/jukebox(toLaunch)
	new /obj/item/wrench(toLaunch)

	new /obj/effect/pod_landingzone(drop_location(), toLaunch)
	qdel(src)