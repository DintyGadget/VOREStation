// "Useful" items - I'm guessing things that might be used at work?
/datum/gear/utility
	display_name = "Портфель, кожаный"
	path = /obj/item/weapon/storage/briefcase
	sort_category = "Полезности"

/datum/gear/utility/clipboard
	display_name = "Планшет для документов"
	path = /obj/item/weapon/clipboard

/datum/gear/utility/tts_device
	display_name = "Преобразователь текста в речь"
	path = /obj/item/device/text_to_speech
	cost = 3 //Not extremely expensive, but it's useful for mute chracters.

/datum/gear/utility/communicator
	display_name = "Коммуникатор (выбор)"
	path = /obj/item/device/communicator
	cost = 0

/datum/gear/utility/communicator/New()
	..()
	var/list/communicators = list()
	for(var/communicator in typesof(/obj/item/device/communicator) - list(/obj/item/device/communicator/integrated,/obj/item/device/communicator/commlink)) //VOREStation Edit - Remove Commlink
		var/obj/item/device/communicator_type = communicator
		communicators[initial(communicator_type.name)] = communicator_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(communicators))

/datum/gear/utility/camera
	display_name = "Камера"
	path = /obj/item/device/camera

/datum/gear/utility/codex
	display_name = "Гид по системе Вир для туристов"
	path = /obj/item/weapon/book/codex //VOREStation Edit
	cost = 0

/datum/gear/utility/news
	display_name = "Карманный вестник Daedalus"
	path = /obj/item/weapon/book/codex/lore/news
	cost = 0

/* //VORESTATION REMOVAL
/datum/gear/utility/corp_regs
	display_name = "corporate regulations and legal code"
	path = /obj/item/weapon/book/codex/corp_regs
	cost = 0
*/

/datum/gear/utility/robutt
	display_name = "Гид по искусственным телам для потребителей"
	path = /obj/item/weapon/book/codex/lore/robutt
	cost = 0

/datum/gear/utility/folder_blue
	display_name = "Папка, синяя"
	path = /obj/item/weapon/folder/blue

/datum/gear/utility/folder_grey
	display_name = "Папка, серая"
	path = /obj/item/weapon/folder

/datum/gear/utility/folder_red
	display_name = "Папка, красная"
	path = /obj/item/weapon/folder/red

/datum/gear/utility/folder_white
	display_name = "Папка, белая"
	path = /obj/item/weapon/folder/white

/datum/gear/utility/folder_yellow
	display_name = "Папка, желтая"
	path = /obj/item/weapon/folder/yellow

/datum/gear/utility/paicard
	display_name = "Персональный ИИ"
	path = /obj/item/device/paicard

/datum/gear/utility/securecase
	display_name = "Портфель, надежный"
	path =/obj/item/weapon/storage/secure/briefcase
	cost = 2

/datum/gear/utility/laserpointer
	display_name = "Лазерная указка"
	path =/obj/item/device/laser_pointer
	cost = 2

/datum/gear/utility/flashlight
	display_name = "Фонарик"
	path = /obj/item/device/flashlight

/datum/gear/utility/flashlight_blue
	display_name = "Фонарик, синий"
	path = /obj/item/device/flashlight/color

/datum/gear/utility/flashlight_orange
	display_name = "Фонарик, оранжевый"
	path = /obj/item/device/flashlight/color/orange

/datum/gear/utility/flashlight_red
	display_name = "Фонарик, красный"
	path = /obj/item/device/flashlight/color/red

/datum/gear/utility/flashlight_yellow
	display_name = "Фонарик, желтый"
	path = /obj/item/device/flashlight/color/yellow

/datum/gear/utility/maglight
	display_name = "Фонарик, тяжелый"
	path = /obj/item/device/flashlight/maglight
	cost = 2

/datum/gear/utility/battery
	display_name = "Батарейка, девайс"
	path = /obj/item/weapon/cell/device

/datum/gear/utility/pen
	display_name = "Перьевая ручка"
	path = /obj/item/weapon/pen/fountain

/datum/gear/utility/umbrella
	display_name = "Umbrella"
	path = /obj/item/weapon/melee/umbrella
	cost = 3

/datum/gear/utility/umbrella/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/utility/wheelchair
	display_name = "Инвалидное кресло (выбор)"
	path = /obj/item/wheelchair
	cost = 4

/datum/gear/utility/wheelchair/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice
	var/list/wheelchairs = list(
		"Инвалидное кресло" = /obj/item/wheelchair,
		"Мотор. Инвалид. кресло" = /obj/item/wheelchair/motor
	)
	gear_tweaks += new/datum/gear_tweak/path(wheelchairs)

/****************
modular computers
****************/

/datum/gear/utility/cheaptablet
	display_name = "Планшетный ПК: дешевый"
	display_name = "Планшетный ПК, дешевый"
	path = /obj/item/modular_computer/tablet/preset/custom_loadout/cheap
	cost = 3

/datum/gear/utility/normaltablet
	display_name = "Планшетный ПК: продвинутый"
	display_name = "Планшетный ПК, продвинутый"
	path = /obj/item/modular_computer/tablet/preset/custom_loadout/advanced
	cost = 4

/datum/gear/utility/customtablet
	display_name = "Планшетный ПК: особый"
	display_name = "Планшетный ПК, особый"
	path = /obj/item/modular_computer/tablet
	cost = 4

/datum/gear/utility/customtablet/New()
	..()
	gear_tweaks += new /datum/gear_tweak/tablet()

/datum/gear/utility/cheaplaptop
	display_name = "Ноутбук, дешевый"
	path = /obj/item/modular_computer/laptop/preset/custom_loadout/cheap
	cost = 4

/datum/gear/utility/normallaptop
	display_name = "Ноутбук, продвинутый"
	path = /obj/item/modular_computer/laptop/preset/custom_loadout/advanced
	cost = 5

/datum/gear/utility/customlaptop
	display_name = "Ноутбук, особый"
	path = /obj/item/modular_computer/laptop/preset/
	cost = 6 //VOREStation Edit

/datum/gear/utility/customlaptop/New()
	..()
	gear_tweaks += new /datum/gear_tweak/laptop()
