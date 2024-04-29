/obj/item/clothing/gloves/color/yellow/power_gloves
	name = "Power Gloves"
	desc = "Insulated gloves that appear to be able to redirect the electrical current towards a point."
	armor_type = /datum/armor/power_gloves
	var/datum/action/cooldown/spell/pointed/glove_zap/zap = new

/obj/item/clothing/gloves/color/yellow/power_gloves/Destroy()
    qdel(zap)
    return ..()

/datum/armor/power_gloves
	acid = 50
	bio = 50
	fire = 80

/datum/action/cooldown/spell/pointed/glove_zap
	name = "Nerd Blast"
	desc = "Blast your foes with the electricity surging beneath your feet!"
	button_icon_state = "lightning"
	cooldown_time = 10
	spell_max_level = 1
	sparks_amt = 1
	spell_requirements = SPELL_REQUIRES_HUMAN
	antimagic_flags = NONE

/datum/action/cooldown/spell/pointed/glove_zap/proc/glove_nerd_zap(atom/target, /mob/owner)
	var/turf/T = get_turf(owner)
	var/obj/structure/cable/C = T.get_cable_node()
	if(!C)
		return FALSE
	else
		var/surplus = C.surplus()
		var/list/targets = list(target)
		if (surplus >= 1000)
			if (do_after(owner, 6 SECONDS, owner))
				var/calculated_power = surplus/95 //Calc_power, change division to balance
				tesla_zap(owner, 4, calculated_power, SHOCK_NOSTUN, shocked_targets = targets, max_damage = 140, remaining_bounces = 0) // 4 tile range, uses tesla_default_power
				StartCooldown()

/obj/item/clothing/gloves/color/yellow/power_gloves/equipped(mob/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_GLOVES)
		zap.Grant(user)

/obj/item/clothing/gloves/color/yellow/power_gloves/dropped(mob/user, slot)
	. = ..()
	if (user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		zap.Remove(user)

/datum/action/cooldown/spell/pointed/glove_zap/InterceptClickOn(mob/living/caller, params, atom/target)
	. = ..()
	if (!isliving(target))
		return FALSE
	else
		glove_nerd_zap(target, caller)

