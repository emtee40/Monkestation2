/obj/structure/chemical_tank/factory
	name = "remote factory output"
	desc = "Produces patchs, pills or bottles on demand."
	icon = 'icons/obj/plumbing/plumbers.dmi'
	icon_state = "bottler"
	component_name = "Factory Output"

	reagent_flags =  TRANSPARENT

	///current operating product (pills or patches)
	var/product = "pill"
	///the minimum size a pill or patch can be
	var/min_volume = 5
	///the maximum size a pill or patch can be
	var/max_volume = 50
	///selected size of the product
	var/current_volume = 10
	///prefix for the product name
	var/product_name = "factory"
	///the icon_state number for the pill.
	// var/pill_number = RANDOM_PILL_STYLE
	///list of id's and icons for the pill selection of the ui
	var/pill_style = "pill0"
	/// Currently selected patch style
	var/patch_style = DEFAULT_PATCH_STYLE
	/// All packaging types wrapped up in 1 big list
	var/static/list/packaging_types = null
	///The type of packaging to use
	var/packaging_type
	///Category of packaging
	var/packaging_category

/obj/structure/chemical_tank/factory/Initialize(mapload, bolt, layer)
	. = ..()

	if(!packaging_types)
		var/datum/asset/spritesheet/simple/assets = get_asset_datum(/datum/asset/spritesheet/chemmaster)

		var/list/types = list(
			CAT_PILLS = GLOB.reagent_containers[CAT_PILLS],
			CAT_PATCHES = GLOB.reagent_containers[CAT_PATCHES],
			"Bottles" = list(/obj/item/reagent_containers/cup/bottle),
		)

		packaging_types = list()
		for(var/category in types)
			var/list/packages = types[category]

			var/list/category_item = list("cat_name" = category)
			for(var/obj/item/reagent_containers/container as anything in packages)
				var/list/package_item = list(
					"class_name" = assets.icon_class_name(sanitize_css_class_name("[container]")),
					"ref" = REF(container)
				)
				category_item["products"] += list(package_item)

			packaging_types += list(category_item)

	packaging_type = REF(GLOB.reagent_containers[CAT_PILLS][1])
	decode_category()

/// decode product category from it's type path and returns the decoded typepath
/obj/structure/chemical_tank/factory/proc/decode_category()
	var/obj/item/reagent_containers/container = locate(packaging_type)
	if(ispath(container, /obj/item/reagent_containers/pill/patch))
		packaging_category = CAT_PATCHES
	else if(ispath(container, /obj/item/reagent_containers/pill))
		packaging_category = CAT_PILLS
	else
		packaging_category = "Bottles"
	return container

/* /obj/structure/chemical_tank/factory/proc/load_styles()
	//expertly copypasted from chemmasters
	var/datum/asset/spritesheet/simple/assets = get_asset_datum(/datum/asset/spritesheet/simple/pills)
	pill_styles = list()
	for (var/x in 1 to PILL_STYLE_COUNT)
		var/list/SL = list()
		SL["id"] = x
		SL["class_name"] = assets.icon_class_name("pill[x]")
		pill_styles += list(SL)
	var/datum/asset/spritesheet/simple/patches_assets = get_asset_datum(/datum/asset/spritesheet/simple/patches)
	patch_styles = list()
	for (var/raw_patch_style in PATCH_STYLE_LIST)
		//adding class_name for use in UI
		var/list/patch_style = list()
		patch_style["style"] = raw_patch_style
		patch_style["class_name"] = patches_assets.icon_class_name(raw_patch_style)
		patch_styles += list(patch_style) */

/obj/structure/chemical_tank/factory/proc/generate_product(mob/user)
	if(reagents.total_volume < current_volume)
		return
	if (product == "pill")
		var/obj/item/reagent_containers/pill/P = new(get_turf(src))
		reagents.trans_to(P, current_volume)
		P.name = trim("[product_name] pill")
		user.put_in_hands(P)
		P.icon_state = pill_style
		if(P.icon_state == "pill4") //mirrored from chem masters
			P.desc = "A tablet or capsule, but not just any, a red one, one taken by the ones not scared of knowledge, freedom, uncertainty and the brutal truths of reality."
	else if (product == "patch")
		var/obj/item/reagent_containers/pill/patch/P = new(get_turf(src))
		reagents.trans_to(P, current_volume)
		P.name = trim("[product_name] patch")
		P.icon_state = patch_style
		user.put_in_hands(P)
	else if (product == "bottle")
		var/obj/item/reagent_containers/cup/bottle/P = new(get_turf(src))
		reagents.trans_to(P, current_volume)
		P.name = trim("[product_name] bottle")
		user.put_in_hands(P)

/obj/structure/chemical_tank/factory/AltClick(mob/user)
	. = ..()
	var/choice_product = tgui_input_list(user, "Pick Product", "[name]", list("pill", "patch", "bottle"))
	if(choice_product)
		product = choice_product
		switch(choice_product)
			if("pill")
				var/obj/item/reagent_containers/pill/style/P = pick(GLOB.reagent_containers[CAT_PILLS])
				pill_style = P.icon_state
			if("patch")
				var/obj/item/reagent_containers/pill/patch/style/P = pick(GLOB.reagent_containers[CAT_PATCHES])
				patch_style = P.icon_state

	var/choice_name = tgui_input_text(user, "Pick Product Name", "[name]")
	if(choice_name)
		product_name = choice_name

	var/choice_volume = tgui_input_number(user, "Choose a product volume", "[name]", current_volume, max_volume, min_volume)
	if(choice_volume)
		current_volume = choice_volume

/obj/structure/chemical_tank/factory/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	generate_product(user)
