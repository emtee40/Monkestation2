/mob/living/basic/proc/pass_stats(atom/child)
	return

/mob/living/basic/chicken
	name = "\improper chicken"
	desc = "Hopefully the eggs are good this season."
	gender = FEMALE

	maxHealth = 15
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)

	icon = 'monkestation/icons/mob/ranching/chickens.dmi'
	icon_state = "chicken_white"
	icon_living = "chicken_white"
	icon_dead = "dead_state"
	held_state = "chicken_white"

	speak_emote = list("clucks","croons")

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "pecks"
	response_harm_simple = "peck"
	attack_verb_continuous = "pecks"
	attack_verb_simple = "peck"

	density = FALSE
	speed = 1.1
	butcher_results = list(/obj/item/food/meat/slab/chicken = 2)
	worn_slot_flags = ITEM_SLOT_HEAD
	can_be_held = TRUE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	chat_color = "#FFDC9B"

	egg_type = /obj/item/food/egg
	mutation_list = list(/datum/mutation/ranching/chicken/spicy, /datum/mutation/ranching/chicken/brown)

/mob/living/basic/chicken/Initialize(mapload)
	. = ..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

	AddComponent(/datum/component/mutation, mutation_list, TRUE)
	AddComponent(/datum/component/obeys_commands, pet_commands)
	AddComponent(/datum/component/friendship_container, list(FRIENDSHIP_HATED = -100, FRIENDSHIP_DISLIKED = -50, FRIENDSHIP_STRANGER = 0, FRIENDSHIP_NEUTRAL = 10, FRIENDSHIP_ACQUAINTANCES = 25, FRIENDSHIP_FRIEND = 50, FRIENDSHIP_BESTFRIEND = 100), FRIENDSHIP_ACQUAINTANCES)


	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CHICKEN, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	if(prob(40))
		gender = MALE

	assign_chicken_icon()
	if(gender == MALE && breed_name)
		if(breed_name_male)
			name = " [breed_name_male]"
		else
			name = "[breed_name] Rooster"
	else
		if(breed_name_female)
			name = " [breed_name_female]"
		else
			name = "[breed_name] Hen"

	var/list/new_planning_subtree = list()

	var/datum/action/cooldown/mob_cooldown/chicken/feed/feed_ability = new(src)
	feed_ability.Grant(src)
	ai_controller.blackboard[BB_CHICKEN_FEED] = feed_ability
	new_planning_subtree |= /datum/ai_planning_subtree/targeted_mob_ability/min_range/chicken/feed

	if(gender == FEMALE)
		var/datum/action/cooldown/mob_cooldown/chicken/lay_egg/new_ability = new(src)
		new_ability.Grant(src)
		ai_controller.blackboard[BB_CHICKEN_LAY_EGG] = new_ability
		new_planning_subtree |= /datum/ai_planning_subtree/targeted_mob_ability/min_range/chicken/lay_egg

	if(targeted_ability)
		var/datum/action/cooldown/mob_cooldown/created_ability = new targeted_ability(src)
		created_ability.Grant(src)
		ai_controller.blackboard[BB_CHICKEN_TARGETED_ABILITY] = created_ability
		new_planning_subtree |= targeted_ability_planning_tree

	if(self_ability)
		var/datum/action/cooldown/mob_cooldown/created_ability = new self_ability(src)
		created_ability.Grant(src)
		ai_controller.blackboard[BB_CHICKEN_SELF_ABILITY] = created_ability
		new_planning_subtree |= ability_planning_tree

	if(projectile_type)
		AddComponent(/datum/component/ranged_attacks, projectile_type = src.projectile_type, cooldown_time = ranged_cooldown)
		new_planning_subtree |= /datum/ai_planning_subtree/basic_ranged_attack_subtree/chicken

	for(var/datum/ai_planning_subtree/listed_tree as anything in ai_controller.planning_subtrees)
		new_planning_subtree |= listed_tree.type

	ai_controller.replace_planning_subtrees(new_planning_subtree)

	return INITIALIZE_HINT_LATELOAD

/mob/living/basic/chicken/proc/assign_chicken_icon()
	if(!icon_suffix) // should never be the case but if so default to the first set of icons
		return
	var/starting_prefix = "chicken"
	if(gender == MALE)
		starting_prefix = "rooster"
	icon_state = "[starting_prefix]_[icon_suffix]"
	held_state = "[starting_prefix]_[icon_suffix]"
	icon_living = "[starting_prefix]_[icon_suffix]"
	icon_dead = "dead_[icon_suffix]"

/mob/living/basic/chicken/update_overlays()
	. = ..()
	if(is_marked)
		.+= mutable_appearance('monkestation/icons/effects/ranching.dmi', "marked", FLOAT_LAYER, src, plane = src.plane)

/mob/living/basic/chicken/proc/add_visual(method)
	if(applied_visual)
		return
	applied_visual = mutable_appearance('monkestation/icons/effects/ranching_text.dmi', "chicken_[method]", FLOAT_LAYER, src, plane = src.plane)
	add_overlay(applied_visual)
	addtimer(CALLBACK(src, PROC_REF(remove_visual)), 3 SECONDS)

/mob/living/basic/chicken/proc/remove_visual()
	cut_overlay(applied_visual)
	applied_visual = null

/mob/living/basic/chicken/pass_stats(atom/child)
	var/obj/item/food/egg/layed_egg = child

	if(layed_egg.is_fertile) //using the heating box will cause the friendship to be lost, this is a nerf to raptor farms
		SEND_SIGNAL(src, COMSIG_FRIENDSHIP_PASS_FRIENDSHIP, layed_egg)

	layed_egg.faction_holder = src.faction
	layed_egg.layer_hen_type = src.type
	layed_egg.happiness = src.happiness
	layed_egg.consumed_food = src.consumed_food
	layed_egg.consumed_reagents = src.consumed_reagents
	layed_egg.pixel_x = rand(-6,6)
	layed_egg.pixel_y = rand(-6,6)

	if(glass_egg_reagents)
		layed_egg.food_reagents = glass_egg_reagents

	if(production_type)
		layed_egg.production_type = production_type

	if(eggs_fertile)
		if(prob(20 + (fertility_boosting * 0.1)) || layed_egg.possible_mutations.len) //25
			START_PROCESSING(SSobj, layed_egg)
			layed_egg.is_fertile = TRUE
			flop_animation(layed_egg)
			layed_egg.desc = "You can hear pecking from the inside of this seems it may hatch soon."


/mob/living/basic/chicken/Destroy()
	consumed_food = null
	consumed_reagents = null
	mutation_list = null
	glass_egg_reagents = null
	applied_visual = null
	disliked_foods = null
	return ..()

/mob/living/basic/chicken/AltClick(mob/user)
	. = ..()
	is_marked = !is_marked
	update_appearance()

/mob/living/basic/chicken/attack_hand(mob/living/carbon/human/user)
	..()
	if(stat == DEAD)
		return
	if(!(user.istate & ISTATE_HARM) && likes_pets && max_happiness_per_generation >= 3)
		adjust_happiness(1, user)
		max_happiness_per_generation -= 2 ///petting is not efficent
	else if(!(user.istate & ISTATE_HARM) && !likes_pets)
		adjust_happiness(-1, user)

/mob/living/basic/chicken/attackby(obj/item/given_item, mob/user, params)
	if(istype(given_item, /obj/item/food)) //feedin' dem chickens
		if(!stat && current_feed_amount <= 3 )
			feed_food(given_item, user)
			SEND_SIGNAL(src, COMSIG_FRIENDSHIP_CHANGE, user, 1)
		else
			var/turf/vomited_turf = get_turf(src)
			vomited_turf.add_vomit_floor(src, VOMIT_TOXIC)
			to_chat(user, "<span class='warning'>[name] can't keep the food down, it vomits all over the floor!</span>")
			adjust_happiness(-15, user)
			current_feed_amount -= 3
	else
		..()

/mob/living/basic/chicken/proc/feed_food(obj/item/given_item, mob/user)
	handle_happiness_changes(given_item, user)
	if(user)
		var/feedmsg = "[user] feeds [given_item] to [name]! [pick(feedMessages)]"
		user.visible_message(feedmsg)

	qdel(given_item)
	eggs_left += rand(0, 2)
	current_feed_amount ++
	total_times_eaten ++

/mob/living/basic/chicken/proc/eat_feed(obj/effect/chicken_feed/eaten_feed)
	if(eaten_feed.held_reagents.len)
		for(var/datum/reagent/listed_reagent in eaten_feed.held_reagents)
			listed_reagent.feed_interaction(src, listed_reagent.volume)
			consumed_reagents |= listed_reagent

	for(var/listed_item in eaten_feed.held_foods)
		var/obj/item/food/listed_food = new listed_item
		consumed_food |= listed_food.type

		for(var/food_type in listed_food.foodtypes)
			if(food_type in disliked_food_types)
				var/type_value = disliked_food_types[food_type]
				adjust_happiness(-type_value)

		if((listed_food.type in liked_foods) && max_happiness_per_generation >= liked_foods[listed_food.type])
			var/liked_value = liked_foods[listed_food.type]
			adjust_happiness(liked_value)

		else if(listed_food.type in disliked_foods)
			var/disliked_value = disliked_foods[listed_food.type]
			adjust_happiness(-disliked_value)
		qdel(listed_food)
	total_times_eaten++
	eggs_left += rand(1, 3)
	qdel(eaten_feed)

/mob/living/basic/chicken/proc/handle_happiness_changes(obj/given_item, mob/user)
	for(var/datum/reagent/reagent in given_item.reagents.reagent_list)
		if(reagent in happy_chems && max_happiness_per_generation >= (happy_chems[reagent.type] * reagent.volume))
			var/liked_value = happy_chems[reagent.type]
			adjust_happiness(liked_value * reagent.volume, user)
		else if(reagent in disliked_chemicals)
			var/disliked_value = disliked_chemicals[reagent.type]
			adjust_happiness(-(disliked_value * reagent.volume), user)
		if(!(reagent in consumed_reagents))
			consumed_reagents.Add(reagent)

	if(!istype(given_item, /obj/item/food))
		return

	var/obj/item/food/placeholder_food_item = given_item
	if(!(placeholder_food_item.type in consumed_food))
		consumed_food.Add(placeholder_food_item.type)

	for(var/food_type in placeholder_food_item.foodtypes)
		if(food_type in disliked_food_types)
			var/type_value = disliked_food_types[food_type]
			adjust_happiness(-type_value, user)

	if((placeholder_food_item.type in liked_foods) && max_happiness_per_generation >= liked_foods[placeholder_food_item.type])
		var/liked_value = liked_foods[placeholder_food_item.type]
		adjust_happiness(liked_value, user)

	else if(placeholder_food_item.type in disliked_foods)
		var/disliked_value = disliked_foods[placeholder_food_item.type]
		adjust_happiness(-disliked_value, user)

/mob/living/basic/chicken/Life()
	. =..()
	if(!.)
		return
	if(COOLDOWN_FINISHED(src, age_cooldown))
		COOLDOWN_START(src, age_cooldown, age_speed)
		age ++

	if(age > max_age)
		src.death()

	if(instability > initial(instability))
		instability = max(initial(instability), instability - 2)

	if(fertility_boosting > initial(fertility_boosting))
		fertility_boosting = max(initial(fertility_boosting), fertility_boosting - 2)

	if(egg_laying_boosting > initial(egg_laying_boosting))
		egg_laying_boosting = max(initial(egg_laying_boosting), egg_laying_boosting - 2)

	var/animal_count = 0
	for(var/mob/living/basic/animals in view(1, src))
		animal_count ++
	if(animal_count >= overcrowding)
		adjust_happiness(-1)

	if(current_feed_amount == 0)
		adjust_happiness(-0.01, natural_cause = TRUE)

	if(happiness < minimum_living_happiness)
		src.death()
	if(!stat && prob(3) && current_feed_amount > 0)
		current_feed_amount --
		if(current_feed_amount == 0)
			var/list/users = get_hearers_in_view(4, src.loc)
			for(var/mob/living/carbon/human/user in users)
				user.visible_message("[src] starts pecking at the floor, it must be hungry.")


/mob/living/basic/chicken/proc/adjust_happiness(amount, atom/source, natural_cause = FALSE)
	happiness += amount
	if(amount > 0)
		max_happiness_per_generation -= amount
		add_visual("love")
	else
		if(!natural_cause)
			add_visual("angry")
	if(source)
		SEND_SIGNAL(src, COMSIG_FRIENDSHIP_CHANGE, source, amount * 0.5)
