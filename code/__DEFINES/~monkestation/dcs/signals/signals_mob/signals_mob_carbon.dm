#define COMSIG_CARBON_EQUIP_EARS "carbon_ears_equip"
#define COMSIG_CARBON_UNEQUIP_EARS "carbon_ears_unequip"

#define COMSIG_HUMAN_BEGIN_DUEL "human_begin_duel"
#define COMSIG_HUMAN_END_DUEL "human_end_duel"

///from /datum/wound/proc/apply_wound() (/mob/living/carbon/wounded_mob, /datum/wound/applied_wound, /obj/item/bodypart/wounded_bodypart, smited)
#define COMSIG_PRE_CARBON_GAIN_WOUND "pre_carbon_gain_wound"
	#define COMPONENT_STOP_WOUND (1<<0)
///from /datum/wound/proc/apply_wound() (/mob/living/carbon/wounded_mob, /datum/wound/applied_wound, /obj/item/bodypart/wounded_bodypart)
#define COMSIG_CANCEL_CARBON_GAIN_WOUND "cancel_carbon_gain_wound"
