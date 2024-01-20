/obj/item/borer_egg/neutered
	name = "strange borer egg"
	icon_state = "empowered_brainegg"

/obj/effect/mob_spawn/ghost_role/borer_egg/neutered
	name = "strange borer egg"
	desc = "An egg of a creature that is known to crawl inside of you, be careful."
	mob_type = /mob/living/basic/cortical_borer/neutered
	host_egg = /obj/item/borer_egg/neutered
	you_are_text = "You are a Neutered Cortical Borer."
	flavour_text = "You are a neutered cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! \
					You only grow/heal/talk when inside a host!"
	important_text = "As a borer, you have the option to be friendly or not. \
					Note that how you act will determine how a host responds. \
					Do not wordlessly resort to mechanics within a host. \
					You can talk to other borers using ; and your host by just speaking normally. \
					You are unable to speak outside of a host, but are able to emote. \
					Additionally you have been trained by the syndicate to obey every command and protect whomever is the nearest to you when you crawled out of your egg."
	generation = 1 // you dont exactly have balls, so how can you be the hive's queen?
