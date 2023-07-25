/mob/living/simple_animal/hostile/asteroid/hivelordbrood/staldrone
	name = "mini mechanoid"
	desc = "A tiny creature made of...some kind of gemstone? It seems angry."
	icon = 'icons/mob/silicon/drone.dmi'
	speed = 5
	movement_type = GROUND
	maxHealth = 20
	health = 20
	icon_state = "drone_gem"
	icon_living = "drone_gem"
	icon_aggro = "drone_gem"
	attack_verb_continuous = "rends"
	attack_verb_simple = "rend"
	melee_damage_lower = 6
	melee_damage_upper = 10
	mob_biotypes = list(MOB_ROBOTIC)
	attack_vis_effect = ATTACK_EFFECT_SLASH
	attack_sound = 'sound/weapons/pierce_slow.ogg'
	speak_emote = list("buzzes")
	faction = list("mining")
	weather_immunities = list("lava","ash")

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/staldrone/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(death)), 30 SECONDS)

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/staldrone/ranged
	ranged = 1
	ranged_message = "blasts"
	icon_state = "drone_scout"
	icon_living = "drone_scout"
	icon_aggro = "drone_scout"
	move_to_delay = 2
	speed = 1
	ranged_cooldown_time = 30
	projectiletype = /obj/projectile/stalpike/weak
	projectilesound = 'sound/weapons/ionrifle.ogg'

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/staldrone/ranged/GiveTarget(new_target)
	if(..())
		if(isliving(target) && !target.Adjacent(targets_from) && ranged_cooldown <= world.time)
			OpenFire(target)
