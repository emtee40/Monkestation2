/// If the given mob is a bloodling
#define IS_BLOODLING(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodling))

/// If the given mob is a bloodling thrall
#define IS_BLOODLING_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/changeling/bloodling_thrall))

/// If the given mob is a simplemob bloodling thrall
#define IS_SIMPLEMOB_BLOODLING_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/infested_thrall))

/// If the given mob is a bloodling thrall or bloodling
#define IS_BLOODLING_OR_THRALL(mob) (IS_BLOODLING(mob) || IS_BLOODLING_THRALL(mob) || IS_SIMPLEMOB_BLOODLING_THRALL(mob))

/// Antagonist panel groups
#define ANTAG_GROUP_BLOODLING "Bloodling"
