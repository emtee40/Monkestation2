/datum/job/deputy
	title = JOB_DEPUTY
	description = "Help Security enforce Space Law, \
		Capture criminals and deliver them to the Brig."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	supervisors = "the head of your assigned department"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/deputy
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
	)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes = 15,
		/obj/effect/spawner/random/food_or_drink/donkpockets = 10,
		/obj/item/storage/box/handcuffs = 10,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/choice_beacon/music = 5,
		/obj/item/crowbar/large = 1,
		/obj/item/melee/baton/security/boomerang/loaded = 1,
		/obj/item/clothing/gloves/tackler/offbrand = 1,
		/obj/item/pizzabox/margherita = 3,
		/obj/item/pizzabox/meat = 3,
		/obj/item/pizzabox/vegetable = 2,
		/obj/item/pizzabox/mushroom = 2,
	)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/soft/sec, /obj/item/clothing/mask/whistle)

	rpg_title = "Independent Guardsman"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	///The Deputy's assigned department
	var/deputy_department = DEPARTMENT_SECURITY

/// Engineering
/datum/job/deputy/engineering
	title = JOB_DEPUTY_ENG
	description = "Help Security enforce Space Law within the Engineering department, \
		Capture criminals in Engineering and deliver them to the Brig."
	department_head = list(JOB_CHIEF_ENGINEER)
	selection_color = "#fff5cc"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_ENGINEERING
	exp_granted_type = EXP_TYPE_ENGINEERING
	outfit = /datum/outfit/job/deputy/engineering
	deputy_department = DEPARTMENT_ENGINEERING

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/engineering,
	)
	department_for_prefs = /datum/job_department/engineering

///Medical
/datum/job/deputy/medical
	title = JOB_DEPUTY_MED
	description = "Help Security enforce Space Law within the Medical department, \
		Capture criminals in Medical and deliver them to the Brig."
	department_head = list(JOB_CHIEF_MEDICAL_OFFICER)
	selection_color = "#ffeef0"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_MEDICAL
	exp_granted_type = EXP_TYPE_MEDICAL
	outfit = /datum/outfit/job/deputy/medical
	deputy_department = DEPARTMENT_MEDICAL

	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
	)
	department_for_prefs = /datum/job_department/medical

///Science
/datum/job/deputy/science
	title = JOB_DEPUTY_SCI
	description = "Help Security enforce Space Law within the Science department, \
		Capture criminals in Science and deliver them to the Brig."
	department_head = list(JOB_RESEARCH_DIRECTOR)
	selection_color = "#ffeeff"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_SCIENCE
	exp_granted_type = EXP_TYPE_SCIENCE
	outfit = /datum/outfit/job/deputy/science
	deputy_department = DEPARTMENT_SCIENCE

	display_order = JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/science,
	)
	department_for_prefs = /datum/job_department/science

///Supply
/datum/job/deputy/supply
	title = JOB_DEPUTY_SUP
	description = "Help Security enforce Space Law within the Supply department, \
		Capture criminals  in Cargo and deliver them to the Brig."
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	selection_color = "#dcba97"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_SUPPLY
	outfit = /datum/outfit/job/deputy/supply
	deputy_department = DEPARTMENT_CARGO

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/cargo,
	)
	department_for_prefs = /datum/job_department/cargo

///Service
/datum/job/deputy/service
	title = JOB_DEPUTY_SRV
	description = "Help Security enforce Space Law within the Service department, \
		Capture criminals... wherever Service is... and deliver them to the Brig."
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	selection_color = "#bbe291"
	total_positions = 0
	spawn_positions = 0
	exp_required_type_department = EXP_TYPE_SERVICE
	exp_granted_type = EXP_TYPE_SERVICE
	outfit = /datum/outfit/job/deputy/service
	deputy_department = DEPARTMENT_SERVICE

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/service,
	)
	department_for_prefs = /datum/job_department/service


/**
 * TRIMS
 */

/datum/id_trim/job/deputy
	assignment = "Deputy"
	trim_icon = 'fulp_modules/features/jobs/icons/cards.dmi'
	trim_state = "trim_deputy"
	sechud_icon_state = SECHUD_DEPUTY
	extra_access = list(ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_BRIG, ACCESS_MINERAL_STOREROOM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy
	/// Used to give the Departmental access
	var/department_access = list()

/datum/id_trim/job/deputy/refresh_trim_access()
	. = ..()
	if(!.)
		return
	access |= department_access

/datum/id_trim/job/deputy/engineering
	assignment = "Engineering Deputy"
	trim_state = "trim_deputyeng"
	sechud_icon_state = SECHUD_DEPUTY_ENGINEERING
	department_access = list(ACCESS_ENGINEERING, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_TCOMMS, ACCESS_MINERAL_STOREROOM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy/engineering

/datum/id_trim/job/deputy/medical
	assignment = "Medical Deputy"
	trim_state = "trim_deputymed"
	sechud_icon_state = SECHUD_DEPUTY_MEDICAL
	department_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_PLUMBING, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy/medical

/datum/id_trim/job/deputy/science
	assignment = "Science Deputy"
	trim_state = "trim_deputysci"
	sechud_icon_state = SECHUD_DEPUTY_SCIENCE
	department_access = list(ACCESS_SCIENCE, ACCESS_GENETICS, ACCESS_ORDNANCE, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_ORDNANCE_STORAGE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy/science

/datum/id_trim/job/deputy/supply
	assignment = "Supply Deputy"
	trim_state = "trim_deputysupply"
	sechud_icon_state = SECHUD_DEPUTY_SUPPLY
	department_access = list(ACCESS_SHIPPING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_QM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy/supply

/datum/id_trim/job/deputy/service
	assignment = "Service Deputy"
	trim_state = "trim_deputyservice"
	sechud_icon_state = SECHUD_DEPUTY_SERVICE
	department_access = list(
		ACCESS_BAR, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_SERVICE,
		ACCESS_THEATRE, ACCESS_JANITOR, ACCESS_LAWYER, ACCESS_CHAPEL_OFFICE, ACCESS_CREMATORIUM, ACCESS_LIBRARY,
		ACCESS_MEDICAL, ACCESS_PSYCHOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/deputy/service

/**
 * DEPUTY SPAWNING
 */

/datum/job/deputy/after_spawn(mob/living/carbon/human/user, mob/player, latejoin = FALSE)
	. = ..()

	var/assigned_department = SEC_DEPT_NONE // Might be worth merging this into deputy_department soon.
	var/channel

	if(!deputy_department || deputy_department == DEPARTMENT_SECURITY)
		to_chat(user, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")
		return
	switch(deputy_department)
		if(DEPARTMENT_ENGINEERING)
			assigned_department = SEC_DEPT_ENGINEERING
			channel = RADIO_CHANNEL_ENGINEERING
		if(DEPARTMENT_MEDICAL)
			assigned_department = SEC_DEPT_MEDICAL
			channel = RADIO_CHANNEL_MEDICAL
		if(DEPARTMENT_SCIENCE)
			assigned_department = SEC_DEPT_SCIENCE
			channel = RADIO_CHANNEL_SCIENCE
		if(DEPARTMENT_CARGO)
			assigned_department = SEC_DEPT_SUPPLY
			channel = RADIO_CHANNEL_SUPPLY
		if(DEPARTMENT_SERVICE)
			assigned_department = SEC_DEPT_SERVICE
			channel = RADIO_CHANNEL_SERVICE
	announce_deputy(user, assigned_department, channel)
	to_chat(player, "<b>You have been assigned to [assigned_department]!</b>")


/datum/job/deputy/proc/announce_deputy(mob/deputy, department, channel)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_deputy(deputy, department, channel)


/obj/machinery/announcement_system/proc/announce_deputy(mob/deputy, department, channel)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(channel))

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// Lotsa Deputy stuff, instead of making tons of files lets just sort it all nice and neat////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// Default Deputy
/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/deputy

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
	)

	belt = /obj/item/modular_computer/tablet/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/flashlight/seclite

	id_trim = /datum/id_trim/job/deputy
	box = /obj/item/storage/box/survival

/// Engineering Deputy
/datum/outfit/job/deputy/engineering
	name = "Deputy - Engineering"

	ears = /obj/item/radio/headset/headset_dep/engineering
	neck = /obj/item/clothing/neck/fulptie/engineering
	id_trim = /datum/id_trim/job/deputy/engineering
	accessory = /obj/item/clothing/accessory/armband/engine
	skillchips = list(/obj/item/skillchip/job/deputy/engineering)

/// Medical Deputy
/datum/outfit/job/deputy/medical
	name = "Deputy - Medical"

	ears = /obj/item/radio/headset/headset_dep/medical
	neck = /obj/item/clothing/neck/fulptie/medical
	id_trim = /datum/id_trim/job/deputy/medical
	accessory = /obj/item/clothing/accessory/armband/medblue
	skillchips = list(/obj/item/skillchip/job/deputy/medical)

/// Science Deputy
/datum/outfit/job/deputy/science
	name = "Deputy - Science"

	neck = /obj/item/clothing/neck/fulptie/science
	ears = /obj/item/radio/headset/headset_dep/science
	id_trim = /datum/id_trim/job/deputy/science
	accessory = /obj/item/clothing/accessory/armband/science
	skillchips = list(/obj/item/skillchip/job/deputy/science)

/// Supply Deputy
/datum/outfit/job/deputy/supply
	name = "Deputy - Supply"

	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	ears = /obj/item/radio/headset/headset_dep/supply
	neck = /obj/item/clothing/neck/fulptie/supply
	id_trim = /datum/id_trim/job/deputy/supply
	accessory = /obj/item/clothing/accessory/armband/cargo
	skillchips = list(/obj/item/skillchip/job/deputy/supply)

/// Service Deputy
/datum/outfit/job/deputy/service
	name = "Deputy - Service"

	//LOCKER EQUIPMENT: They don't get a locker, so spawn with it.
	head = /obj/item/clothing/head/beret/service
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	belt = /obj/item/storage/belt/security/deputy
	pda_slot = ITEM_SLOT_LPOCKET
	//END OF LOCKER EQUIPMENT

	ears = /obj/item/radio/headset/headset_dep/service
	neck = /obj/item/clothing/neck/tie/service
	id_trim = /datum/id_trim/job/deputy/service
	accessory = /obj/item/clothing/accessory/armband/hydro
	skillchips = list(/obj/item/skillchip/job/deputy/service)

/// Plasmamen Datum
/datum/outfit/plasmaman/deputy
	name = "Deputy Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	uniform = /obj/item/clothing/under/plasmaman/security/deputy
	gloves = /obj/item/clothing/gloves/color/plasmaman/black

/// Shirt
/obj/item/clothing/under/rank/security/officer/mallcop
	name = "deputy shirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	icon_state = "mallcop"
	icon = 'icons/mob/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/officer/mallcop/skirt
	name = "deputy skirt"
	desc = "An awe-inspiring tactical shirt-and-skirt combo; because safety never takes a holiday."
	icon_state = "mallcop_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/// Ties
/obj/item/clothing/neck/fulptie
	name = "departmental tie"
	desc = "A tie showing off the department colors of a deputy."
	icon = 'icons/obj/clothing/neck.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "supply_tie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_CREW
	var/department

/obj/item/clothing/neck/tie/Initialize()
	. = ..()
	if(department)
		name = "[department] tie"
		desc = "A tie showing off that the user belongs to the [department] department."
		icon_state = "[department]_tie"

/obj/item/clothing/neck/tie/engineering
	department = "engineering"

/obj/item/clothing/neck/tie/medical
	department = "medical"

/obj/item/clothing/neck/tie/science
	department = "science"

/obj/item/clothing/neck/tie/supply
	department = "supply"

/obj/item/clothing/neck/tie/service
	department = "service"

/// Plasmamen clothes
/obj/item/clothing/under/plasmaman/security/deputy
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/under_worn.dmi'
	name = "deputy plasma envirosuit"
	desc = "A plasmaman containment suit designed for deputies, offering a limited amount of extra protection."
	icon_state = "deputy_envirosuit"
	inhand_icon_state = "deputy_envirosuit"

/obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	icon = 'icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/head_worn.dmi'
	name = "deputy envirosuit helmet"
	desc = "A plasmaman containment helmet designed for deputies, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "deputy_envirohelm"
	inhand_icon_state = "deputy_envirohelm"

/// Berets
/obj/item/clothing/head/fulpberet
	worn_icon = 'fulp_modules/features/jobs/icons/head_worn.dmi'
	icon = 'icons/obj/clothing/head/beret.dmi'
	name = "generic deputy beret"
	desc = "You shouldn't be seeing this! File a bug report."
	icon_state = "beret_engi"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	clothing_flags = SNUG_FIT //Prevents being knocked off

/obj/item/clothing/head/fulpberet/engineering
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 40, BIO = 100, FIRE = 100, ACID = 90, WOUND = 5) // CE level
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage. Comes with radiation protection."
	icon_state = "beret_engi"

/obj/item/clothing/head/fulpberet/engineering/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)


/obj/item/clothing/head/fulpberet/medical
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 10, BIO = 100, FIRE = 60, ACID = 75, WOUND = 5) // CMO level
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry, or just used as a bio hood."
	icon_state = "beret_medbay"


/obj/item/clothing/head/fulpberet/science
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 100, BIO = 100, FIRE = 60, ACID = 80, WOUND = 5) // RD level
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'. Fairly bomb resistant."
	icon_state = "beret_science"


/obj/item/clothing/head/fulpberet/supply
	armor = list(MELEE = 20, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 30, BIO = 10, FIRE = 50, ACID = 60, WOUND = 5) /// Bulletproof helmet level
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining. It looks like it's been reinforced due to 'Cargonian' problems."
	icon_state = "beret_supply"


/obj/item/clothing/head/fulpberet/service
	armor = list(MELEE = 40, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100, WOUND = 15) // Captain level
	name = "service deputy beret"
	desc = "The beret of the one able to defeat the Chef in his own kitchen. Can be used to protect you against BEES."
	icon_state = "beret_service"
	clothing_flags = THICKMATERIAL | SNUG_FIT

/// Headsets - Base
/obj/item/radio/headset/headset_dep
	icon = 'fulp_modules/features/jobs/icons/radio.dmi'
	worn_icon = 'icons/mob/clothing/ears.dmi'
	worn_icon_state = "sec_headset_alt"

	name = "generic deputy headset"
	desc = "You shouldn't be seeing this! File a bug report."
	icon_state = "eng_headset"

/obj/item/radio/headset/headset_dep/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/// Engineering
/obj/item/radio/headset/headset_dep/engineering
	name = "engineering bowman headset"
	desc = "The best way to stay alert of any possible sabotage."
	icon_state = "eng_headset"
	keyslot = new /obj/item/encryptionkey/headset_eng

/// Medical
/obj/item/radio/headset/headset_dep/medical
	name = "medical bowman headset"
	desc = "Looks a little worn out from all the chemistry explosions."
	icon_state = "med_headset"
	keyslot = new /obj/item/encryptionkey/headset_med

/// Science
/obj/item/radio/headset/headset_dep/science
	name = "science bowman headset"
	desc = "Suddenly turns off when the Research Director starts yelling Malf."
	icon_state = "sci_headset"
	keyslot = new /obj/item/encryptionkey/headset_sci

/// Supply
/obj/item/radio/headset/headset_dep/supply
	name = "supply bowman headset"
	desc = "Looks half destroyed, probably from all the Cargonia attempts."
	icon_state = "cargo_headset"
	keyslot = new /obj/item/encryptionkey/headset_cargo

/// Service
/obj/item/radio/headset/headset_dep/service
	name = "service bowman headset"
	desc = "For the one constantly recieving calls from the Law office to Botany, Service comms are the most well organized."
	icon_state = "service_headset"
	keyslot = new /obj/item/encryptionkey/headset_service

/// Used for Science Deputies and Brig doctor's Chemical kit.
/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone medipen"
	desc = "Contains a chemical that will remove all of an injected target's mutations."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/mutadone = 10)

/obj/item/storage/belt/security/deputy/PopulateContents()
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/holosign_creator/security(src)
	update_appearance()
