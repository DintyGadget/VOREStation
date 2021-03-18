
//Hat Station 13

/obj/item/clothing/head/collectable
	name = "Коллекционный головной убор"
	desc = "Редкий коллекционный головной убор."

/obj/item/clothing/head/collectable/petehat
	name = "Ультра редкий головной убор"
	desc = "Ультра редкий коллекционный головной убор. Вызывает уважение."
	icon_state = "petehat"
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/mob/species/seromi/head.dmi',
		SPECIES_VOX = 'icons/mob/species/vox/head.dmi'
		)

/obj/item/clothing/head/collectable/slime
	name = "Коллекционная шляпа-слизень"
	desc = "Так хорошо прям садится!"
	icon_state = "headslime"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/xenom
	name = "Коллекционый шлем ксеноморфа"
	desc = "Шшш шшш шшш!"
	icon_state = "xenom"
	item_state_slots = list(slot_r_hand_str = "xenos_helm", slot_l_hand_str = "xenos_helm")
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/head/collectable/chef
	name = "Коллекционная шляпа повара"
	desc = "Редкая шляпа повара для коллекционеров шляп!"
	icon_state = "chefhat"

/obj/item/clothing/head/collectable/paper
	name = "Коллекционная бумажная шляпа"
	desc = "На первый взгляд может показаться, что это обычная шапочка их бумаги, однако на самом деле это редкий коллекционный головной убор. Хранить в месте, защищенном от огня, воды и библиотекарей."
	icon_state = "paper"
	body_parts_covered = 0
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/clothing/head/collectable/tophat
	name = "Коллекционный цилиндр"
	desc = "Цилиндр, принадлежащий лишь самым престижным коллекционерам шляп."
	icon_state = "tophat"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/captain
	name = "Коллекционная фуражка Директора колонии"
	desc = "Коллекционная фуражка, придающая Вам самый пресурьёзнейший вид!"
	icon_state = "captain"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/police
	name = "Коллекционная фуражка полицейского"
	desc = "Коллекционная фуражка офицера полиции. Дабы все понимали, что Вы - ЗАКОН."
	icon_state = "policehelm"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/beret
	name = "Коллекционный берет"
	desc = "Коллекционный берет красного цвета. Слегка отдаёт чесночком."
	icon_state = "beret"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/welding
	name = "Коллекционный сварочный шлем"
	desc = "Коллекционный сварочный шлем. Теперь содержит на 80% меньше свинца! Не предназначен для настоящей сварки. Сварка в этом шлеме проводится на собственный риск и страх владельца!"
	icon_state = "welding"
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/head/collectable/slime
	name = "Коллекционная шляпа-слизень!"
	desc = "Так хорошо прям садится!"
	icon_state = "headslime"
	item_state_slots = list(slot_r_hand_str = "greenbandana", slot_l_hand_str = "greenbandana")

/obj/item/clothing/head/collectable/flatcap
	name = "Коллекционная плоская кепка"
	desc = "Коллекционная плоская кепка фермера!"
	icon_state = "flat_cap"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")

/obj/item/clothing/head/collectable/pirate
	name = "Коллекционная шляпа пирата"
	desc = "Йо-хо-хо и бутылка Пан-галактика."
	icon_state = "pirate"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/kitty
	name = "Коллекционные кошачьи ушки"
	desc = "Шерсть на ощупь... какая-то даже чересчур реалистичная."
	icon_state = "kitty"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/rabbitears
	name = "Коллекционные кроличьи ушки"
	desc = "Не настолько везучие, как лапки!"
	icon_state = "bunny"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/wizard
	name = "Коллекционная шляпа волшебника"
	desc = "Примечание: Любые волшебные силы, полученные благодаря ношению этой шляпы, являются исключительно совпадением."
	icon_state = "wizard"

/obj/item/clothing/head/collectable/hardhat
	name = "Коллекционная каска"
	desc = "ВНИМАНИЕ: Не защищает от ударов и воздействия света, но зато стильная!"
	icon_state = "hardhat0_yellow"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/HoS
	name = "Коллекционная фуражка Главы СБ"
	desc = "Теперь даже Вы можете избивать заключенных, приписывать бессмысленные штрафы и арестовывать людей просто так!"
	icon_state = "hoscap"
	body_parts_covered = 0

/obj/item/clothing/head/collectable/thunderdome
	name = "Коллекционный шлем Громарены"
	desc = "Вперёд, красные! Вернее, зелёные! То есть красные! Нет, стоп, зелёные!"
	icon_state = "thunderdome"

/obj/item/clothing/head/collectable/swat
	name = "Коллекционный шлем СОБР"
	desc = "Теперь даже Вы можете стать членом Отряда смерти!"
	icon_state = "swat"
