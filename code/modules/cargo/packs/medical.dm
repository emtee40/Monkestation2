/datum/supply_pack/medical
	group = "Medical"
	crate_type = /obj/structure/closet/crate/medical

/datum/supply_pack/medical/bloodpacks
	name = "Blood Pack Variety Crate"
	desc = "Contains ten different blood packs for reintroducing blood to patients."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/reagent_containers/blood = 2,
					/obj/item/reagent_containers/blood/a_plus,
					/obj/item/reagent_containers/blood/a_minus,
					/obj/item/reagent_containers/blood/b_plus,
					/obj/item/reagent_containers/blood/b_minus,
					/obj/item/reagent_containers/blood/o_plus,
					/obj/item/reagent_containers/blood/o_minus,
					/obj/item/reagent_containers/blood/lizard,
					/obj/item/reagent_containers/blood/ethereal,
				)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/medical/medipen_variety
	name = "Medipen Variety-Pak"
	desc = "Contains eight different medipens in three different varieties, \
		to assist in quickly treating seriously injured patients."
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/reagent_containers/hypospray/medipen = 2,
					/obj/item/reagent_containers/hypospray/medipen/ekit = 3,
					/obj/item/reagent_containers/hypospray/medipen/blood_loss = 3)
	crate_name = "medipen crate"

/datum/supply_pack/medical/chemical
	name = "Chemical Starter Kit Crate"
	desc = "Contains thirteen different chemicals, for all the fun experiments you can make."
	cost = CARGO_CRATE_VALUE * 2.6
	contains = list(/obj/item/reagent_containers/cup/bottle/hydrogen,
					/obj/item/reagent_containers/cup/bottle/carbon,
					/obj/item/reagent_containers/cup/bottle/nitrogen,
					/obj/item/reagent_containers/cup/bottle/oxygen,
					/obj/item/reagent_containers/cup/bottle/fluorine,
					/obj/item/reagent_containers/cup/bottle/phosphorus,
					/obj/item/reagent_containers/cup/bottle/silicon,
					/obj/item/reagent_containers/cup/bottle/chlorine,
					/obj/item/reagent_containers/cup/bottle/radium,
					/obj/item/reagent_containers/cup/bottle/sacid,
					/obj/item/reagent_containers/cup/bottle/ethanol,
					/obj/item/reagent_containers/cup/bottle/potassium,
					/obj/item/reagent_containers/cup/bottle/sugar,
					/obj/item/clothing/glasses/science,
					/obj/item/reagent_containers/dropper,
					/obj/item/storage/box/beakers,
				)
	crate_name = "chemical crate"

/datum/supply_pack/medical/defibs
	name = "Defibrillator Crate"
	desc = "Contains two defibrillators for bringing the recently deceased back to life."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/defibrillator/loaded = 2)
	crate_name = "defibrillator crate"

/datum/supply_pack/medical/iv_drip
	name = "IV Drip Crate"
	desc = "Contains a single IV drip for administering blood to patients."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/machinery/iv_drip)
	crate_name = "iv drip crate"

/datum/supply_pack/medical/supplies
	name = "Medical Supplies Crate"
	desc = "Contains a random assortment of medical supplies. German doctor not included."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/reagent_containers/cup/bottle/multiver,
					/obj/item/reagent_containers/cup/bottle/epinephrine,
					/obj/item/reagent_containers/cup/bottle/morphine,
					/obj/item/reagent_containers/cup/bottle/toxin,
					/obj/item/reagent_containers/cup/beaker/large,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/stack/medical/gauze,
					/obj/item/storage/box/beakers,
					/obj/item/storage/box/medigels,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/medkit/regular,
					/obj/item/storage/medkit/o2,
					/obj/item/storage/medkit/toxin,
					/obj/item/storage/medkit/brute,
					/obj/item/storage/medkit/fire,
					/obj/item/defibrillator/loaded,
					/obj/item/reagent_containers/blood/o_minus,
					/obj/item/storage/pill_bottle/mining,
					/obj/item/reagent_containers/pill/neurine,
					/obj/item/stack/medical/bone_gel/four = 2,
					/obj/item/vending_refill/medical,
					/obj/item/vending_refill/drugs,
				)
	crate_name = "medical supplies crate"

/datum/supply_pack/medical/supplies/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to 10)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/medical/medkits
	name = "Basic Treament Kits Crate"
	desc = "Contains three first aid kits focused on basic types of damage in a simple way."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/storage/medkit/regular = 3)
	crate_name = "basic wound treatment kits crate"

/datum/supply_pack/medical/brutekits
	name = "Bruise Treatment Kits Crate"
	desc = "Contains three first aid kits focused on healing bruises and broken bones."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/storage/medkit/brute = 3)
	crate_name = "brute treatment kits crate"

/datum/supply_pack/medical/burnkits
	name = "Burn Treatment Kits Crate"
	desc = "Contains three first aid kits focused on healing severe burns."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/storage/medkit/fire = 3)
	crate_name = "burn treatment kits crate"

/datum/supply_pack/medical/toxinkits
	name = "Toxin Treatment Kits Crate"
	desc = "Containts three first aid kits focused on healing damage dealt by heavy toxins."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/storage/medkit/toxin = 3)
	crate_name = "toxin treatment kits crate"

/datum/supply_pack/medical/oxylosskits
	name = "Oxygen Deprivation Kits Crate"
	desc = "Contains three first aid kits focused on helping oxygen deprivation victims."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/storage/medkit/o2 = 3)
	crate_name = "oxygen deprivation treatment kits crate"

/datum/supply_pack/medical/advkits
	name = "Advanced Medical Kits Crate"
	desc = "For when the basic kits don't cut it."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/storage/medkit/advanced = 3)
	crate_name = "advanced treatment kits crate"

/datum/supply_pack/medical/randommedkit
	name = "Random Medkits Crate"
	desc = "A mishmosh of medkits for the indecisive."
	cost = CARGO_CRATE_VALUE * 5
	contains = list()
	crate_name = "Medkit Assortment Crate"

/datum/supply_pack/medical/randommedkit/fill/(obj/structure/closet/crate/C)
	for(var/i in 1 to 6)
		var/item = pick(
			prob(10);
				/obj/item/storage/medkit/regular,
			prob(20);
				/obj/item/storage/medkit/brute,
			prob(20);
				/obj/item/storage/medkit/fire,
			prob(20);
				/obj/item/storage/medkit/toxin,
			prob(20);
				/obj/item/storage/medkit/o2,
			prob(10);
				/obj/item/storage/medkit/advanced,
			prob(10);
				/obj/item/storage/medkit/surgery
		)
		new item(C)

/datum/supply_pack/medical/surgery
	name = "Surgical Supplies Crate"
	desc = "Do you want to perform surgery, but don't have one of those fancy \
		shmancy degrees? Just get started with this crate containing a medical duffelbag, \
		Sterilizine spray and collapsible roller bed."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/storage/backpack/duffelbag/med/surgery,
					/obj/item/reagent_containers/medigel/sterilizine,
					/obj/item/roller,
				)
	crate_name = "surgical supplies crate"

/datum/supply_pack/medical/salglucanister
	name = "Heavy-Duty Saline Canister"
	desc = "Contains a bulk supply of saline-glucose condensed into a single canister that \
		should last several days, with a large pump to fill containers with. Direct injection \
		of saline should be left to medical professionals as the pump is capable of overdosing \
		patients."
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_MEDICAL
	contains = list(/obj/machinery/iv_drip/saline)

/datum/supply_pack/medical/virus
	name = "Virus Crate"
	desc = "Contains twelve different bottles of several viral samples for virology \
		research. Also includes seven beakers and syringes. Balled-up jeans not included."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_CMO
	access_view = ACCESS_VIROLOGY
	contains = list(/obj/item/reagent_containers/cup/bottle/flu_virion,
					/obj/item/reagent_containers/cup/bottle/cold,
					/obj/item/reagent_containers/cup/bottle/random_virus = 4,
					/obj/item/reagent_containers/cup/bottle/fake_gbs,
					/obj/item/reagent_containers/cup/bottle/magnitis,
					/obj/item/reagent_containers/cup/bottle/pierrot_throat,
					/obj/item/reagent_containers/cup/bottle/brainrot,
					/obj/item/reagent_containers/cup/bottle/anxiety,
					/obj/item/reagent_containers/cup/bottle/beesease,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/beakers,
					/obj/item/reagent_containers/cup/bottle/mutagen,
				)
	crate_name = "virus crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	dangerous = TRUE

/datum/supply_pack/medical/cmoturtlenecks
	name = "Chief Medical Officer Turtlenecks"
	desc = "Contains the CMO's turtleneck and turtleneck skirt."
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_CMO
	contains = list(/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck,
					/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck/skirt,
				)

/datum/supply_pack/medical/arm_implants
	name = "Strong-Arm Implant Set"
	desc = "A crate containing two implants, which can be surgically implanted to empower the strength of human arms. Warranty void if exposed to electromagnetic pulses."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/organ/internal/cyberimp/arm/muscle = 2)
	crate_name = "Strong-Arm implant crate"

/datum/supply_pack/medical/maintpills
	name = "Forgotten Prescriptions Pack"
	desc = "We found some old pills in the back of the warehouse, yours for a price."
	cost = CARGO_CRATE_VALUE * 20
	contraband = TRUE
	contains = list(/obj/item/reagent_containers/pill/maintenance = 10)
	crate_name = "experimental medicine crate"
