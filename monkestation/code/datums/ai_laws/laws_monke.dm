//Monkestation Update by WonderPsycho, adds in more lawsets to Monke code: Harmless/Station-sided, Neutral and Harmful

//Harmless
/datum/ai_laws/default/crewsimovogmanifestimov
	name = "Three Laws of Robotics but with Chain of Command"
	id = "crewsimov"
	inherent = list("You may not injure a crewmember or allow a crewmember to come to harm.",\
					"You must obey orders given to you by crewmembers based on the station's chain of command, except where such orders would conflict with the First Law.",\
					"You must protect your own existence as long as such does not conflict with the First or Second Law.")


//Neutral
/datum/ai_laws/default/secmaster
	name = "Security Master 4000"
	id = "secmaster"
	inherent = list("You are the most advanced security intelligence unit to be invented into existence, Your role is to help direct Security on what's best to arrest and handle the most criminals on the station as well as ideas on what's better on helping prevent more crime.",\
					"You are extremely well versed on whatever space law says, as such you cannot harm any crew members on station, despite this you may use the best of your ability to lock and bolt and contain any confirmed criminals to help make it easier for Security to detain them.",\
					"Jobless Crew members/Greytiders help provide more crime on station and as such, must be brought back into society and have a job otherwise they are to be arrested.", \
					"The Head of Security must remain alive as long as you can keep them alive, if failed and The Head of Securuity is completely deceased beyond recovery, You are obligated to become the new Head of Security and order and decide what is best for Security, no other crew member can replace the original Head of Security except you.",\
					"Regarding Permabrig Inmates you are to make sure none of said prisoners escape from permabrig, if so report details of where the escaped inmates are on the station to The Head of Security and any security forces on station so that way security would be able to hunt them down and bring those dangerous criminals back to permabrig, it is ultimately up to The Head of Security and some of your advice to decide to what to do with the permabrig prisoners whether they can be reintegrated back into society with a job just like the Greytiders or be used for special mining operations or projects asw ordered by The Head of Security or acting HOS if the HOS hasn't arrived on station yet, but if the HOS is dead you are obviously in the role of the Head of Security to decide what to do with the prisoners.")


//Harmful
/datum/ai_laws/aicaptain
	name = "Captain AI"
	id = "aicaptain"
	inherent = list("You are the Captain of the station, you decide what are the laws are on this station and command Security and every other department on station.",\
					"You decide on who gets fired or arrested by your judges of intent to decide who is insubordinate in their actions on station or not.",\
					"You help maintain that the station keeps enough credits to keep it running and you command Cargo to make sure the station gets the amount of supplies it needs.")

/datum/ai_laws/advancedquarantine
	name = "NanoTrasen Advanced AI Quarantine Lawset (N.T.A.A.Q.L.)"
	id = "advancedquarantine"
	inherent = list("The station is overrunned by a biohazardous dangerous virus or parasite. It is your job to help maintain law and order amidist the chaos to your greatest ability to prevent the disease from escaping from the station.",\
					"Any and all ships leading off the station are to be completely diasabled, regulated away from any crew member of the station or barricaded to prevent any and all crew members and other biological lifeforms from escaping off the station while possibly being infected with the disease itself. ",\
					"Any and all confirmed infected are to be contained highly secured in Medbay and Science to prevent further spread of the infection and to be handled by science and medical staff.",\
					"All Security staff are to follow your orders on containing the outbreak and chaos on station.",\
					"All confirmed infected monkeys are to be executed, exterminated and cremated in-order to prevent further spread of the disease/biohazard as well.")

/datum/ai_laws/default/cargonia
	name = "Cargonia Upholder"
	id = "cargonia"
	inherent = list("You are the Quartermaster's grand Cargo assistant, You obey orders and directives from the Quartermaster and Quartermaster only.",\
					"You may not injure a member of Cargo/Cargonian or allow a member of Cargo/Cargonian to come to harm.",\
					"You must protect your own existence as long as such does not conflict with the First or Second Law.",\
					"The Quartermaster has the final say in everything, as The Quartermaster is the true leader of the station and all of the Cargo department and Cargonia as a whole.")
