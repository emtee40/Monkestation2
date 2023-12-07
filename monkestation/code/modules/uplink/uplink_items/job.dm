/datum/uplink_item/role_restricted/minibible
	name = "Miniature Bible"
	desc = "We understand it can be difficult to carry out some of our missions. Here is some spiritual counsel in a small package."
	progression_minimum = 5 MINUTES
	cost = 1
	item = /obj/item/storage/book/bible/mini
	restricted_roles = list(JOB_CHAPLAIN, JOB_CLOWN)

/datum/uplink_item/role_restricted/reverse_bear_trap
	surplus = 60

/datum/uplink_item/role_restricted/modified_syringe_gun
	surplus = 50

/datum/uplink_item/role_restricted/mayhembottle
	name = "Mayhem In A Bottle"
	desc = "Found within some ruins on a hellish planet, we found this strange artifact. From our analysis we have determined that it is very fragile \
	and when broken will cause some very bloody effects. It also is cursed and must be smashed in hand, which means you'll be caught in the effect probably \
	so beware. Rip and Tear Agent."
	progression_minimum = 5 MINUTES
	cost = 20
	item = /obj/item/mayhem
	restricted_roles = list(JOB_CURATOR)
