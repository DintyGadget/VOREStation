//
// Collars and such like that
//

/obj/item/clothing/accessory/choker //A colorable, tagless choker
	name = "чокер"
	slot_flags = SLOT_TIE | SLOT_OCLOTHING
	desc = "Простой, незамысловатый чокер. А может, это ошейник? Используйте в руке, чтобы настроить его."
	icon = 'icons/obj/clothing/ties_vr.dmi'
	icon_override = 'icons/mob/ties_vr.dmi'
	icon_state = "choker_cst"
	item_state = "choker_cst"
	overlay_state = "choker_cst"
	var/customized = 0
	var/icon_previous_override
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/mob/species/teshari/ties_vr.dmi'
		)

//Forces different sprite sheet on equip
/obj/item/clothing/accessory/choker/New()
	..()
	icon_previous_override = icon_override

/obj/item/clothing/accessory/choker/equipped() //Solution for race-specific sprites for an accessory which is also a suit. Suit icons break if you don't use icon override which then also overrides race-specific sprites.
	..()
	setUniqueSpeciesSprite()

/obj/item/clothing/accessory/choker/proc/setUniqueSpeciesSprite()
	var/mob/living/carbon/human/H = loc
	if(!istype(H) && istype(has_suit) && ishuman(has_suit.loc))
		H = has_suit.loc
	if(sprite_sheets && istype(H) && H.species.get_bodytype(H) && (H.species.get_bodytype(H) in sprite_sheets))
		icon_override = sprite_sheets[H.species.get_bodytype(H)]
		update_clothing_icon()

/obj/item/clothing/accessory/choker/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(!istype(S))
		return
	has_suit = S
	setUniqueSpeciesSprite()
	..(S, user)

/obj/item/clothing/accessory/choker/dropped()
	icon_override = icon_previous_override

/obj/item/clothing/accessory/choker/attack_self(mob/user as mob)
	if(!customized)
		var/design = input(user,"Вид?","Выберите вид:","") in list("обычный","простой","украшенный","элегантный","роскошный")
		var/material = input(user,"Материал?","Выберите материал:","") in list("кожаный","бархатный","кружевной","тканый","латексный","пластиковый","металлический","цепной","серебряный","золотой","платиновый","стальной","бусинный","рубиновый","сапфировый","изумрудный","бриллиантовый")
		var/type = input(user,"Тип?","Выберите тип:","") in list("чокер","ошейник")
		name = "[design] [material] [type]"
		desc = "Это [material] [type]. На вид вполне [design]."
		customized = 1
		to_chat(usr,"<span class='notice'>Вы видоизменили [ru_getcase(src, "acase")].</span>")
	else
		to_chat(usr,"<span class='notice'>Вы уже видоизменzли [ru_getcase(src, "acase")]!</span>")

/obj/item/clothing/accessory/collar
	slot_flags = SLOT_TIE | SLOT_OCLOTHING
	icon = 'icons/obj/clothing/ties_vr.dmi'
	icon_override = 'icons/mob/ties_vr.dmi'
	icon_state = "collar_blk"
	var/writtenon = 0
	var/icon_previous_override
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/mob/species/teshari/ties_vr.dmi'
		)

//Forces different sprite sheet on equip
/obj/item/clothing/accessory/collar/New()
	..()
	icon_previous_override = icon_override

/obj/item/clothing/accessory/collar/equipped() //Solution for race-specific sprites for an accessory which is also a suit. Suit icons break if you don't use icon override which then also overrides race-specific sprites.
	..()
	setUniqueSpeciesSprite()

/obj/item/clothing/accessory/collar/proc/setUniqueSpeciesSprite()
	var/mob/living/carbon/human/H = loc
	if(!istype(H) && istype(has_suit) && ishuman(has_suit.loc))
		H = has_suit.loc
	if(sprite_sheets && istype(H) && H.species.get_bodytype(H) && (H.species.get_bodytype(H) in sprite_sheets))
		icon_override = sprite_sheets[H.species.get_bodytype(H)]
		update_clothing_icon()

/obj/item/clothing/accessory/collar/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(!istype(S))
		return
	has_suit = S
	setUniqueSpeciesSprite()
	..(S, user)

/obj/item/clothing/accessory/collar/dropped()
	icon_override = icon_previous_override

/obj/item/clothing/accessory/collar/silver
	name = "Серебряный ошейник с биркой"
	desc = "Ошейник для ваших маленьких питомцев... или больших."
	icon_state = "collar_blk"
	item_state = "collar_blk"
	overlay_state = "collar_blk"

/obj/item/clothing/accessory/collar/gold
	name = "Золотой ошейник с биркой"
	desc = "Ошейник для ваших маленьких питомцев... или больших."
	icon_state = "collar_gld"
	item_state = "collar_gld"
	overlay_state = "collar_gld"

/obj/item/clothing/accessory/collar/bell
	name = "Ошейник с колокольчиком"
	desc = "Ошейник с прицепленным колокольчиком."
	icon_state = "collar_bell"
	item_state = "collar_bell"
	overlay_state = "collar_bell"
	var/jingled = 0

/obj/item/clothing/accessory/collar/bell/verb/jinglebell()
	set name = "Позвонить В Колокольчик"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat) return

	if(!jingled)
		usr.audible_message("[usr] звонит в колокольчик [ru_getcase(src, "gcase")].")
		playsound(src, 'sound/items/pickup/ring.ogg', 50, 1)
		jingled = 1
		addtimer(CALLBACK(src, .proc/jingledreset), 50)
	return

/obj/item/clothing/accessory/collar/bell/proc/jingledreset()
		jingled = 0

/obj/item/clothing/accessory/collar/shock
	name = "Электрический ошейник"
	desc = "Ошейник, используемый для усмирения голодных хищников."
	icon_state = "collar_shk0"
	item_state = "collar_shk"
	overlay_state = "collar_shk"
	var/on = FALSE // 0 for off, 1 for on, starts off to encourage people to set non-default frequencies and codes.
	var/frequency = 1449
	var/code = 2
	var/datum/radio_frequency/radio_connection

/obj/item/clothing/accessory/collar/shock/Initialize()
	. = ..()
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CHAT) // Makes it so you don't need to change the frequency off of default for it to work.

/obj/item/clothing/accessory/collar/shock/Destroy() //Clean up your toys when you're done.
	radio_controller.remove_object(src, frequency)
	radio_connection = null //Don't delete this, this is a shared object.
	return ..()

/obj/item/clothing/accessory/collar/shock/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CHAT)

/obj/item/clothing/accessory/collar/shock/Topic(href, href_list)
	if(usr.stat || usr.restrained())
		return
	if(((istype(usr, /mob/living/carbon/human) && ((!( ticker ) || (ticker && ticker.mode != "monkey")) && usr.contents.Find(src))) || (usr.contents.Find(master) || (in_range(src, usr) && istype(loc, /turf)))))
		usr.set_machine(src)
		if(href_list["freq"])
			var/new_frequency = sanitize_frequency(frequency + text2num(href_list["freq"]))
			set_frequency(new_frequency)
		if(href_list["tag"])
			var/str = copytext_char(reject_bad_text(input(usr,"Текст на бирке?","Введите текст бирки","")),1,MAX_NAME_LEN)
			if(!str || !length(str))
				to_chat(usr,"<span class='notice'>Установлен пустой текст на бирке.</span>")
				name = initial(name)
				desc = initial(desc)
			else
				to_chat(usr,"<span class='notice'>Вы написали на бирке ошейника '[str]'.</span>")
				name = initial(name) + " ([str])"
				desc = initial(desc) + " На бирке написано: \"[str]\"."
		else
			if(href_list["code"])
				code += text2num(href_list["code"])
				code = round(code)
				code = min(100, code)
				code = max(1, code)
			else
				if(href_list["power"])
					on = !( on )
					icon_state = "collar_shk[on]" // And apparently this works, too?!
		if(!( master ))
			if(istype(loc, /mob))
				attack_self(loc)
			else
				for(var/mob/M in viewers(1, src))
					if(M.client)
						attack_self(M)
		else
			if(istype(master.loc, /mob))
				attack_self(master.loc)
			else
				for(var/mob/M in viewers(1, master))
					if(M.client)
						attack_self(M)
	else
		usr << browse(null, "window=radio")
		return
	return

/obj/item/clothing/accessory/collar/shock/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption != code)
		return

	if(on)
		var/mob/M = null
		if(ismob(loc))
			M = loc
		if(ismob(loc.loc))
			M = loc.loc // This is about as terse as I can make my solution to the whole 'collar won't work when attached as accessory' thing.
		to_chat(M,"<span class='danger'>Вы чувствуете острый удар током!</span>")
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(3, 1, M)
		s.start()
		M.Weaken(10)
	return

/obj/item/clothing/accessory/collar/shock/attack_self(mob/user as mob, flag1)
	if(!istype(user, /mob/living/carbon/human))
		return
	user.set_machine(src)
	var/dat = {"<TT><meta charset=\"utf-8\">
			<A href='?src=\ref[src];power=1'>[on ? "Выключить" : "Включить"]</A><BR>
			<B>Код частоты</B> для ошейника:<BR>
			Частота:
			<A href='byond://?src=\ref[src];freq=-10'>-</A>
			<A href='byond://?src=\ref[src];freq=-2'>-</A> [format_frequency(frequency)]
			<A href='byond://?src=\ref[src];freq=2'>+</A>
			<A href='byond://?src=\ref[src];freq=10'>+</A><BR>

			Код:
			<A href='byond://?src=\ref[src];code=-5'>-</A>
			<A href='byond://?src=\ref[src];code=-1'>-</A> [code]
			<A href='byond://?src=\ref[src];code=1'>+</A>
			<A href='byond://?src=\ref[src];code=5'>+</A><BR>

			Бирка:
			<A href='?src=\ref[src];tag=1'>Установить текст</A><BR>
			</TT>"}
	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/clothing/accessory/collar/spike
	name = "Шипованный ошейник"
	desc = "Ошейник с шипами. Острые, как и клыки хищника."
	icon_state = "collar_spik"
	item_state = "collar_spik"
	overlay_state = "collar_spik"

/obj/item/clothing/accessory/collar/pink
	name = "Розовый ошейник"
	desc = "Придаёт Вашим питомцам определенный шарм."
	icon_state = "collar_pnk"
	item_state = "collar_pnk"
	overlay_state = "collar_pnk"

/obj/item/clothing/accessory/collar/holo
	name = "Голо-ошейник"
	desc = "Дорогой голо-ошейник для современного питомца."
	icon_state = "collar_holo"
	item_state = "collar_holo"
	overlay_state = "collar_holo"
	matter = list(DEFAULT_WALL_MATERIAL = 50)

/obj/item/clothing/accessory/collar/holo/indigestible
	desc = "Особая разновидность голо-ошейника, изготовленная сделан из очень прочной на вид ткани."
//Make indigestible
/obj/item/clothing/accessory/collar/holo/indigestible/digest_act(var/atom/movable/item_storage = null)
	return FALSE

/obj/item/clothing/accessory/collar/attack_self(mob/user as mob)
	if(istype(src,/obj/item/clothing/accessory/collar/holo))
		to_chat(user,"<span class='notice'>Интерфейс [ru_getcase(src,"gcase")] проецируется Вам на руку.</span>")
	else
		if(writtenon)
			to_chat(user,"<span class='notice'>Чтобы изменить текст на бирке, необходима отвертка или ручка.</span>")
			return
		to_chat(user,"<span class='notice'>Вы редактируете бирку на ошейнике.</span>")

	var/str = copytext_char(reject_bad_text(input(user,"Текст на бирке?","Установите текст","")),1,MAX_NAME_LEN)

	if(!str || !length(str))
		to_chat(user,"<span class='notice'>Установлен пустой текст на бирке [ru_getcase(src,"gcase")].</span>")
		name = initial(name)
		desc = initial(desc)
	else
		to_chat(user,"<span class='notice'>Вы написали на бирке ошейника: '[str]'.</span>")
		initialize_tag(str)

/obj/item/clothing/accessory/collar/proc/initialize_tag(var/tag)
		name = initial(name) + " ([tag])"
		desc = initial(desc) + " На ошейнике написано: \"[tag]\""
		writtenon = 1

/obj/item/clothing/accessory/collar/holo/initialize_tag(var/tag)
		..()
		desc = initial(desc) + " На ошейнике написано: \"[tag]\"."

/obj/item/clothing/accessory/collar/attackby(obj/item/I, mob/user)
	if(istype(src,/obj/item/clothing/accessory/collar/holo))
		return

	if(istype(I,/obj/item/weapon/tool/screwdriver))
		update_collartag(user, I, "зацарапаны", "зацарапываете слова на ошейнике отверткой", "выгравированы слова:")
		return

	if(istype(I,/obj/item/weapon/pen))
		update_collartag(user, I, "перечеркнуты", "зачеркиваете слова на ошейнике ручкой", "записаны слова:")
		return

	to_chat(user,"<span class='notice'>Чтобы изменить текст на бирке, необходима отвертка или ручка.</span>")

/obj/item/clothing/accessory/collar/proc/update_collartag(mob/user, obj/item/I, var/erasemethod, var/erasing, var/writemethod)
	if(!(istype(user.get_active_hand(),I)) || !(istype(user.get_inactive_hand(),src)) || (user.stat))
		return

	var/str = copytext_char(reject_bad_text(input(user,"Tag text?","Set tag","")),1,MAX_NAME_LEN)

	if(!str || !length(str))
		if(!writtenon)
			to_chat(user,"<span class='notice'>Вы решили ничего не вписывать.</span>")
		else
			to_chat(user,"<span class='notice'>Вы [erasing].</span>")
			name = initial(name)
			desc = initial(desc) + " На бирке [erasemethod] слова."
	else
		if(!writtenon)
			to_chat(user,"<span class='notice'>Вы записываете на бирке: '[str]'.</span>")
			name = initial(name) + " ([str])"
			desc = initial(desc) + " На бирке [writemethod] \"[str]\"."
			writtenon = 1
		else
			to_chat(user,"<span class='notice'>Вы [erasing] и записываете '[str]'.</span>")
			name = initial(name) + " ([str])"
			desc = initial(desc) + " На бирке [erasemethod] слова, и поверх [writemethod] \"[str]\"."

//Machete Holsters
/obj/item/clothing/accessory/holster/machete
	name = "Ножны для мачете"
	desc = "Красивые ножны из искусственной кожи с соответствующим поясом."
	icon_state = "holster_machete"
	slot = ACCESSORY_SLOT_WEAPON
	concealed_holster = 0
	can_hold = list(/obj/item/weapon/material/knife/machete)
	//sound_in = 'sound/effects/holster/sheathin.ogg'
	//sound_out = 'sound/effects/holster/sheathout.ogg'

//Medals

/obj/item/clothing/accessory/medal/silver/unity
	name = "Медаль единства"
	desc = "Данная серебряная медаль присуждается группе, которая проявила исключительную командную работу в совершении выдающегося подвига."

/obj/item/clothing/accessory/medal/silver/unity/tabiranth
	icon = 'icons/obj/clothing/ties_vr.dmi'
	icon_override = 'icons/mob/ties_vr.dmi'
	icon_state = "silverthree"
	item_state = "silverthree"
	overlay_state = "silverthree"
	desc = "Данная серебряная медаль присуждается группе, которая проявила исключительную командную работу в совершении выдающегося подвига. На этой медали есть две бронзовые звездочки, означающие, что медаль была присуждена трижды."
