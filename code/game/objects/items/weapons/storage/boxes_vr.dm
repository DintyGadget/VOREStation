/obj/item/weapon/storage/box/survival
	starts_with = list(
		/obj/item/weapon/tool/prybar/red,
		/obj/item/clothing/glasses/goggles,
		/obj/item/clothing/mask/breath
	)

/obj/item/weapon/storage/box/survival/synth
	starts_with = list(
		/obj/item/weapon/tool/prybar/red,
		/obj/item/clothing/glasses/goggles
	)

/obj/item/weapon/storage/box/survival/comp
	starts_with = list(
		/obj/item/weapon/tool/prybar/red,
		/obj/item/clothing/glasses/goggles,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/device/flashlight/glowstick,
		/obj/item/weapon/reagent_containers/food/snacks/candy/proteinbar,
		/obj/item/clothing/mask/breath
	)

/obj/item/weapon/storage/box/explorerkeys
	name = "Коробка волонтёрских гарнитур"
	desc = "Коробка, забитая доверху волонтёрскими гарнитурами, выдаваемыми желающим поучаствовать в экспедиции."
	starts_with = list(/obj/item/device/radio/headset/volunteer = 7)

/obj/item/weapon/storage/box/commandkeys
	name = "Коробка ключей Управления"
	desc = "Коробка ключей шифрования Управления, которые при необходимости могут выдавать руководители."
	starts_with = list(/obj/item/device/encryptionkey/headset_com = 7)

/obj/item/weapon/storage/box/servicekeys
	name = "Коробка ключей сервиса"
	desc = "Коробка ключей шифрования сервиса, которые при необходимости может выдавать Глава персонала."
	starts_with = list(/obj/item/device/encryptionkey/headset_service = 7)

/obj/item/weapon/storage/box/survival/space
	name = "Коробка с аварийным скафандром"
	icon_state = "survivaleng"
	starts_with = list(
		/obj/item/clothing/suit/space/emergency,
		/obj/item/clothing/head/helmet/space/emergency,
		/obj/item/clothing/mask/breath,
		/obj/item/weapon/tank/emergency/oxygen/double
	)

/obj/item/weapon/storage/secure/briefcase/trashmoney
	starts_with = list(/obj/item/weapon/spacecash/c200 = 10)
