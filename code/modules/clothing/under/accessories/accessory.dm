/obj/item/clothing/accessory
	name = "Галстук"
	desc = "Галстук-клипса из неошёлка."
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "bluetie"
	item_state_slots = list(slot_r_hand_str = "", slot_l_hand_str = "")
	appearance_flags = RESET_COLOR	// Stops has_suit's color from being multiplied onto the accessory
	slot_flags = SLOT_TIE
	w_class = ITEMSIZE_SMALL
	var/slot = ACCESSORY_SLOT_DECOR
	var/obj/item/clothing/has_suit = null		// The suit the tie may be attached to
	var/image/inv_overlay = null				// Overlay used when attached to clothing.
	var/image/mob_overlay = null
	var/overlay_state = null
	var/concealed_holster = 0
	var/mob/living/carbon/human/wearer = null 	// To check if the wearer changes, so species spritesheets change properly.
	var/list/on_rolled = list()					// Used when jumpsuit sleevels are rolled ("rolled" entry) or it's rolled down ("down"). Set to "none" to hide in those states.
	sprite_sheets = list(SPECIES_TESHARI = 'icons/mob/species/teshari/ties.dmi') //Teshari can into webbing, too!
	drop_sound = 'sound/items/drop/accessory.ogg'
	pickup_sound = 'sound/items/pickup/accessory.ogg'

/obj/item/clothing/accessory/Destroy()
	on_removed()
	return ..()

/obj/item/clothing/accessory/proc/get_inv_overlay()
	if(!inv_overlay)
		var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
		if(icon_override)
			if("[tmp_icon_state]_tie" in cached_icon_states(icon_override))
				tmp_icon_state = "[tmp_icon_state]_tie"
			inv_overlay = image(icon = icon_override, icon_state = tmp_icon_state, dir = SOUTH)
		else
			inv_overlay = image(icon = INV_ACCESSORIES_DEF_ICON, icon_state = tmp_icon_state, dir = SOUTH)

		inv_overlay.color = src.color
		inv_overlay.appearance_flags = appearance_flags	// Stops has_suit's color from being multiplied onto the accessory
	return inv_overlay

/obj/item/clothing/accessory/proc/get_mob_overlay()
	if(!istype(loc,/obj/item/clothing/))	//don't need special handling if it's worn as normal item.
		return ..()
	var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
	if(ishuman(has_suit.loc))
		wearer = has_suit.loc
	else
		wearer = null

	if(istype(loc,/obj/item/clothing/under))
		var/obj/item/clothing/under/C = loc
		if(on_rolled["down"] && C.rolled_down > 0)
			tmp_icon_state = on_rolled["down"]
		else if(on_rolled["rolled"] && C.rolled_sleeves > 0)
			tmp_icon_state = on_rolled["rolled"]

	if(icon_override)
		if("[tmp_icon_state]_mob" in cached_icon_states(icon_override))
			tmp_icon_state = "[tmp_icon_state]_mob"
		mob_overlay = image("icon" = icon_override, "icon_state" = "[tmp_icon_state]")
	else if(wearer && sprite_sheets[wearer.species.get_bodytype(wearer)]) //Teshari can finally into webbing, too!
		mob_overlay = image("icon" = sprite_sheets[wearer.species.get_bodytype(wearer)], "icon_state" = "[tmp_icon_state]")
	else
		mob_overlay = image("icon" = INV_ACCESSORIES_DEF_ICON, "icon_state" = "[tmp_icon_state]")
	if(addblends)
		var/icon/base = new/icon("icon" = mob_overlay.icon, "icon_state" = mob_overlay.icon_state)
		var/addblend_icon = new/icon("icon" = mob_overlay.icon, "icon_state" = src.addblends)
		if(color)
			base.Blend(src.color, ICON_MULTIPLY)
		base.Blend(addblend_icon, ICON_ADD)
		mob_overlay = image(base)
	else
		mob_overlay.color = src.color

	mob_overlay.appearance_flags = appearance_flags	// Stops has_suit's color from being multiplied onto the accessory
	return mob_overlay

//when user attached an accessory to S
/obj/item/clothing/accessory/proc/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(!istype(S))
		return
	has_suit = S
	src.forceMove(S)
	has_suit.add_overlay(get_inv_overlay())

	if(user)
		to_chat(user, "<span class='notice'>Вы нацепляете [ru_getcase(src, "acase")] на [ru_getcase(has_suit, "acase")].</span>")
		add_fingerprint(user)

/obj/item/clothing/accessory/proc/on_removed(var/mob/user)
	if(!has_suit)
		return
	has_suit.cut_overlay(get_inv_overlay())
	has_suit = null
	if(user)
		usr.put_in_hands(src)
		add_fingerprint(user)
	else if(get_turf(src))		//We actually exist in space
		forceMove(get_turf(src))

//default attackby behaviour
/obj/item/clothing/accessory/attackby(obj/item/I, mob/user)
	..()

//default attack_hand behaviour
/obj/item/clothing/accessory/attack_hand(mob/user as mob)
	if(has_suit)
		return	//we aren't an object on the ground so don't call parent
	..()

/obj/item/clothing/accessory/tie
	name = "Cиний галстук"
	icon_state = "bluetie"
	slot = ACCESSORY_SLOT_TIE

/obj/item/clothing/accessory/tie/red
	name = "Красный галстук"
	icon_state = "redtie"

/obj/item/clothing/accessory/tie/blue_clip
	name = "Синий галстук с клипсой"
	icon_state = "bluecliptie"

/obj/item/clothing/accessory/tie/blue_long
	name = "Синий длинный галстук"
	icon_state = "bluelongtie"

/obj/item/clothing/accessory/tie/red_clip
	name = "Красный галстук с клипсой"
	icon_state = "redcliptie"

/obj/item/clothing/accessory/tie/red_long
	name = "Красный длинный галстук"
	icon_state = "redlongtie"

/obj/item/clothing/accessory/tie/black
	name = "Чёрный галстук"
	icon_state = "blacktie"

/obj/item/clothing/accessory/tie/darkgreen
	name = "Тёмно-зелёный галстук"
	icon_state = "dgreentie"

/obj/item/clothing/accessory/tie/yellow
	name = "Жёлтый галстук"
	icon_state = "yellowtie"

/obj/item/clothing/accessory/tie/navy
	name = "Тёмно-синий галстук"
	icon_state = "navytie"

/obj/item/clothing/accessory/tie/white
	name = "Белый галстук"
	icon_state = "whitetie"

/obj/item/clothing/accessory/tie/horrible
	name = "Убогий галстук"
	desc = "Галстук-клипса из неошёлка. Выглядит отвратительно."
	icon_state = "horribletie"

/obj/item/clothing/accessory/stethoscope
	name = "Стетоскоп"
	desc = "Устаревший медицинский аппарат для прослушивания звуков человеческого тела. А ещё в них Вы выглядите так, словно знаете что делаете."
	icon_state = "stethoscope"
	slot = ACCESSORY_SLOT_TIE

/obj/item/clothing/accessory/stethoscope/do_surgery(mob/living/carbon/human/M, mob/living/user)
	if(user.a_intent != I_HELP) //in case it is ever used as a surgery tool
		return ..()
	attack(M, user) //default surgery behaviour is just to scan as usual
	return 1

/obj/item/clothing/accessory/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == I_HELP)
			var/body_part = parse_zone(user.zone_sel.selecting)
			if(body_part)
				var/their = "их"
				switch(M.gender)
					if(MALE)	their = "его"
					if(FEMALE)	their = "её"

				var/sound = "сердцебиение"
				var/sound_strength = "не слышите"
				var/heartbeat = 0
				var/obj/item/organ/internal/heart/heart = M.internal_organs_by_name[O_HEART]
				if(heart && !(heart.robotic >= ORGAN_ROBOT))
					heartbeat = 1
				if(M.stat == DEAD || (M.status_flags&FAKEDEATH))
					sound_strength = "не слышите"
					sound = "ничего"
				else
					switch(body_part)
						if(BP_TORSO)
							sound_strength = "замечаете"
							sound = "отсутствие сердцебиения"
							if(heartbeat)
								if(heart.is_bruised() || M.getOxyLoss() > 50)
									sound = "[pick("необычные звуки в сердцебиении","слабое сердцебиение")]"
								else
									sound = "здоровое сердцебиение"

							var/obj/item/organ/internal/heart/L = M.internal_organs_by_name[O_LUNGS]
							if(!L || M.losebreath)
								sound += " и отсутствие дыхания"
							else if(M.is_lung_ruptured() || M.getOxyLoss() > 50)
								sound += " и звуки [pick("затрудненного дыхания","удушья")]"
							else
								sound += " и здоровое дыхание"
						if(O_EYES,O_MOUTH)
							sound_strength = "не слышите"
							sound = "ничего"
						else
							if(heartbeat)
								sound_strength = "слышите слабый"
								sound = "пульс"

				user.visible_message("[user] прикладывает [ru_getcase(src, "acase")] к  телу [M] ([body_part]) и внимательно слушает.", "Вы прикладываете [ru_getcase(src, "acase")] к [their] телу ([body_part]). Вы [sound_strength] [sound].")
				return
	return ..(M,user)

//Medals
/obj/item/clothing/accessory/medal
	name = "Бронзовая медаль"
	desc = "Бронзовая медаль."
	icon_state = "bronze"
	slot = ACCESSORY_SLOT_MEDAL
	drop_sound = 'sound/items/drop/accessory.ogg'
	pickup_sound = 'sound/items/pickup/accessory.ogg'

/obj/item/clothing/accessory/medal/conduct
	name = "Медаль за выдающиеся заслуги"
	desc = "Данная бронзовая медаль присуждается за выдающееся поведение. Хоть это и большая честь, это самая простейшая награда, которую мы можем предложить. Зачастую вручается капитаном."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "Бронзовое сердце"
	desc = "Бронзовая медаль в форме сердца, вручаемая за жертвоприношение. Она часто присуждается посмертно или за тяжелое увечье при исполнении служебных обязанностей."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/nobel_science
	name = "Нобелевская премия"
	desc = "Бронзовая медаль, которая представляет значительный вклад в области науки или техники."

/obj/item/clothing/accessory/medal/silver
	name = "Серебряная медаль"
	desc = "Серебряная медаль."
	icon_state = "silver"

/obj/item/clothing/accessory/medal/silver/valor
	name = "Медаль за отвагу"
	desc = "Серебряная медаль за особые подвиги."

/obj/item/clothing/accessory/medal/silver/security
	name = "Награда за поддержание порядка"
	desc = "Награда за выдающиеся боевые заслуги и самопожертвование в защите корпоративных коммерческих интересов. Часто присуждается сотрудникам службы безопасности."

/obj/item/clothing/accessory/medal/gold
	name = "Золотая медаль"
	desc = "Престижная золотая медаль."
	icon_state = "gold"

/obj/item/clothing/accessory/medal/gold/captain
	name = "Медаль капитанства"
	desc = "Данная золотая медаль присуждается исключительно тем, кто был повышен до должности Директора/Капитана. Она накладывает на носителя особую ответственность Директора/Капитана и дарует неоспоримую власть над экипажем."

/obj/item/clothing/accessory/medal/gold/heroism
	name = "Медаль за исключительный героизм"
	desc = "Чрезвычайно редкая золотая медаль, вручаемая только высокопоставленными чиновниками. Получить такую медаль - большая честь, и как следствие, она существует в очень малом количестве. Эта медаль почти никогда не вручается никому, кроме заслуженных ветеранов."

// Base type for 'medals' found in a "dungeon" submap, as a sort of trophy to celebrate the player's conquest.
/obj/item/clothing/accessory/medal/dungeon

/obj/item/clothing/accessory/medal/dungeon/alien_ufo
	name = "Медаль инопланетного капитана"
	desc = "Смутно напоминает звезду. Похожа на что-то, что носил бы капитан пришельцев. Наверное."
	icon_state = "alien_medal"

//Scarves

/obj/item/clothing/accessory/scarf
	name = "Зелёный шарф"
	desc = "Стильный шарф. Идеальный зимний аксессуар для тех, кто обладает острым чувством моды, и тех, кто просто не терпит холодок на шее."
	icon_state = "greenscarf"
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/scarf/red
	name = "Красный шарф"
	icon_state = "redscarf"

/obj/item/clothing/accessory/scarf/darkblue
	name = "Тёмно-синий шарф"
	icon_state = "darkbluescarf"

/obj/item/clothing/accessory/scarf/purple
	name = "Фиолетовый шарф"
	icon_state = "purplescarf"

/obj/item/clothing/accessory/scarf/yellow
	name = "Жёлтый шарф"
	icon_state = "yellowscarf"

/obj/item/clothing/accessory/scarf/orange
	name = "Оранжевый шарф"
	icon_state = "orangescarf"

/obj/item/clothing/accessory/scarf/lightblue
	name = "Голубой шарф"
	icon_state = "lightbluescarf"

/obj/item/clothing/accessory/scarf/white
	name = "Белый шарф"
	icon_state = "whitescarf"

/obj/item/clothing/accessory/scarf/black
	name = "Чёрный шарф"
	icon_state = "blackscarf"

/obj/item/clothing/accessory/scarf/zebra
	name = "Полосатый шарф"
	icon_state = "zebrascarf"

/obj/item/clothing/accessory/scarf/christmas
	name = "Рождественский шарф"
	icon_state = "christmasscarf"

/obj/item/clothing/accessory/scarf/stripedred
	name = "Красный полосатый шарф"
	icon_state = "stripedredscarf"

/obj/item/clothing/accessory/scarf/stripedgreen
	name = "Зелёный полосатый шарф"
	icon_state = "stripedgreenscarf"

/obj/item/clothing/accessory/scarf/stripedblue
	name = "Синий полосатый шарф"
	icon_state = "stripedbluescarf"

/obj/item/clothing/accessory/scarf/teshari/neckscarf
	name = "Шейный платочек"
	desc = "Шейный платок. Слишком мал для шеи человека."
	icon_state = "tesh_neckscarf"
	species_restricted = list(SPECIES_TESHARI)

//bracelets

/obj/item/clothing/accessory/bracelet
	name = "Браслет"
	desc = "Простой серебряный браслет с застежкой."
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "bracelet"
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/bracelet/friendship
	name = "Браслет дружбы"
	desc = "Красивый браслет дружбы всех цветов радуги."
	icon_state = "friendbracelet"

/obj/item/clothing/accessory/bracelet/friendship/verb/dedicate_bracelet()
	set name = "Посвятить Браслет"
	set category = "Объект"
	set desc = "Посвящает Ваш браслет дружбы особенному человеку."
	var/mob/M = usr
	if(!M.mind)
		return 0

	var/input = sanitizeSafe(input("Кому Вы хотите посвятить браслет?", ,""), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		desc = "Красивый браслет дружбы во всех цветах радуги. Он посвящен [input]."
		to_chat(M, "Вы посвящаете браслет [input], вспоминая времена, которые вы провели вместе.")
		return 1


/obj/item/clothing/accessory/bracelet/material
	icon_state = "materialbracelet"

/obj/item/clothing/accessory/bracelet/material/New(var/newloc, var/new_material)
	..(newloc)
	if(!new_material)
		new_material = DEFAULT_WALL_MATERIAL
	material = get_material_by_name(new_material)
	if(!istype(material))
		qdel(src)
		return
	//name = "браслет из [material.display_name]"
	//desc = "Браслет, сделанный из [material.display_name]."
	color = material.icon_colour

/obj/item/clothing/accessory/bracelet/material/get_material()
	return material

/obj/item/clothing/accessory/bracelet/material/wood/New(var/newloc)
	..(newloc, "wood")

/obj/item/clothing/accessory/bracelet/material/plastic/New(var/newloc)
	..(newloc, "plastic")

/obj/item/clothing/accessory/bracelet/material/iron/New(var/newloc)
	..(newloc, "iron")

/obj/item/clothing/accessory/bracelet/material/steel/New(var/newloc)
	..(newloc, "steel")

/obj/item/clothing/accessory/bracelet/material/silver/New(var/newloc)
	..(newloc, "silver")

/obj/item/clothing/accessory/bracelet/material/gold/New(var/newloc)
	..(newloc, "gold")

/obj/item/clothing/accessory/bracelet/material/platinum/New(var/newloc)
	..(newloc, "platinum")

/obj/item/clothing/accessory/bracelet/material/phoron/New(var/newloc)
	..(newloc, "phoron")

/obj/item/clothing/accessory/bracelet/material/glass/New(var/newloc)
	..(newloc, "glass")

	..()

/obj/item/clothing/accessory/halfcape
	name = "Накидка"
	desc = "Элегантный полуплащ, подходящий для европейских аристократов и главных героев ретро-аниме."
	icon_state = "halfcape"
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/fullcape
	name = "Полный плащ"
	desc = "Вызывающий плащ во всю длину. Так и хочется примерить, да?"
	icon_state = "fullcape"
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/sash
	name = "Кушак"
	desc = "Простой, ничем не украшенный пояс."
	icon_state = "sash"
	slot = ACCESSORY_SLOT_OVER