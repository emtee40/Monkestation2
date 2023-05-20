/datum/symptom/robotic_adaptation
	name = "Biometallic Replication"
	desc = "The virus can manipulate metal and silicate compounds, becoming able to infect robotic beings. The virus also provides a suitable substrate for nanites in otherwise inhospitable hosts"
	illness = "Robotic evolution"
	stealth = 0
	resistance = 1
	stage_speed = 4 //while the reference material has low speed, this virus will take a good while to completely convert someone
	transmittable = -1
	level = 8
	severity = 0
	symptom_delay_min = 10
	symptom_delay_max = 30
	//var/prefixes = list("Ratvarian ", "Keter ", "Clockwork ", "Robo")
	var/bodies = list("Robot")
	//var/suffixes = list("-217")
	var/replaceorgans = FALSE
	var/replacebody = FALSE
	var/robustbits = FALSE
	threshold_descs = list(
		"Stage Speed 4" = "The virus will replace the host's organic organs with mundane, biometallic versions.",
		"Resistance 4" = "The virus will eventually convert the host's entire body to biometallic materials, and maintain its cellular integrity.",
		"Stage Speed 10" = "Biometallic mass created by the virus will be superior to typical organic mass."
	)
/datum/symptom/robotic_adaptation/OnAdd(datum/disease/advance/advanced_disease)
	advanced_disease.infectable_biotypes |= MOB_ROBOTIC

/datum/symptom/robotic_adaptation/Start(datum/disease/advance/advanced_disease)
	. = ..()
	if(advanced_disease.totalStageSpeed() >= 4)
		replaceorgans = TRUE
	if(advanced_disease.totalResistance() >= 4)
		replacebody = TRUE
	if(advanced_disease.totalStageSpeed() >= 10)
		robustbits = TRUE //note that having this symptom means most healing symptoms won't work on you


/datum/symptom/robotic_adaptation/Activate(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/human/Host = advanced_disease.affected_mob
	switch(advanced_disease.stage)
		if(3, 4)
			if(replaceorgans)
				to_chat(Host, "<span class='warning'><b>[pick("You feel a grinding pain in your abdomen.", "You exhale a jet of steam.")]</span>")
		if(5)
			if(replaceorgans || replacebody)
				if(Replace(Host))
					return
				if(replacebody)
					Host.adjustCloneLoss(-20) //repair mechanical integrity
	return

/datum/symptom/robotic_adaptation/proc/Replace(mob/living/carbon/human/Host)
	if(replaceorgans)
		for(var/obj/item/organ/Oldlimb in Host.organs)
			if(Oldlimb.status == ORGAN_ROBOTIC) //they are either part robotic or we already converted them!
				continue
			switch(Oldlimb.slot) //i hate doing it this way, but the cleaner way runtimes and does not work
				if(ORGAN_SLOT_BRAIN)
					Oldlimb.name = "enigmatic gearbox"
					Oldlimb.desc ="An engineer would call this inconcievable wonder of gears and metal a 'black box'"
					Oldlimb.icon_state = "brain-clock"
					Oldlimb.status = ORGAN_ROBOTIC
					Oldlimb.organ_flags = ORGAN_SYNTHETIC
					return TRUE
				if(ORGAN_SLOT_STOMACH)
					if(HAS_TRAIT(Host, TRAIT_NOHUNGER))//for future, we could make this give people who requires no food to maintain its no food policy
						var/obj/item/organ/internal/stomach/battery/clockwork/organ = new()
						//if(robustbits)
							//organ.max_charge = 15000 //no longer exists(old bee code)
						organ.Insert(Host, TRUE, FALSE)
					else
						var/obj/item/organ/internal/stomach/clockwork/organ = new()
						organ.Insert(Host, TRUE, FALSE)
					if(prob(40))
						to_chat(Host, "<span class='userdanger'>You feel a stabbing pain in your abdomen!</span>")
						Host.emote("scream")
					return TRUE
				if(ORGAN_SLOT_EARS)
					var/obj/item/organ/internal/ears/robot/clockwork/organ = new()
					if(robustbits)
						organ.damage_multiplier = 0.5
					organ.Insert(Host, TRUE, FALSE)
					to_chat(Host, "<span class='warning'>Your ears pop.</span>")
					return TRUE
				if(ORGAN_SLOT_EYES)
					var/obj/item/organ/internal/eyes/robotic/clockwork/organ = new()
					if(robustbits)
						organ.flash_protect = 1
					organ.Insert(Host, TRUE, FALSE)
					if(prob(40))
						to_chat(Host, "<span class='userdanger'>You feel a stabbing pain in your eyeballs!</span>")
						Host.emote("scream")
					return TRUE
				if(ORGAN_SLOT_LUNGS)
					var/obj/item/organ/internal/lungs/clockwork/organ = new()
					if(robustbits)
						organ.safe_co2_max = 15
						organ.safe_co2_max = 15
						organ.n2o_para_min = 15
						organ.n2o_sleep_min = 15
						organ.BZ_trip_balls_min = 15
						organ.gas_stimulation_min = 15
					organ.Insert(Host, TRUE, FALSE)
					if(prob(40))
						to_chat(Host, "<span class='userdanger'>You feel a stabbing pain in your chest!</span>")
						Host.emote("scream")
					return TRUE
				if(ORGAN_SLOT_HEART)
					var/obj/item/organ/internal/heart/clockwork/organ = new()
					organ.Insert(Host, TRUE, FALSE)
					to_chat(Host, "<span class='userdanger'>You feel a stabbing pain in your chest!</span>")
					Host.emote("scream")
					return TRUE
				if(ORGAN_SLOT_LIVER)
					var/obj/item/organ/internal/liver/clockwork/organ = new()
					if(robustbits)
						organ.toxTolerance = 7
					organ.Insert(Host, TRUE, FALSE)
					if(prob(40))
						to_chat(Host, "<span class='userdanger'>You feel a stabbing pain in your abdomen!</span>")
						Host.emote("scream")
					return TRUE
				if(ORGAN_SLOT_TONGUE)
					if(robustbits)
						var/obj/item/organ/internal/tongue/robot/clockwork/better/organ = new()
						organ.Insert(Host, TRUE, FALSE)
						return TRUE
					else
						var/obj/item/organ/internal/tongue/robot/clockwork/organ = new()
						organ.Insert(Host, TRUE, FALSE)
						return TRUE
				if(ORGAN_SLOT_EXTERNAL_TAIL)
					var/obj/item/organ/external/tail/clockwork/organ = new()
					to_chat(Host, "<span class='userdanger'>imagine you have a tail or not.</span>")
					organ.Insert(Host, TRUE, FALSE)
					return TRUE
				if(ORGAN_SLOT_EXTERNAL_WINGS)
					var/obj/item/organ/external/wings/functional/clockwork/organ = new()
					to_chat(Host, "<span class='userdanger'>imagine you have wings or not.</span>")
					//if(robustbits)
						//organ.flight_level = WINGS_FLYING   //old bee code
					organ.Insert(Host, TRUE, FALSE)
					return TRUE
	if(replacebody)
		for(var/obj/item/bodypart/Oldlimb in Host.bodyparts)
			if(!IS_ORGANIC_LIMB(Oldlimb))
				if(robustbits && Oldlimb.brute_reduction < 3 || Oldlimb.burn_reduction < 2)
					Oldlimb.burn_reduction = max(4, Oldlimb.burn_reduction)
					Oldlimb.brute_reduction = max(5, Oldlimb.brute_reduction)
				continue
			switch(Oldlimb.body_zone)
				if(BODY_ZONE_HEAD)
					var/obj/item/bodypart/head/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your head feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
				if(BODY_ZONE_CHEST)
					var/obj/item/bodypart/chest/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your [Oldlimb] feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
				if(BODY_ZONE_L_ARM)
					var/obj/item/bodypart/arm/left/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your [Oldlimb] feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
				if(BODY_ZONE_R_ARM)
					var/obj/item/bodypart/arm/right/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your [Oldlimb] feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
				if(BODY_ZONE_L_LEG)
					var/obj/item/bodypart/leg/left/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your [Oldlimb] feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
				if(BODY_ZONE_R_LEG)
					var/obj/item/bodypart/leg/right/robot/clockwork/newlimb = new()
					if(robustbits)
						newlimb.brute_reduction = 5
						newlimb.burn_reduction = 4
					newlimb.replace_limb(Host, TRUE)
					Host.visible_message("<span_class='userdanger'>Your [Oldlimb] feels numb, and cold.</span>")
					qdel(Oldlimb)
					return TRUE
	return FALSE

/datum/symptom/robotic_adaptation/End(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/human/Host = advanced_disease.affected_mob
	if(advanced_disease.stage >= 5 && (replaceorgans || replacebody)) //sorry. no disease quartets allowed
		to_chat(Host, "<span class='userdanger'>You feel lighter and springier as your innards lose their clockwork facade.</span>")
		Host.dna.species.regenerate_organs(Host, replace_current = TRUE)
		for(var/obj/item/bodypart/Oldlimb in Host.bodyparts)
			if(!IS_ORGANIC_LIMB(Oldlimb))
				Oldlimb.burn_reduction = initial(Oldlimb.burn_reduction)
				Oldlimb.brute_reduction = initial(Oldlimb.brute_reduction)

/datum/symptom/robotic_adaptation/OnRemove(datum/disease/advance/advanced_disease)
	advanced_disease.infectable_biotypes -= MOB_ROBOTIC

//below this point lies all clockwork bits that make this symptom tick. no pun intended.
/obj/item/organ/internal/ears/robot/clockwork
	name = "biometallic recorder"
	desc = "An odd sort of microphone that looks grown, rather than built."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "ears-clock"

/obj/item/organ/internal/eyes/robotic/clockwork
	name = "biometallic receptors"
	desc = "A fragile set of small, mechanical cameras."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "clockwork_eyeballs"

/obj/item/organ/internal/heart/clockwork //this heart doesnt have the fancy bits normal cyberhearts do. However, it also doesnt fucking kill you when EMPd
	name = "biomechanical pump"
	desc = "A complex, multi-valved hydraulic pump, which fits perfectly where a heart normally would."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "heart-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC

/obj/item/organ/internal/stomach/clockwork
	name = "nutriment refinery"
	desc = "A biomechanical furnace, which turns calories into mechanical energy."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "stomach-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/stomach/clockwork/emp_act(severity)
	owner.adjust_nutrition(-100)  //got rid of severity part

/obj/item/organ/internal/stomach/battery/clockwork
	name = "biometallic flywheel"
	desc = "A biomechanical battery which stores mechanical energy."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "stomach-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	//max_charge = 7500
	//charge = 7500 //old bee code

/obj/item/organ/internal/tongue/robot/clockwork
	name = "dynamic micro-phonograph"
	desc = "An old-timey looking device connected to an odd, shifting cylinder."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "tongueclock"

/obj/item/organ/internal/tongue/robot/clockwork/better
	name = "amplified dynamic micro-phonograph"

/obj/item/organ/internal/tongue/robot/clockwork/better/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
	//speech_args[SPEECH_SPANS] |= SPAN_REALLYBIG  //i disabled this, its abnoxious and makes their chat take 3 times as much space in chat

/obj/item/organ/internal/brain/clockwork
	name = "enigmatic gearbox"
	desc ="An engineer would call this inconcievable wonder of gears and metal a 'black box'"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	var/robust //Set to true if the robustbits causes brain replacement. Because holy fuck is the CLANG CLANG CLANG CLANG annoying

/obj/item/organ/internal/brain/clockwork/emp_act(severity)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25)

/obj/item/organ/internal/brain/clockwork/on_life()
	. = ..()
	if(prob(5) && !robust)
		SEND_SOUND(owner, sound('sound/ambience/ambiruin3.ogg', volume = 25))

/obj/item/organ/internal/liver/clockwork
	name = "biometallic alembic"
	desc = "A series of small pumps and boilers, designed to facilitate proper metabolism."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "liver-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	alcohol_tolerance = 0
	toxTolerance = 0
	toxTolerance = 1 //while the organ isn't damaged by doing its job, it doesnt do it very well

/obj/item/organ/internal/lungs/clockwork
	name = "clockwork diaphragm"
	desc = "A utilitarian bellows which serves to pump oxygen into an automaton's body."
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC

/obj/item/organ/external/tail/clockwork
	name = "biomechanical tail"
	desc = "A stiff tail composed of a strange alloy."
	color = null
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "clocktail"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC

/obj/item/bodypart/arm/left/robot/clockwork
	name = "clockwork left arm"
	desc = "An odd metal arm with fingers driven by blood-based hydraulics."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_l_arm"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1

/obj/item/bodypart/arm/right/robot/clockwork
	name = "clockwork right arm"
	desc = "An odd metal arm with fingers driven by blood-based hydraulics."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_l_arm"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1

/obj/item/bodypart/leg/left/robot/clockwork
	name = "clockwork left leg"
	desc = "An odd metal leg full of intricate mechanisms."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_l_leg"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1

/obj/item/bodypart/leg/right/robot/clockwork
	name = "clockwork right leg"
	desc = "An odd metal leg full of intricate mechanisms."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_r_leg"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1


/obj/item/bodypart/head/robot/clockwork
	name = "clockwork head"
	desc = "An odd metal head that still feels warm to the touch."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_head"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1


/obj/item/bodypart/chest/robot/clockwork
	name = "clockwork torso"
	desc = "An odd metal body full of gears and pipes. It still seems alive."
	icon = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	icon_state = "borg_chest"
	flags_1 = CONDUCT_1
	icon_static = 'monkestation/icons/mob/augmentation/augments_clockwork.dmi'
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"
	brute_reduction = 3
	burn_reduction = 2
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)
	disabling_threshold_percentage = 1

/datum/sprite_accessory/wings/clockwork// this part requires a spriter and generally someone who knows how tails/wings works because i don't really care.
	name = "biometallic wings"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "clockwings"
	color_src = FALSE
	dimension_x = 32
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/clockwork
	name = "biometallic wings"
	icon = 'monkestation/icons/obj/medical/organs/organs.dmi'
	icon_state = "clockwings"
	color_src = FALSE
	dimension_x = 32
	center = TRUE
	dimension_y = 32

/obj/item/organ/external/wings/functional/clockwork
	name = "biometallic wings"
	desc = "A pair of thin metallic membranes."
	sprite_accessory_override = /datum/sprite_accessory/wings/clockwork
