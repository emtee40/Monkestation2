
/**
 * Stalwart's achievements
 */

// achievements

/datum/award/achievement/boss/stalwart_kill
	name = "Stalwart Killer"
	desc = "The ancient machinations have been defeated, how curious"
	database_id = BOSS_MEDAL_STALWART
	icon = "stalwart"

/datum/award/achievement/boss/stalwart_crusher
	name = "Stalwart Crusher"
	desc = "The ancient machinations have been with a primitive axe, how curious"
	database_id = BOSS_MEDAL_STALWART_CRUSHER
	icon = "stalwart"

// leaderboard

/datum/award/score/stalwart_score
	name = "Stalwarts Killed"
	desc = "You've killed HOW many?"
	database_id = STALWART_SCORE

/**
 * Stalwart's small sprite
 */

/datum/action/small_sprite/megafauna/stalwart
	small_icon_state = "Basilisk"

/**
 * Stalwart's ruin
 */

/datum/map_template/ruin/lavaland/monke
	prefix = "monkestation/_maps/LavaRuins/"

/datum/map_template/ruin/lavaland/monke/stalwart
	name = "Stalwart chamber"
	id = "stalwart"
	description = "A chamber with the stalwart in it, curious."
	suffix = "lavaland_surface_stalwart.dmm"
	always_place = TRUE
	allow_duplicates = FALSE
