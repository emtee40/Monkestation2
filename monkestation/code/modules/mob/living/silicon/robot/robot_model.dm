/obj/item/robot_model
	/// Boolean for if the borg has a unique sprite when dead
	var/unique_wreck = FALSE
	/// If filled out, will override the hands icon with a different one
	var/model_select_override
	/// If filled out, will override the borg icon when making radials with a different one
	var/cyborg_base_icon_override

/obj/item/robot_model/cargo
	name = "Cargo"
	basic_modules = list(
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/pen/cyborg,
		/obj/item/clipboard/cyborg,
		/obj/item/stack/package_wrap/cyborg,
		/obj/item/stack/wrapping_paper/xmas/cyborg,
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/hydraulic_clamp,
		/obj/item/borg/hydraulic_clamp/mail,
		/obj/item/hand_labeler/cyborg,
		/obj/item/dest_tagger,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher,
		/obj/item/universal_scanner,
	)
	radio_channels = list(RADIO_CHANNEL_SUPPLY)
	emag_modules = list(
		/obj/item/stamp/chameleon,
		/obj/item/borg/paperplane_crossbow,
	)
	hat_offset = 0
	cyborg_base_icon = "cargoborg"
	cyborg_base_icon_override = 'monkestation/icons/mob/silicon/robots.dmi'
	model_select_icon = "cargo"
	model_select_override = 'monkestation/icons/hud/screen_cyborg.dmi'
	canDispose = TRUE
	borg_skins = list(
		"Technician" = list(SKIN_ICON_STATE = "cargoborg", SKIN_ICON = 'monkestation/icons/mob/silicon/robots.dmi'),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_cargo", SKIN_ICON = 'monkestation/icons/mob/silicon/robots.dmi', SKIN_UNIQUE_WRECK = TRUE, SKIN_HAT_OFFSET = -13),
	)

/mob/living/silicon/robot/model/cargo
	set_model = /obj/item/robot_model/cargo
	icon_state = "cargoborg"
