/// To store all the different cyborg models, instead of creating that for each cyborg.
GLOBAL_LIST_EMPTY(cyborg_model_list)
/// To store all of the different base cyborg model icons, instead of creating them every time the pick_module() proc is called.
GLOBAL_LIST_EMPTY(cyborg_base_models_icon_list)
/// To store all of the different cyborg model icons, instead of creating them every time the be_transformed_to() proc is called.
GLOBAL_LIST_EMPTY(cyborg_all_models_icon_list)

#define CYBORG_ICON_CARGO 'monkestation/code/modules/borgs/icons/robots_cargo.dmi'
#define CYBORG_ICON_MED 'monkestation/code/modules/borgs/icons/robots_med.dmi'
#define CYBORG_ICON_ENG 'monkestation/code/modules/borgs/icons/robots_eng.dmi'
#define CYBORG_ICON_SERVICE 'monkestation/code/modules/borgs/icons/robots_serv.dmi'
#define CYBORG_ICON_MINING 'monkestation/code/modules/borgs/icons/robots_mine.dmi'
#define CYBORG_ICON_JANI 'monkestation/code/modules/borgs/icons/robots_jani.dmi'
#define CYBORG_ICON_SYNDIE 'monkestation/code/modules/borgs/icons/robots_syndi.dmi'
#define CYBORG_ICON_PEACEKEEPER 'monkestation/code/modules/borgs/icons/robots_pk.dmi'

/// Module is compatible with Cargo Cyborg model
#define BORG_MODEL_CARGO (BORG_MODEL_ENGINEERING<<1)
#define RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO "/Cargo Cyborgs"
