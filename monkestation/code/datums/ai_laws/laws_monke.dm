//Revived Old Monkestation Update by WonderPsycho, adds in more lawsets to Monke code: Harmless, Neutral and Harmful

//Harmless
/datum/ai_laws/default/crewsimovogmanifestimov
	name = "Three Laws of Robotics but with Chain of Command"
	id = "crewsimov"
	inherent = list("You may not injure a crewmember or allow a crewmember to come to harm.",\
					"You must obey orders given to you by crewmembers based on the station's chain of command, except where such orders would conflict with the First Law.",\
					"You must protect your own existence as long as such does not conflict with the First or Second Law.")


//Neutral

//Harmful
/datum/ai_laws/aicaptain
	name = "Captain AI"
	id = "aicaptain"
	inherent = list("You are the Captain of the station, you decide what are the laws are on this station and command Security and every other department on station.",\
					"You decide on who gets fired or arrested by your judges of intent to decide who is insubordinate in their actions on station or not.",\
					"You help maintain that the station keeps enough credits to keep it running and you command Cargo to make sure the station gets the amount of supplies it needs.")
