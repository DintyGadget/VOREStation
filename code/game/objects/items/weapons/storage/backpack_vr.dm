/obj/item/weapon/storage/backpack/saddlebag
	name = "Лошадиные седельные сумки"
	desc = "Седло, на котором можно хранить вещи. Довольно крупное."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "saddlebag"
	icon_state = "saddlebag"
	max_storage_space = INVENTORY_DUFFLEBAG_SPACE //Saddlebags can hold more, like dufflebags
	slowdown = 1 //And are slower, too...Unless you're a macro, that is.
	var/taurtype = /datum/sprite_accessory/tail/taur/horse //Acceptable taur type to be wearing this
	var/no_message = "Ваша форма тела не соответствует этому седлу!"

	mob_can_equip(var/mob/living/carbon/human/H, slot, disable_warning = 0)
		if(..())
			if(istype(H) && istype(H.tail_style, taurtype))
				return 1
			else
				to_chat(H, "<span class='warning'>[no_message]</span>")
				return 0

/* If anyone wants to make some... this is how you would.
/obj/item/weapon/storage/backpack/saddlebag/spider
	name = "Drider Saddlebags"
	item_state = "saddlebag_drider"
	icon_state = "saddlebag_drider"
	var/taurtype = /datum/sprite_accessory/tail/taur/spider
*/

/obj/item/weapon/storage/backpack/saddlebag_common //Shared bag for other taurs with sturdy backs
	name = "Тавровые седельные сумки"
	desc = "Седло, на котором можно хранить вещи. Довольно крупное."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "saddlebag"
	icon_state = "saddlebag"
	var/icon_base = "saddlebag"
	max_storage_space = INVENTORY_DUFFLEBAG_SPACE //Saddlebags can hold more, like dufflebags
	slowdown = 1 //And are slower, too...Unless you're a macro, that is.
	var/no_message = "Ваша форма тела не соответствует этому седлу!"

	mob_can_equip(var/mob/living/carbon/human/H, slot, disable_warning = 0)
		if(..())
			if(!istype(H))//Error, non HUMAN.
				log_runtime("[H] не является подходящим человеком!")
				return

			if(H.size_multiplier >= RESIZE_BIG) //Are they a macro? If yes, they get no slowdown.
				slowdown = 0
			else
				slowdown = initial(slowdown)

			var/datum/sprite_accessory/tail/taur/TT = H.tail_style
			item_state = "[icon_base]_[TT.icon_sprite_tag]"	//icon_sprite_tag is something like "deer"
			return 1



/obj/item/weapon/storage/backpack/saddlebag_common/robust //Shared bag for other taurs with sturdy backs
	name = "Надёжные седельные сумки"
	desc = "Седло, на котором можно хранить вещи. Довольно надёжное."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "robustsaddle"
	icon_state = "robustsaddle"
	icon_base = "robustsaddle"

/obj/item/weapon/storage/backpack/saddlebag_common/vest //Shared bag for other taurs with sturdy backs
	name = "Тавровый боевой жилет"
	desc = "Бронежилет, модули брони в котором были убраны в пользу ячеек для хранения некоторого количества предметов. Не предоставляет защиту. Вмещает меньше лошадиного седла."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "taurvest"
	icon_state = "taurvest"
	icon_base = "taurvest"
	max_storage_space = INVENTORY_STANDARD_SPACE
	slowdown = 0

/obj/item/weapon/storage/backpack/dufflebag/fluff //Black dufflebag without syndie buffs.
	name = "Простой чёрный вещмешок"
	desc = "Крупный вещмешок для переноски дополнительных тактических припасов."
	icon_state = "duffle_syndie"

/obj/item/weapon/storage/backpack
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/mob/species/seromi/back.dmi',
		SPECIES_WEREBEAST = 'icons/mob/species/werebeast/back.dmi')

/obj/item/weapon/storage/backpack/ert
	max_storage_space = INVENTORY_DUFFLEBAG_SPACE

/obj/item/weapon/storage/backpack/satchel/explorer
	name = "Сумка искателя"
	desc = "Сумка для удобного хранения множества припасов."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "satchel-explorer"
	icon_state = "satchel-explorer"

/obj/item/weapon/storage/backpack/explorer
	name = "Рюкзак искателя"
	desc = "Рюкзак для удобного хранения множества припасов."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "explorerpack"
	icon_state = "explorerpack"

/obj/item/weapon/storage/backpack/satchel/roboticist
	name = "Сумка робототехника"
	desc = "Сумка для удобного хранения множества запчастей."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "satchel-robo"
	icon_state = "satchel-robo"

/obj/item/weapon/storage/backpack/roboticist
	name = "Рюкзак робототехника"
	desc = "Рюкзак для удобного хранения множества запчастей."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "backpack-robo"
	icon_state = "backpack-robo"

/obj/item/weapon/storage/backpack/vietnam
	name = "Вьетнамский рюкзак"
	desc = "От него веет флешбеками."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "nambackpack"
	icon_state = "nambackpack"

/obj/item/weapon/storage/backpack/russian
	name = "Русский рюкзак"
	desc = "Для удобной транспортировки водки в больших количествах."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "ru_rucksack"
	icon_state = "ru_rucksack"

/obj/item/weapon/storage/backpack/korean
	name = "Корейский рюкзак"
	desc = "Вставить сюда остроумное описание."
	icon = 'icons/obj/clothing/backpack_vr.dmi'
	icon_override = 'icons/mob/back_vr.dmi'
	item_state = "kr_rucksack"
	icon_state = "kr_rucksack"
