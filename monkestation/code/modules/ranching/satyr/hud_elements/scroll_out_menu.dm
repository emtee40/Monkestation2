/atom/movable/screen/hud_popout_container
	icon = 'monkestation/code/modules/ranching/icons/hud_popout.dmi'
	icon_state = "holder_hud"

	screen_loc =  "WEST,CENTER"
	var/atom/movable/screen/hud_popout_arrow/arrow
	///basically we add the screen and in here if we press the arrow it will animate everything including the holder
	var/list/stored_screens = list()
	///are we pulled out
	var/pulled_out = TRUE
	var/arrow_screen_loc = "WEST:32,CENTER"
	var/animation_depth = 32

/atom/movable/screen/hud_popout_container/New(datum/hud/hud_used)
	. = ..()
	arrow = new
	arrow.parent = src
	arrow.screen_loc = arrow_screen_loc

	arrow.hud = hud_used
	hud_used.infodisplay += arrow


/atom/movable/screen/hud_popout_container/proc/change_state()
	if(pulled_out)
		animate_push()
	else
		animate_pull()

/atom/movable/screen/hud_popout_container/proc/animate_push()
	pulled_out = FALSE
	animate(src, time = 1 SECONDS, transform = matrix(pixel_x-animation_depth, pixel_y, MATRIX_TRANSLATE))
	animate(arrow, time = 1 SECONDS, transform = matrix(pixel_x-animation_depth, pixel_y, MATRIX_TRANSLATE))
	arrow.icon_state = arrow.pullout_icon
	for(var/atom/atom as anything in stored_screens)
		animate(atom, time = 1 SECONDS, transform = matrix(pixel_x-animation_depth, pixel_y, MATRIX_TRANSLATE))

/atom/movable/screen/hud_popout_container/proc/animate_pull()
	pulled_out = TRUE
	animate(src, time = 1 SECONDS, transform = matrix(pixel_x, pixel_y, MATRIX_TRANSLATE))
	animate(arrow, time = 1 SECONDS, transform = matrix(pixel_x, pixel_y, MATRIX_TRANSLATE))
	arrow.icon_state = arrow.pushin_icon
	for(var/atom/atom as anything in stored_screens)
		animate(atom, time = 1 SECONDS, transform = matrix(pixel_x, pixel_y, MATRIX_TRANSLATE))

/atom/movable/screen/hud_popout_arrow
	icon = 'monkestation/code/modules/ranching/icons/hud_popout.dmi'
	icon_state = "pushin_arrow"
	pixel_x = 32

	var/pullout_icon = "pullout_arrow"
	var/pushin_icon = "pushin_arrow"

	var/atom/movable/screen/hud_popout_container/parent

/atom/movable/screen/hud_popout_arrow/Click(location, control, params)
	. = ..()
	parent?.change_state()
