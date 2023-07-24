/obj/structure/holographic_arena
	name = "Holographic training beacon"
	desc = "A nanotrasen approved beacon, you can insert megafauna tokens into it to practise fighting megafauna. Some rumors say you can insert gems into it too..."
	icon = 'monkestation/icons/obj/machines/research.dmi'
	icon_state = "tdoppler-broken"
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	anchored = TRUE
	density = TRUE

// Im sorry for this hell of if statements without switches, i honest to god have no clue how to get a switch here

/obj/structure/holographic_arena/attacked_by(obj/item/I)
	var/success = FALSE
	if(istype(I, /obj/item/gem)) // ohohoho, a worthy challenger approaches
		if(istype(I, /obj/item/gem/phoron)) // blood-drunk
			new /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/holographic/buffed(get_turf(src))
		if(istype(I, /obj/item/gem/purple)) // hierophant
			new /mob/living/simple_animal/hostile/megafauna/hierophant/holographic/buffed(get_turf(src))
		if(istype(I, /obj/item/gem/amber)) // ashdrake
			new /mob/living/simple_animal/hostile/megafauna/dragon/holographic/buffed(get_turf(src))
		if(istype(I, /obj/item/gem/void)) // collosus
			new /mob/living/simple_animal/hostile/megafauna/colossus/holographic/buffed(get_turf(src))
		if(istype(I, /obj/item/gem/bloodstone)) // bubblegum
			new /mob/living/simple_animal/hostile/megafauna/bubblegum/holographic/buffed(get_turf(src))
		success = TRUE
		visible_message(span_warning("[src] resonates with the inserted gem, creating a very realistic looking megafauna!"))
		playsound(src, 'sound/magic/exit_blood.ogg', 100, TRUE)
	if(istype(I, /obj/item/token)) // oh, you are just here for training? alright then, fair enuff
		if(istype(I, /obj/item/token/blood_drunk)) // blood-drunk
			new /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/holographic(get_turf(src))
		if(istype(I, /obj/item/token/hierophant)) // hierophant
			new /mob/living/simple_animal/hostile/megafauna/hierophant/holographic(get_turf(src))
		if(istype(I, /obj/item/token/ash_drake)) // ashdrake
			new /mob/living/simple_animal/hostile/megafauna/dragon/holographic(get_turf(src))
		if(istype(I, /obj/item/token/colossus)) // collosus
			new /mob/living/simple_animal/hostile/megafauna/colossus/holographic(get_turf(src))
		if(istype(I, /obj/item/token/bubblegum)) // bubblegum
			new /mob/living/simple_animal/hostile/megafauna/bubblegum/holographic(get_turf(src))
		success = TRUE
		visible_message(span_warning("[src] pings, consuming the token and creating a holographic projection of a megafauna."))
		playsound(src, 'sound/machines/ping.ogg', 15, TRUE)
	if(!success)
		visible_message(span_warning("[src] shows an error on its screen, it seems it can't accept [I]."))
		return
	qdel(I)

/// Welcome to the megafauna zone, enjoy your stay

/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/holographic
	name = "holographic blood-drunk miner"
	desc = "Its a simulation of the miner #26924 lost during the first expedition of the planet ''lavaland''"
	mob_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	crusher_loot = null
	loot = null
	true_spawn = FALSE

/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/holographic/AttackingTarget()
	if(QDELETED(target))
		return
	face_atom(target)
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat != CONSCIOUS)
			visible_message(span_danger("[src] dissapears as [L] wakes up!"), // poor lad took an L
			span_userdanger("Simulation battle protocol complete, shutting down..."))
			L.revive(HEAL_ALL)
			qdel(src)
			return TRUE
	changeNext_move(CLICK_CD_MELEE)
	miner_saw.melee_attack_chain(src, target)
	return TRUE

/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/holographic/buffed
	name = "holographic blood-drunk miner?"
	crusher_loot = list(/obj/item/gem/phoron/refined)
	loot = list(/obj/item/gem/phoron/refined)
	speed = 1.5
	move_to_delay = 1.5
	ranged = TRUE
	ranged_cooldown_time = 0.8 SECONDS


/mob/living/simple_animal/hostile/megafauna/hierophant/holographic
	name = "holographic hierophant"
	desc = "Its a simulation of a giant purple club found on lavaland, the club in fact is very dangerous when provoked"
	crusher_loot = null
	loot = null
	true_spawn = FALSE

/mob/living/simple_animal/hostile/megafauna/hierophant/holographic/devour(mob/living/L)
	visible_message(span_danger("[src] dissapears as [L] wakes up!"), // poor lad took an L
	span_userdanger("Simulation battle protocol complete, shutting down..."))
	L.revive(HEAL_ALL)
	qdel(src)

/mob/living/simple_animal/hostile/megafauna/hierophant/holographic/buffed
	name = "holographic hierophant?"
	crusher_loot = list(/obj/item/gem/purple/refined)
	loot = list(/obj/item/gem/purple/refined)
	major_attack_cooldown = 0
	chaser_cooldown_time = 5 SECONDS

/mob/living/simple_animal/hostile/megafauna/dragon/holographic
	name = "holographic ashdrake"
	desc = "a simulated ashdrake species commonly found on lavaland, access to ashdrake's simulation files were restricted to only miners for a good reason, those sick fucks."
	crusher_loot = null
	loot = null
	true_spawn = FALSE

/mob/living/simple_animal/hostile/megafauna/dragon/holographic/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(span_danger("[src] dissapears as [L] wakes up!"), // poor lad took an L
	span_userdanger("Simulation battle protocol complete, shutting down..."))
	L.revive(HEAL_ALL)
	qdel(src)
	return TRUE

/mob/living/simple_animal/hostile/megafauna/dragon/holographic/buffed
	name = "holographic ashdrake?"
	crusher_loot = list(/obj/item/gem/amber/refined)
	loot = list(/obj/item/gem/amber/refined)
	armour_penetration = 60
	melee_damage_lower = 60
	melee_damage_upper = 60


/mob/living/simple_animal/hostile/megafauna/colossus/holographic
	name = "holographic collosus"
	desc = "a simulated angel, because we couldnt find real ones. Definetelly helpfull in its job of being killed"
	crusher_loot = null
	loot = null
	true_spawn = FALSE

/obj/projectile/colossus/holographic
	name = "simulated death bolt"
	explode_hit_objects = FALSE

/obj/projectile/colossus/holographic/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat != CONSCIOUS)
			visible_message(span_danger("[src] pathetically hits [L]"))
			// we dont do anything important, this is just so the colossus projectiles wont dust our miner by accident because parent business
		return

/datum/action/cooldown/mob_cooldown/projectile_attack/spiral_shots/holographic
	projectile_type = /obj/projectile/colossus/holographic

/datum/action/cooldown/mob_cooldown/projectile_attack/random_aoe/holographic
	projectile_type = /obj/projectile/colossus/holographic

/datum/action/cooldown/mob_cooldown/projectile_attack/shotgun_blast/holographic
	projectile_type = /obj/projectile/colossus/holographic

/datum/action/cooldown/mob_cooldown/projectile_attack/dir_shots/holographic
	projectile_type = /obj/projectile/colossus/holographic

/mob/living/simple_animal/hostile/megafauna/colossus/holographic/Initialize(mapload)
	. = ..()
	spiral_shots = new /datum/action/cooldown/mob_cooldown/projectile_attack/spiral_shots/colossus/holographic()
	random_shots = new /datum/action/cooldown/mob_cooldown/projectile_attack/random_aoe/colossus/holographic()
	shotgun_blast = new /datum/action/cooldown/mob_cooldown/projectile_attack/shotgun_blast/colossus/holographic()
	dir_shots = new /datum/action/cooldown/mob_cooldown/projectile_attack/dir_shots/alternating/colossus/holographic()

/mob/living/simple_animal/hostile/megafauna/colossus/holographic/devour(mob/living/L)
	visible_message(span_danger("[src] dissapears as [L] wakes up!"), // poor lad took an L
	span_userdanger("Simulation battle protocol complete, shutting down..."))
	L.revive(HEAL_ALL)
	qdel(src)


/mob/living/simple_animal/hostile/megafauna/colossus/holographic/buffed
	name = "holographic collosus?"
	crusher_loot = list(/obj/item/gem/void/refined)
	loot = list(/obj/item/gem/void/refined)


/mob/living/simple_animal/hostile/megafauna/bubblegum/holographic
	name = "holographic bubblegum"
	desc = "Its a simulation of the demon king themselfes, a very rarelly killed opponent"
	crusher_loot = null
	loot = null
	true_spawn = FALSE

/mob/living/simple_animal/hostile/megafauna/bubblegum/holographic/bloodgrab(turf/T, handedness)
	if(handedness)
		new /obj/effect/temp_visual/bubblegum_hands/rightpaw(T)
		new /obj/effect/temp_visual/bubblegum_hands/rightthumb(T)
	else
		new /obj/effect/temp_visual/bubblegum_hands/leftpaw(T)
		new /obj/effect/temp_visual/bubblegum_hands/leftthumb(T)
	SLEEP_CHECK_DEATH(6, src)
	for(var/mob/living/L in T)
		if(!faction_check_mob(L))
			if(L.stat != CONSCIOUS)
				to_chat(L, span_userdanger("[src] drags you through the blood!"))
				playsound(T, 'sound/magic/enter_blood.ogg', 100, TRUE, -1)
				var/turf/targetturf = get_step(src, dir)
				L.forceMove(targetturf)
				playsound(targetturf, 'sound/magic/exit_blood.ogg', 100, TRUE, -1)
				visible_message(span_danger("[src] dissapears as [L] wakes up!"), // poor lad took an L
				span_userdanger("Simulation battle protocol complete, shutting down..."))
				L.revive(HEAL_ALL)
				qdel(src)
	SLEEP_CHECK_DEATH(1, src)


/mob/living/simple_animal/hostile/megafauna/bubblegum/holographic/buffed
	name = "holographic bubblegum?"
	crusher_loot = list(/obj/item/gem/bloodstone/refined)
	loot = list(/obj/item/gem/bloodstone/refined)
	armour_penetration = 60
	melee_damage_lower = 60
	melee_damage_upper = 60
