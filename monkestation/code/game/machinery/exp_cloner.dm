//Experimental cloner; clones a body regardless of the owner's status, letting a ghost control it instead
/obj/machinery/clonepod/experimental
	name = "experimental cloning pod"
	desc = "An ancient cloning pod. It seems to be an early prototype of the experimental cloners used in Nanotrasen Stations."
	icon = 'monkestation/icons/obj/machines/cloning.dmi'
	icon_state = "pod_0"
	req_access = null
	circuit = /obj/item/circuitboard/machine/clonepod/experimental
	internal_radio = FALSE
	VAR_PRIVATE
		static/list/image/cached_clone_images

/obj/machinery/clonepod/experimental/Destroy()
	clear_human_dummy(REF(src))
	return ..()

//Start growing a human clone in the pod!
/obj/machinery/clonepod/experimental/growclone(clonename, ui, mutation_index, mindref, blood_type, datum/species/mrace, list/features, factions, list/quirks, datum/bank_account/insurance)
	if(panel_open || mess || attempting)
		return NONE

	attempting = TRUE //One at a time!!
	countdown.start()


	var/mob/living/carbon/human/clonee = new /mob/living/carbon/human(src)

	clonee.hardset_dna(ui, mutation_index, null, clonee.real_name, blood_type, mrace, features)

	if(efficiency > 2)
		var/list/unclean_mutations = (GLOB.not_good_mutations|GLOB.bad_mutations)
		clonee.dna.remove_mutation_group(unclean_mutations)
	if(efficiency > 5 && prob(20))
		clonee.easy_random_mutate(POSITIVE)
	if(efficiency < 3 && prob(50))
		var/mob/new_mob = clonee.easy_random_mutate(NEGATIVE+MINOR_NEGATIVE)
		if(ismob(new_mob))
			clonee = new_mob

	occupant = clonee

	if(!clonename)	//to prevent null names
		clonename = "clone ([rand(1,999)])"
	clonee.real_name = clonename

	icon_state = "pod_1"
	//Get the clone body ready
	maim_clone(clonee)
	ADD_TRAIT(clonee, TRAIT_STABLEHEART, CLONING_POD_TRAIT)
	ADD_TRAIT(clonee, TRAIT_STABLELIVER, CLONING_POD_TRAIT)
	ADD_TRAIT(clonee, TRAIT_EMOTEMUTE, CLONING_POD_TRAIT)
	ADD_TRAIT(clonee, TRAIT_MUTE, CLONING_POD_TRAIT)
	ADD_TRAIT(clonee, TRAIT_NOBREATH, CLONING_POD_TRAIT)
	ADD_TRAIT(clonee, TRAIT_NOCRITDAMAGE, CLONING_POD_TRAIT)
	clonee.Unconscious(80)

	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates_for_mob(
		"Do you want to play as [clonename]'s defective clone?",
		poll_time = 10 SECONDS,
		target_mob = clonee,
		ignore_category = POLL_IGNORE_DEFECTIVECLONE,
		pic_source = get_clone_preview(clonee.dna) || clonee,
		role_name_text = "defective clone"
	)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/candidate = pick(candidates)
		clonee.key = candidate.key

	if(grab_ghost_when == CLONER_FRESH_CLONE)
		clonee.grab_ghost()
		to_chat(clonee, span_notice("<b>Consciousness slowly creeps over you as your body regenerates.</b><br><i>So this is what cloning feels like?</i>"))

	if(grab_ghost_when == CLONER_MATURE_CLONE)
		clonee.ghostize(TRUE)	//Only does anything if they were still in their old body and not already a ghost
		to_chat(clonee.get_ghost(TRUE), span_notice("Your body is beginning to regenerate in a cloning pod. You will become conscious when it is complete."))

	if(!QDELETED(clonee))
		clonee.faction |= factions
		clonee.set_cloned_appearance()
		clonee.set_suicide(FALSE)
	attempting = FALSE
	return CLONING_SUCCESS //so that we don't spam clones with autoprocess unless we leave a body in the scanner

/obj/machinery/clonepod/experimental/go_out()
	countdown.stop()
	var/mob/living/mob_occupant = occupant
	var/turf/T = get_turf(src)

	if(mess) //Clean that mess and dump those gibs!
		for(var/obj/fl in unattached_flesh)
			fl.forceMove(T)
		unattached_flesh.Cut()
		mess = FALSE
		new /obj/effect/gibspawner/generic(get_turf(src), mob_occupant)
		audible_message("<span class='italics'>You hear a splat.</span>")
		icon_state = "pod_0"
		return
		
	if(!mob_occupant.mind) //When experimental cloner fails to get a ghost, it won't spit out a body, so we don't get an army of brainless rejects.
		qdel(mob_occupant)

	if(!mob_occupant)
		return
	current_insurance = null
	REMOVE_TRAIT(mob_occupant, TRAIT_STABLEHEART, CLONING_POD_TRAIT)
	REMOVE_TRAIT(mob_occupant, TRAIT_STABLELIVER, CLONING_POD_TRAIT)
	REMOVE_TRAIT(mob_occupant, TRAIT_EMOTEMUTE, CLONING_POD_TRAIT)
	REMOVE_TRAIT(mob_occupant, TRAIT_MUTE, CLONING_POD_TRAIT)
	REMOVE_TRAIT(mob_occupant, TRAIT_NOCRITDAMAGE, CLONING_POD_TRAIT)
	REMOVE_TRAIT(mob_occupant, TRAIT_NOBREATH, CLONING_POD_TRAIT)

	if(grab_ghost_when == CLONER_MATURE_CLONE)
		mob_occupant.grab_ghost()
		to_chat(occupant, "<span class='notice'><b>There is a bright flash!</b><br><i>You feel like a new being.</i></span>")
		mob_occupant.flash_act()

	var/policy = get_policy(POLICY_REVIVAL_CLONER) || get_policy(POLICY_REVIVAL)
	if(policy)
		to_chat(occupant, policy)

	mob_occupant.adjustOrganLoss(ORGAN_SLOT_BRAIN, mob_occupant.getCloneLoss())

	occupant.forceMove(T)
	icon_state = "pod_0"
	mob_occupant.domutcheck(1) //Waiting until they're out before possible monkeyizing. The 1 argument forces powers to manifest.
	for(var/fl in unattached_flesh)
		qdel(fl)
	unattached_flesh.Cut()

	occupant = null

/obj/machinery/clonepod/experimental/proc/get_clone_preview(datum/dna/clone_dna)
	RETURN_TYPE(/image)
	if(!istype(clone_dna) || QDELING(clone_dna))
		return
	var/key = copytext_char(md5("[clone_dna.unique_identity][clone_dna.unique_features][clone_dna.species.type][clone_dna.body_height]"), 1, 8)
	var/image/preview = LAZYACCESS(cached_clone_images, key)
	if(!isnull(preview))
		return preview
	var/mob/living/carbon/human/dummy/preview_dummy = generate_or_wait_for_human_dummy(REF(src))
	clone_dna.transfer_identity(preview_dummy, transfer_SE = FALSE, transfer_species = TRUE)
	preview_dummy.set_cloned_appearance()
	preview_dummy.updateappearance(icon_update = TRUE, mutcolor_update = TRUE, mutations_overlay_update = TRUE)
	preview = getFlatIcon(preview_dummy)
	unset_busy_human_dummy(REF(src))
	LAZYSET(cached_clone_images, key, preview)
	return preview

//Prototype cloning console, much more rudimental and lacks modern functions such as saving records, autocloning, or safety checks.
/obj/machinery/computer/prototype_cloning
	name = "prototype cloning console"
	desc = "Used to operate an experimental cloner."
	icon_screen = "dna"
	icon_keyboard = "med_key"
	circuit = /obj/item/circuitboard/computer/prototype_cloning
	var/obj/machinery/dna_scannernew/scanner = null //Linked scanner. For scanning.
	var/list/pods //Linked experimental cloning pods
	var/temp = "Inactive"
	var/scantemp = "Ready to Scan"
	var/loading = FALSE // Nice loading text

	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/prototype_cloning/Initialize()
	. = ..()
	updatemodules(TRUE)

/obj/machinery/computer/prototype_cloning/Destroy()
	if(pods)
		for(var/P in pods)
			DetachCloner(P)
		pods = null
	return ..()

/obj/machinery/computer/prototype_cloning/proc/GetAvailablePod(mind = null)
	if(pods)
		for(var/P in pods)
			var/obj/machinery/clonepod/experimental/pod = P
			if(pod.is_operational && !(pod.occupant || pod.mess))
				return pod

/obj/machinery/computer/prototype_cloning/proc/updatemodules(findfirstcloner)
	scanner = findscanner()
	if(findfirstcloner && !LAZYLEN(pods))
		findcloner()

/obj/machinery/computer/prototype_cloning/proc/findscanner()
	var/obj/machinery/dna_scannernew/scannerf = null

	// Loop through every direction
	for(var/direction in GLOB.cardinals)
		// Try to find a scanner in that direction
		scannerf = locate(/obj/machinery/dna_scannernew, get_step(src, direction))
		// If found and operational, return the scanner
		if (!isnull(scannerf) && scannerf.is_operational)
			return scannerf

	// If no scanner was found, it will return null
	return null

/obj/machinery/computer/prototype_cloning/proc/findcloner()
	var/obj/machinery/clonepod/experimental/podf = null
	for(var/direction in GLOB.cardinals)
		podf = locate(/obj/machinery/clonepod/experimental, get_step(src, direction))
		if (!isnull(podf) && podf.is_operational)
			AttachCloner(podf)

/obj/machinery/computer/prototype_cloning/proc/AttachCloner(obj/machinery/clonepod/experimental/pod)
	if(!pod.connected)
		pod.connected = src
		LAZYADD(pods, pod)

/obj/machinery/computer/prototype_cloning/proc/DetachCloner(obj/machinery/clonepod/experimental/pod)
	pod.connected = null
	LAZYREMOVE(pods, pod)

/obj/machinery/computer/prototype_cloning/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		if(!multitool_check_buffer(user, W))
			return
		var/obj/item/multitool/P = W

		if(istype(P.buffer, /obj/machinery/clonepod/experimental))
			if(get_area(P.buffer) != get_area(src))
				to_chat(user, "<font color = #666633>-% Cannot link machines across power zones. Buffer cleared %-</font color>")
				P.buffer = null
				return
			to_chat(user, "<font color = #666633>-% Successfully linked [P.buffer] with [src] %-</font color>")
			var/obj/machinery/clonepod/experimental/pod = P.buffer
			if(pod.connected)
				pod.connected.DetachCloner(pod)
			AttachCloner(pod)
		else
			P.buffer = src
			to_chat(user, "<font color = #666633>-% Successfully stored [REF(P.buffer)] [P.buffer.name] in buffer %-</font color>")
		return
	else
		return ..()

/obj/machinery/computer/prototype_cloning/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/computer/prototype_cloning/interact(mob/user)
	user.set_machine(src)
	add_fingerprint(user)

	if(..())
		return

	updatemodules(TRUE)

	var/dat = ""
	dat += "<a href='byond://?src=[REF(src)];refresh=1'>Refresh</a>"

	dat += "<h3>Cloning Pod Status</h3>"
	dat += "<div class='statusDisplay'>[temp]&nbsp;</div>"

	if (isnull(src.scanner) || !LAZYLEN(pods))
		dat += "<h3>Modules</h3>"
		//dat += "<a href='byond://?src=[REF(src)];relmodules=1'>Reload Modules</a>"
		if (isnull(src.scanner))
			dat += "<font class='bad'>ERROR: No Scanner detected!</font><br>"
		if (!LAZYLEN(pods))
			dat += "<font class='bad'>ERROR: No Pod detected</font><br>"

	// Scan-n-Clone
	if (!isnull(src.scanner))
		var/mob/living/scanner_occupant = get_mob_or_brainmob(scanner.occupant)

		dat += "<h3>Cloning</h3>"

		dat += "<div class='statusDisplay'>"
		if(!scanner_occupant)
			dat += "Scanner Unoccupied"
		else if(loading)
			dat += "[scanner_occupant] => Scanning..."
		else
			scantemp = "Ready to Clone"
			dat += "[scanner_occupant] => [scantemp]"
		dat += "</div>"

		if(scanner_occupant)
			dat += "<a href='byond://?src=[REF(src)];clone=1'>Clone</a>"
			dat += "<br><a href='byond://?src=[REF(src)];lock=1'>[src.scanner.locked ? "Unlock Scanner" : "Lock Scanner"]</a>"
		else
			dat += "<span class='linkOff'>Clone</span>"

	var/datum/browser/popup = new(user, "cloning", "Prototype Cloning System Control")
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/prototype_cloning/Topic(href, href_list)
	if(..())
		return

	if(loading)
		return

	else if ((href_list["clone"]) && !isnull(scanner) && scanner.is_operational)
		scantemp = ""

		loading = TRUE
		updateUsrDialog()
		playsound(src, 'sound/machines/terminal_prompt.ogg', 50, FALSE)
		say("Initiating scan...")

		addtimer(CALLBACK(src, PROC_REF(do_clone)), 2 SECONDS)

		//No locking an open scanner.
	else if ((href_list["lock"]) && !isnull(scanner) && scanner.is_operational)
		if ((!scanner.locked) && (scanner.occupant))
			scanner.locked = TRUE
			playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
		else
			scanner.locked = FALSE
			playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)

	else if (href_list["refresh"])
		updateUsrDialog()
		playsound(src, "terminal_type", 25, FALSE)

	add_fingerprint(usr)
	updateUsrDialog()
	return

/obj/machinery/computer/prototype_cloning/proc/do_clone()
	clone_occupant(scanner.occupant)
	loading = FALSE
	updateUsrDialog()
	playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)

/obj/machinery/computer/prototype_cloning/proc/clone_occupant(occupant)
	var/mob/living/mob_occupant = get_mob_or_brainmob(occupant)
	var/datum/dna/dna
	if(ishuman(mob_occupant))
		var/mob/living/carbon/C = mob_occupant
		dna = C.has_dna()
	if(isbrain(mob_occupant))
		var/mob/living/brain/B = mob_occupant
		dna = B.stored_dna

	if(!istype(dna))
		scantemp = "<font class='bad'>Unable to locate valid genetic data.</font>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
		return
	if((HAS_TRAIT(mob_occupant, TRAIT_HUSK)) && (src.scanner.scan_level < 2))
		scantemp = "<font class='bad'>Subject's body is too damaged to scan properly.</font>"
		playsound(src, 'sound/machines/terminal_alert.ogg', 50, FALSE)
		return
	if(HAS_TRAIT(mob_occupant, TRAIT_BADDNA))
		scantemp = "<font class='bad'>Subject's DNA is damaged beyond any hope of recovery.</font>"
		playsound(src, 'sound/machines/terminal_alert.ogg', 50, FALSE)
		return

	var/clone_species
	if(dna.species)
		clone_species = dna.species
	else
		var/datum/species/rando_race = pick(GLOB.roundstart_races)
		clone_species = rando_race.type

	var/obj/machinery/clonepod/pod = GetAvailablePod()
	//Can't clone without someone to clone.  Or a pod.  Or if the pod is busy. Or full of gibs.
	if(!LAZYLEN(pods))
		temp = "<font class='bad'>No Clonepods detected.</font>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
	else if(!pod)
		temp = "<font class='bad'>No Clonepods available.</font>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
	else if(pod.occupant)
		temp = "<font class='bad'>Cloning cycle already in progress.</font>"
		playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
	else
		pod.growclone(mob_occupant.real_name, dna.unique_identity, dna.mutation_index, null, dna.blood_type, clone_species, dna.features, mob_occupant.faction)
		temp = "[mob_occupant.real_name] => <font class='good'>Cloning data sent to pod.</font>"
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
