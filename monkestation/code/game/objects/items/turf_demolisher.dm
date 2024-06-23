//simply an item that breaks turfs down
/obj/item/turf_demolisher
	name = "\improper Exprimental Demolisher"
	icon = 'icons/obj/mining.dmi'
	icon_state = "jackhammer"
	inhand_icon_state = "jackhammer"
	///List of turf types we are allowed to break, if unset then we can break any turfs that dont have the INDESTRUCTIBLE resistance flag
	var/list/allowed_types = list(/turf/closed/wall)
	///List of turf types we are NOT allowed to break
	var/list/blacklisted_types
	///How long is the do_after() to break a turf
	var/break_time = 8 SECONDS
	///Do we devastate broken walls, because of quality 7 year old code this always makes iron no matter the wall type
	var/devastate = TRUE
	///How long is pur recharge time between uses
	var/recharge_time = 0
	COOLDOWN_DECLARE(recharge)

/obj/item/turf_demolisher/attack_atom(atom/attacked_atom, mob/living/user, params)
	if(!isturf(attacked_atom) || (user.istate & ISTATE_HARM))
		return ..()

	if(!check_breakble(attacked_atom, user, params))
		on_non_breakable(attacked_atom, user)
		return

	if(try_demolish(attacked_atom, user))
		return
	return ..()

/obj/item/turf_demolisher/proc/check_breakble(turf/attacked_turf, mob/living/user, params)

/obj/item/turf_demolisher/proc/on_non_breakable(turf/attacked_turf, mob/living/user)
	balloon_alert(user, "[src] seems unable to demolish [attacked_turf].")

/obj/item/turf_demolisher/proc/try_demolish(turf/attacked_turf, mob/living/user)

//a debug version that is able to break ANY turf, handle with care
/obj/item/turf_demolisher/admin
	name = "Debug Turf Demolisher"
	break_time = 1 //1 decisecond

/obj/item/turf_demolisher/admin/check_breakble(atom/attacked_atom, mob/living/user, params)
	return TRUE
