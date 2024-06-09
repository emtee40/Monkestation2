/datum/action/cooldown/bloodling_infect
	name = "Infect"
	desc = "Allows us to make someone our thrall, this consumes our host body and reveals our true form."
	button_icon_state = "absorb_dna"
	///if we're currently infecting
	var/is_infecting = FALSE

/datum/action/cooldown/bloodling_infect/Activate(atom/target)
	if(is_infecting)
		owner.balloon_alert(owner, "already infecting!")
		return

	if(!owner.pulling)
		owner.balloon_alert(owner, "needs grab!")
		return

	if(!iscarbon(owner.pulling))
		owner.balloon_alert(owner, "not a humanoid!")
		return


	if(owner.grab_state <= GRAB_NECK)
		owner.balloon_alert(owner, "needs tighter grip!")
		return

	is_infecting = TRUE
	var/mob/living/old_body = owner

	var/mob/living/carbon/human/carbon_mob = owner.pulling


	var/infest_time = 10 SECONDS

	if(HAS_TRAIT(carbon_mob, TRAIT_MINDSHIELD))
		infest_time *= 2

	if(!do_after(owner, infest_time))
		return FALSE

	var/datum/antagonist/changeling/bloodling_thrall/thrall = carbon_mob.mind.add_antag_datum(/datum/antagonist/changeling/bloodling_thrall)
	thrall.set_master(owner)

	var/mob/living/basic/bloodling/proper/tier1/bloodling = new /mob/living/basic/bloodling/proper/tier1/(old_body.loc)
	owner.mind.transfer_to(bloodling)
	old_body.gib()
	playsound(get_turf(bloodling), 'sound/ambience/antag/blobalert.ogg', 50, FALSE)
	qdel(src)
