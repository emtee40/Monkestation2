/obj/item/clothing/under/costume
	worn_icon_digitigrade = 'monkestation/code/modules/blueshift/icons/mob/clothing/under/costume_digi.dmi'

/obj/item/clothing/under/costume/russian_officer
	worn_icon_digitigrade = 'monkestation/code/modules/blueshift/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/costume/nova
	icon = 'monkestation/code/modules/blueshift/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'monkestation/code/modules/blueshift/icons/mob/clothing/under/costume.dmi'
	can_adjust = FALSE

//My least favorite file. Just... try to keep it sorted. And nothing over the top

/*
*	UNSORTED
*/
/obj/item/clothing/under/costume/nova/cavalry
	name = "cavalry uniform"
	desc = "Dedicate yourself to something better. To loyalty, honour, for it only dies when everyone abandons it."
	icon_state = "cavalry" //specifically an 1890s US Army Cavalry Uniform

/obj/item/clothing/under/costume/deckers/alt //not even going to bother re-pathing this one because its such a unique case of 'TGs item has something but this alt doesnt'
	name = "deckers maskless outfit"
	desc = "A decker jumpsuit with neon blue coloring."
	icon = 'monkestation/code/modules/blueshift/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'monkestation/code/modules/blueshift/icons/mob/clothing/under/costume.dmi'
	worn_icon_digitigrade = 'monkestation/code/modules/blueshift/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "decking_jumpsuit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/nova/bathrobe
	name = "bathrobe"
	desc = "A warm fluffy bathrobe, perfect for relaxing after finally getting clean."
	icon = 'monkestation/code/modules/blueshift/gags/icons/suit/suit.dmi'
	worn_icon = 'monkestation/code/modules/blueshift/gags/icons/suit/suit.dmi'
	icon_state = "robes"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/bathrobe
	greyscale_config_worn = /datum/greyscale_config/bathrobe/worn
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#434d7a" //THATS RIGHT, FUCK YOU! THE BATHROBE CAN BE RECOLORED!
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	LUNAR AND JAPANESE CLOTHES
*/

/obj/item/clothing/under/costume/nova/qipao
	name = "qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years."
	icon_state = "qipao"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/qipao
	greyscale_config_worn = /datum/greyscale_config/qipao/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/qipao/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/costume/nova/qipao/customtrim
	greyscale_colors = "#2b2b2b#ffce5b"
	greyscale_config = /datum/greyscale_config/qipao_customtrim
	greyscale_config_worn = /datum/greyscale_config/qipao_customtrim/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/qipao_customtrim/worn/digi

/obj/item/clothing/under/costume/nova/cheongsam
	name = "cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years."
	icon_state = "cheongsam"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b#353535"
	greyscale_config = /datum/greyscale_config/cheongsam
	greyscale_config_worn = /datum/greyscale_config/cheongsam/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/cheongsam/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/costume/nova/cheongsam/customtrim
	greyscale_colors = "#2b2b2b#ffce5b#353535"
	greyscale_config = /datum/greyscale_config/cheongsam_customtrim
	greyscale_config_worn = /datum/greyscale_config/cheongsam_customtrim/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/cheongsam_customtrim/worn/digi

/obj/item/clothing/under/costume/nova/yukata
	name = "yukata"
	desc = "A traditional ancient Earth Japanese yukata, typically worn in casual settings."
	icon_state = "yukata"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b#666666"
	greyscale_config = /datum/greyscale_config/yukata
	greyscale_config_worn = /datum/greyscale_config/yukata/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/yukata/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/costume/nova/kamishimo
	name = "kamishimo"
	desc = "A traditional ancient Earth Japanese Kamishimo."
	icon_state = "kamishimo"

/obj/item/clothing/under/costume/nova/kimono
	name = "fancy kimono"
	desc = "A traditional ancient Earth Japanese Kimono. Longer and fancier than a yukata."
	icon_state = "kimono"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*	CHRISTMAS CLOTHES
*/

/obj/item/clothing/under/costume/nova/christmas
	name = "christmas costume"
	desc = "Can you believe it guys? Christmas. Just a lightyear away!" //Lightyear is a measure of distance I hate it being used for this joke :(
	icon_state = "christmas_male"
	greyscale_colors = "#cc0f0f#c4c2c2"
	greyscale_config = /datum/greyscale_config/chrimbo
	greyscale_config_worn = /datum/greyscale_config/chrimbo/worn
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/chrimbo/worn/digi
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/nova/christmas/green
	name = "green christmas costume"
	desc = "4:00, wallow in self-pity. 4:30, stare into the abyss. 5:00, solve world hunger, tell no one. 5:30, jazzercize; 6:30, dinner with me. I can't cancel that again. 7:00, wrestle with my self-loathing. I'm booked. Of course, if I bump the loathing to 9, I could still be done in time to lay in bed, stare at the ceiling and slip slowly into madness."
	greyscale_colors = "#1a991a#c4c2c2"
/*
*	TREK CLOTHES
*/
/obj/item/clothing/under/trek/command
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/trek/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/trek/engsec
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/trek/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/trek/medsci
	greyscale_config_worn_digitigrade =  /datum/greyscale_config/trek/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

//Cyberpunk PI Costume - Sprites from Eris, slightly modified
/obj/item/clothing/under/costume/cybersleek
	name = "sleek modern coat"
	desc = "A modern-styled coat typically worn on more urban planets, made with a neo-laminated fiber lining."
	icon = 'monkestation/code/modules/blueshift/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'monkestation/code/modules/blueshift/icons/mob/clothing/uniform.dmi'
	icon_state = "cyberpunksleek"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	supports_variations_flags = NONE
	can_adjust = FALSE

/obj/item/clothing/under/costume/cybersleek/long
	name = "long modern coat"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	icon_state = "cyberpunksleek_long"

/obj/item/clothing/suit/costume/wellworn_shirt
	name = "well-worn shirt"
	desc = "A worn out, curiously comfortable t-shirt. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	icon_state = "wellworn_shirt"
	inhand_icon_state = null
	greyscale_config = /datum/greyscale_config/wellworn_shirt
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt/worn
	greyscale_colors = COLOR_WHITE
	species_exception = list(/datum/species/golem)
	flags_1 = IS_PLAYER_COLORABLE_1
	///How many times has this shirt been washed? (In an ideal world this is just the determinant of the transform matrix.)
	var/wash_count = 0

/obj/item/clothing/suit/costume/wellworn_shirt/machine_wash(obj/machinery/washing_machine/washer)
	. = ..()
	if(wash_count <= 5)
		transform *= TRANSFORM_USING_VARIABLE(0.8, 1)
		washer.visible_message("[src] appears to have shrunken after being washed.")
		wash_count += 1
	else
		washer.visible_message("[src] implodes due to repeated washing.")
		qdel(src)

/obj/item/clothing/suit/costume/wellworn_shirt/skub
	name = "pro-skub shirt"
	desc = "A worn out, curiously comfortable t-shirt proclaiming your pro-skub stance. Fuck those anti-skubbies."
	icon_state = "wellworn_shirt_pro_skub"
	greyscale_colors = "#FFFF4D"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_skub
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_skub/worn

/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti
	name = "anti-skub shirt"
	desc = "A worn out, curiously comfortable t-shirt proclaiming your anti-skub stance. Fuck those pro-skubbies."
	icon_state = "wellworn_shirt_anti_skub"

/obj/item/clothing/suit/costume/wellworn_shirt/graphic
	name = "well-worn graphic shirt"
	desc = "A worn out, curiously comfortable t-shirt with a character from Phanic the Weasel on the front. It adds some charm points to itself and the wearer, and reminds you of when the series was still good; way back in 2500."
	icon_state = "wellworn_shirt_gamer"
	greyscale_colors = "#FFFFFF#46B45B"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian
	name = "well-worn ian shirt"
	desc = "A worn out, curiously comfortable t-shirt with a picture of Ian the Corgi. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	icon_state = "wellworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout
	name = "worn-out shirt"
	desc = "A pretty grubby, yet still comfortable t-shirt. You've been sleeping in this one for a bit too long."
	icon_state = "wornout_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic
	name = "worn-out graphic shirt"
	desc = "A pretty grubby, yet still comfortable t-shirt with a character from Phanic the Weasel on the front. The slightly raggedy nature recalls that one horrid title where they made him a vampire. You should get cheevos for sleeping in it this many days straight."
	icon_state = "wornout_shirt_gamer"
	greyscale_colors = "#FFFFFF#46B45B"
	greyscale_config = /datum/greyscale_config/wornout_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wornout_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian
	name = "worn-out ian shirt"
	desc = "A pretty grubby, yet still comfortable t-shirt with a picture of Ian the Corgi. It's gone past 'a bit worn' to 'well-loved;' excellent for use as pajamas."
	icon_state = "wornout_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy
	name = "messy worn-out shirt"
	desc = "This worn-out, somehow comfortable t-shirt has reached a more thorough understanding of grime; maybe the fact that it's still gone unwashed could function as a sort of camo?"
	icon_state = "messyworn_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic
	name = "messy graphic shirt"
	desc = "This worn-out, somehow comfortable t-shirt has reached a more thorough understanding of grime. Normies will never understand that this is a collector's item, and your sense of fashion absolutely mogs theirs. Phanic Phorever."
	icon_state = "messyworn_shirt_gamer"
	greyscale_colors = "#FFFFFF#46B45B"
	greyscale_config = /datum/greyscale_config/messyworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/messyworn_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian
	name = "messy ian shirt"
	desc = "This worn-out, somehow comfortable t-shirt has reached a more thorough understanding of grime. You get the feeling like you understand how it's like to be a stray dog, yet Ian's face still comforts you."
	icon_state = "messyworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/gamer
	name = "gamer shirt"
	desc = "A baggy, extremely well-used shirt with vintage game character Phanic the Weasel far-too-boldly displayed on the chest. Your mind cannot hope to withstand the assault of remembering the Phanic Phanart you've seen; let alone the stench of this top."
	icon_state = "messyworn_shirt_gamer"
	greyscale_colors = "#FFFFFF#46B45B"
