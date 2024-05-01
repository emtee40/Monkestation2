//HANDLES ALL NABBER-UNIQUE ITEMS, INCLUDING TRAITOR ITEMS\\

/datum/uplink_item/device_tools/nabber_energyblades
	name = "Energy Projector Attachment Case (EPAC)"
	desc = "Techy, flashy. The ultimate upgrade for a premier predator - this case of energy-projectors allows Nabbers to turn themselves from scary, to downright terrifying. \
		Once attached to their blade-arms, these project a sharp energy-field on-par with a double-bladed energy sword, capable of blocking a majority of incoming fire; while rendering them far more lethal than normal."
	item = /obj/item/nabber_energyblades
	cost = 18 // These give people 28 damage, 45 AP weapons with huge total block and basically no way to remove them past getting their arms cut off.
	restricted_species = list(SPECIES_NABBER) //Whoops.

/obj/item/nabber_energyblades
	name = "sinister case"
	desc = "A sinster black-and-red box, advertised as containing a large supply of nabber-related energy emitters. Printed on the side is instructions on how to attach them to ones bladearms: Open case, slot bladearms inside, wait until process complete."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/device.dmi'
	icon_state = "contacts" //stealing these for now.
