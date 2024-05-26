/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect the heads of staff with your life. You are not a sec officer, and cannot perform arrests."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Heads of Staff"
	minimal_player_age = 7
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BLUESHIELD"

	outfit = /datum/outfit/job/blueshield
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/command,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5
	)
	rpg_title = "Guard"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	alt_titles = list(
	)

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield

	id_trim = /datum/id_trim/job/blueshield
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit_store = /obj/item/gun/ballistic/automatic/pistol/paco/no_mag //monkestation edit: Paco sec
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m35/rubber = 2,
		/obj/item/restraints/handcuffs/cable/zipties = 1,
		/obj/item/reagent_containers/spray/pepper = 1
	)
	head = /obj/item/clothing/head/beret/sec/navyofficer //monkestation edit: cowboy sec
	suit = /obj/item/clothing/suit/armor/blueshield //monkestation edit: cowboy sec

	belt = /obj/item/modular_computer/pda/security
	shoes = /obj/item/clothing/shoes/sneakers/black
	l_pocket = /obj/item/citationinator
	r_pocket = /obj/item/assembly/flash/handheld
	glasses = /obj/item/clothing/glasses/hud/security
	ears = /obj/item/radio/headset/headset_com
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots/sec

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield) // i think this is stupid but this was apparently agreed upon ~lucy

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_state = "trim_blueshield"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_SECURITY_RED
	sechud_icon_state = SECHUD_SECURITY_ASSISTANT
	minimal_access = list(
		ACCESS_MEDICAL,
		ACCESS_SCIENCE,
		ACCESS_SERVICE,
		ACCESS_CONSTRUCTION,
		ACCESS_SECURITY,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_COMMAND,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_WEAPONS,
		)
	extra_access = list(
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS
		)
	job = /datum/job/blueshield
