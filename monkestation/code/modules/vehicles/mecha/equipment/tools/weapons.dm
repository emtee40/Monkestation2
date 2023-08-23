#define MODE_MINE 0
#define MODE_KILL 1

//Exosuit-mounted kinetic accelerator
/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun
	equip_cooldown = 12
	name = "Exosuit Proto-kinetic Accelerator"
	desc = "A dual-purpose plasma cutter that runs off the exosuit's power supply."
	icon_state = "mecha_kineticgun"
	energy_drain = 80
	projectile = /obj/projectile/kinetic/mech
	harmful = TRUE
	mech_flags = EXOSUIT_MODULE_COMBAT | EXOSUIT_MODULE_WORKING
	var/mode = MODE_MINE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun/proc/get_mode()
	switch(mode)
		if(MODE_MINE)
			return "oremode"
		if(MODE_KILL)
			return "killmode"

/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_MODE,
		"name" = "Exosuit Kinetic Thing",
		"mode" = mode == MODE_MINE ? "ore-cutting beams" : "kinetic blast",
	)

/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun/ui_act(action, list/params, mob/user)
	. = ..()
	if(.)
		return
	if(action == "change_mode")
		if(mode == MODE_MINE)
			mode = MODE_KILL
		else
			mode = MODE_MINE
		return TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun/action(mob/source, atom/target, list/modifiers)
	switch(mode)
		if(MODE_MINE)
			if(projectile)
				projectile = /obj/projectile/plasma/multishot
				variance = 20
				projectiles_per_shot = 3
				fire_sound = 'sound/weapons/plasma_cutter_dim.ogg'
		if(MODE_KILL)
			if(projectile)
				projectile = /obj/projectile/kinetic/mech
				variance = 0
				projectiles_per_shot = 1
				fire_sound = 'sound/weapons/kenetic_accel.ogg'
	return ..()

#undef MODE_MINE
#undef MODE_KILL
