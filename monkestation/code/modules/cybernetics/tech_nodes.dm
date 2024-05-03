
/datum/techweb_node/ntlink_low
	id = "ntlink_low"
	display_name = "Cybernetic Application"
	description = "Creation of NT-secure basic cyberlinks for low-grade cybernetic augmentation"
	prereq_ids = list("adv_biotech","adv_biotech", "datatheory")
	design_ids = list("ci-nt_low")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

/datum/techweb_node/ntlink_high
	id = "ntlink_high"
	display_name = "Advanced Cybernetic Application"
	description = "Creation of NT-secure advanced cyberlinks for high-grade cybernetic augmentation"
	prereq_ids = list("ntlink_low", "adv_cyber_implants","high_efficiency")
	design_ids = list("ci-nt_high")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/job_approved_item_set
	id = "job_itemsets"
	name = "NT Approved Job Item Sets"
	description = "A list of approved item sets that can be implanted into the crew to allow easier access to their tools."
	prereq_ids = list("adv_biotech","adv_biotech", "datatheory")
	design_ids = list(
		"ci-set-cook",
		"ci-set-janitor",
		"ci-set-detective",
		"ci-set-chemical",
		"ci-set-atmospherics",
		"ci-set-connector",
		"ci-set-botany",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
