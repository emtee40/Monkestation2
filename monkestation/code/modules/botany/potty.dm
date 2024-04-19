/mob/living/basic/pet/potty
	name = "craig the potted plant"
	desc = "A potted plant."

	icon = 'monkestation/code/modules/botany/icons/potty.dmi'
	icon_state = "potty"
	icon_living = "potty_living"
	icon_dead = "potty_dead"

	ai_controller = /datum/ai_controller/basic_controller/dog

	/// Instructions you can give to dogs
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy/dog,
		/datum/pet_command/follow/dog,
		/datum/pet_command/point_targeting/attack/dog,
		/datum/pet_command/point_targeting/fetch,
		/datum/pet_command/play_dead,
	)

/mob/living/basic/pet/potty/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/plant_tray_overlay, icon, null, null, null, null, null, null, 3, 8)
	AddComponent(/datum/component/plant_growing)
	AddComponent(/datum/component/obeys_commands, pet_commands)
	AddComponent(/datum/component/emotion_buffer)
	AddComponent(/datum/component/friendship_container, list(FRIENDSHIP_HATED = -100, FRIENDSHIP_DISLIKED = -50, FRIENDSHIP_STRANGER = 0, FRIENDSHIP_NEUTRAL = 1, FRIENDSHIP_ACQUAINTANCES = 3, FRIENDSHIP_FRIEND = 5, FRIENDSHIP_BESTFRIEND = 10), FRIENDSHIP_FRIEND)
