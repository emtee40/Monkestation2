/obj/item/mantis_blade
	name = "C.H.R.O.M.A.T.A. mantis blade"
	desc = "Powerful inbuilt blade, hidden just beneath the skin. Singular brain signals directly link to this bad boy, allowing it to spring into action in just seconds."
	icon_state = "mantis"
	inhand_icon_state = "mantis"
	icon = 'monkestation/code/modules/cybernetics/icons/items_and_weapons.dmi'
	lefthand_file = 'monkestation/code/modules/cybernetics/icons/swords_lefthand.dmi'
	righthand_file = 'monkestation/code/modules/cybernetics/icons/swords_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	force = 12
	wound_bonus = 20
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	max_integrity = 200

/obj/item/mantis_blade/equipped(mob/user, slot, initial)
	. = ..()
	if(slot != ITEM_SLOT_HANDS)
		return
	var/side = user.get_held_index_of_item(src)

	if(side == LEFT_HANDS)
		transform = null
	else
		transform = matrix(-1, 0, 0, 0, 1, 0)

/obj/item/mantis_blade/attack(mob/living/M, mob/living/user)
	. = ..()
	if(user.get_active_held_item() != src)
		return

	var/obj/item/some_item = user.get_inactive_held_item()

	if(!istype(some_item,type))
		return

	user.do_attack_animation(M,null,some_item)
	some_item.attack(M,user)

/obj/item/mantis_blade/syndicate
	name = "A.R.A.S.A.K.A. mantis blade"
	icon_state = "syndie_mantis"
	inhand_icon_state = "syndie_mantis"
	force = 15
	block_chance = 20
	COOLDOWN_DECLARE(lunge)

/obj/item/mantis_blade/syndicate/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!COOLDOWN_FINISHED(src, lunge) || world.time < user.next_move)
		return

	if(proximity_flag || get_dist(user,target) > 3 || !isliving(target))
		return

	for(var/i in 1 to get_dist(user,target))
		if(!step_towards(user,target))
			return
	COOLDOWN_START(src, lunge, 10 SECONDS)
	attack(target,user)
