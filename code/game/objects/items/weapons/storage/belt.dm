/obj/item/weapon/storage/belt
	name = "Ремень"
	desc = "Позволяет держать при себе разные вещи."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	storage_slots = 7
	max_storage_space = ITEMSIZE_COST_NORMAL * 7 //This should ensure belts always have enough room to store whatever.
	max_w_class = ITEMSIZE_NORMAL
	slot_flags = SLOT_BELT
	attack_verb = list("хлестает", "хлыщет", "наказывает")
	equip_sound = 'sound/items/toolbelt_equip.ogg'
	drop_sound = 'sound/items/drop/toolbelt.ogg'
	pickup_sound = 'sound/items/pickup/toolbelt.ogg'
	sprite_sheets = list(SPECIES_TESHARI = 'icons/mob/species/teshari/belt.dmi')

	var/show_above_suit = 0

/obj/item/weapon/storage/belt/verb/toggle_layer()
	set name = "Сменить Слой Ремня"
	set category = "Object"

	if(show_above_suit == -1)
		to_chat(usr, "<span class='notice'>[capitalize(ru_getcase(src, "acase"))] нельзя носить поверх верхней одежды!</span>")
		return
	show_above_suit = !show_above_suit
	update_icon()

//Some belts have sprites to show icons
/obj/item/weapon/storage/belt/make_worn_icon(var/body_type,var/slot_name,var/inhands,var/default_icon,var/default_layer = 0)
	var/image/standing = ..()
	if(!inhands && contents.len)
		for(var/obj/item/i in contents)
			var/i_state = i.item_state
			if(!i_state) i_state = i.icon_state
			standing.add_overlay(image(icon = INV_BELT_DEF_ICON, icon_state = i_state))
	return standing

/obj/item/weapon/storage/update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()

/obj/item/weapon/storage/belt/utility
	name = "Пояс для инструментов" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Вмещает различные инструменты."
	icon_state = "utility"
	can_hold = list(
		///obj/item/weapon/combitool,
		/obj/item/weapon/tool/crowbar,
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/tool/wirecutters,
		/obj/item/weapon/tool/wrench,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/stack/cable_coil,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/device/pda,
		/obj/item/device/megaphone,
		/obj/item/taperoll,
		/obj/item/device/radio/headset,
		/obj/item/device/robotanalyzer,
		/obj/item/weapon/material/minihoe,
		/obj/item/weapon/material/knife/machete/hatchet,
		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/weapon/extinguisher/mini,
		/obj/item/weapon/tape_roll,
		/obj/item/device/integrated_electronics/wirer,
		/obj/item/device/integrated_electronics/debugger, //Vorestation edit adding debugger to toolbelt can hold list
		)

/obj/item/weapon/storage/belt/utility/full
	starts_with = list(
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/tool/wrench,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/tool/crowbar,
		/obj/item/weapon/tool/wirecutters,
		/obj/item/stack/cable_coil/random_belt
	)

/obj/item/weapon/storage/belt/utility/atmostech
	starts_with = list(
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/tool/wrench,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/tool/crowbar,
		/obj/item/weapon/tool/wirecutters,
	)

/obj/item/weapon/storage/belt/utility/chief
	name = "Пояс Главного инженера"
	desc = "Вмещает инструменты, выглядит шикарно."
	icon_state = "utilitybelt_ce"
	item_state = "utility_ce"

/obj/item/weapon/storage/belt/utility/chief/full
	starts_with = list(
		/obj/item/weapon/tool/screwdriver/power,
		/obj/item/weapon/tool/crowbar/power,
		/obj/item/weapon/weldingtool/experimental,
		/obj/item/device/multitool,
		/obj/item/stack/cable_coil/random_belt,
		/obj/item/weapon/extinguisher/mini,
		/obj/item/device/analyzer
	)

/obj/item/weapon/storage/belt/medical
	name = "Пояс врача"
	desc = "Вмещает различное медицинские принадлежности."
	icon_state = "medical"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/glass/bottle,
		/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/storage/quickdraw/syringe_case, //VOREStation Addition - Adds syringe cases,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/radio/headset,
		/obj/item/device/pda,
		/obj/item/taperoll,
		/obj/item/device/megaphone,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/head/surgery,
		/obj/item/clothing/gloves,
		/obj/item/weapon/reagent_containers/hypospray,
		/obj/item/clothing/glasses,
		/obj/item/weapon/tool/crowbar,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/extinguisher/mini,
		/obj/item/weapon/storage/quickdraw/syringe_case
		)

/obj/item/weapon/storage/belt/medical/emt
	name = "Пояс парамедика"
	desc = "Прочный чёрный ремень с прикреплёнными карманами."
	icon_state = "ems"

/obj/item/weapon/storage/belt/security
	name = "Пояс службы безопасности"
	desc = "Вмещает в себя защитное снаряжение, например, наручники или дубинки."
	icon_state = "security"
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(
		/obj/item/weapon/grenade,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/a12g,
		/obj/item/ammo_magazine,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/reagent_containers/food/snacks/donut/,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/gun/energy/stunrevolver,
		/obj/item/weapon/gun/magnetic/railgun/heater/pistol,
		/obj/item/weapon/gun/energy/gun,
		/obj/item/weapon/flame/lighter,
		/obj/item/device/flashlight,
		/obj/item/device/taperecorder,
		/obj/item/device/tape,
		/obj/item/device/pda,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/weapon/melee,
		/obj/item/clothing/accessory/badge,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/weapon/gun/projectile/p92x,
		/obj/item/taperoll,
		/obj/item/weapon/gun/projectile/colt/detective,
		/obj/item/device/holowarrant
		)

/obj/item/weapon/storage/belt/detective
	name = "Пояс криминалиста"
	desc = "Ремень для хранения оборудования для криминалистики."
	icon_state = "security"
	storage_slots = 7
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(
		/obj/item/device/taperecorder,
		/obj/item/device/tape,
		/obj/item/clothing/glasses,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/reagent_containers/spray/luminol,
		/obj/item/weapon/sample,
		/obj/item/weapon/forensics/sample_kit/powder,
		/obj/item/weapon/forensics/swab,
		/obj/item/device/uv_light,
		/obj/item/weapon/forensics/sample_kit,
		/obj/item/weapon/photo,
		/obj/item/device/camera_film,
		/obj/item/device/camera,
		/obj/item/weapon/autopsy_scanner,
		/obj/item/device/mass_spectrometer,
		/obj/item/clothing/accessory/badge,
		/obj/item/device/reagent_scanner,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/device/pda,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/taperoll,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/weapon/flame/lighter,
		/obj/item/weapon/reagent_containers/food/snacks/donut/,
		/obj/item/ammo_magazine,
		/obj/item/weapon/gun/projectile/colt/detective,
		/obj/item/device/holowarrant
		)

/obj/item/weapon/storage/belt/soulstone
	name = "Пояс камней души"
	desc = "Предназначен для легкого доступа к осколкам во время боя, чтобы не дать ни одному духу противника ускользнуть."
	icon_state = "soulstone"
	storage_slots = 6
	can_hold = list(
		/obj/item/device/soulstone
		)

/obj/item/weapon/storage/belt/soulstone/full
	starts_with = list(/obj/item/device/soulstone = 6)

/obj/item/weapon/storage/belt/utility/alien
	name = "Инопланетный пояс"
	desc = "Ремень (?), который может держать в себе предметы."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "belt"
	item_state = "security"

/obj/item/weapon/storage/belt/utility/alien/full
	starts_with = list(
		/obj/item/weapon/tool/screwdriver/alien,
		/obj/item/weapon/tool/wrench/alien,
		/obj/item/weapon/weldingtool/alien,
		/obj/item/weapon/tool/crowbar/alien,
		/obj/item/weapon/tool/wirecutters/alien,
		/obj/item/device/multitool/alien,
		/obj/item/stack/cable_coil/alien
	)

/obj/item/weapon/storage/belt/medical/alien
	name = "Инопланетный пояс"
	desc = "Ремень (?), который может держать в себе предметы."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "belt"
	item_state = "security"
	storage_slots = 8
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/glass/bottle,
		/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/radio/headset,
		/obj/item/device/pda,
		/obj/item/taperoll,
		/obj/item/device/megaphone,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/head/surgery,
		/obj/item/clothing/gloves,
		/obj/item/weapon/reagent_containers/hypospray,
		/obj/item/clothing/glasses,
		/obj/item/weapon/tool/crowbar,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/extinguisher/mini,
		/obj/item/weapon/surgical
		)

/obj/item/weapon/storage/belt/medical/alien
	starts_with = list(
		/obj/item/weapon/surgical/scalpel/alien,
		/obj/item/weapon/surgical/hemostat/alien,
		/obj/item/weapon/surgical/retractor/alien,
		/obj/item/weapon/surgical/circular_saw/alien,
		/obj/item/weapon/surgical/FixOVein/alien,
		/obj/item/weapon/surgical/bone_clamp/alien,
		/obj/item/weapon/surgical/cautery/alien,
		/obj/item/weapon/surgical/surgicaldrill/alien
	)

/obj/item/weapon/storage/belt/champion
	name = "Пояс чемпиона"
	desc = "Докажите миру, что Вы лучше всех!"
	icon_state = "champion"
	storage_slots = 1
	can_hold = list(
		"/obj/item/clothing/mask/luchador"
		)

/obj/item/weapon/storage/belt/security/tactical
	name = "Боевой пояс"
	desc = "Вмещает в себя защитное снаряжение, например, наручники или дубинки. Имеет большое количество карманов для большего объема хранения."
	icon_state = "swat"
	storage_slots = 9
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 7

/obj/item/weapon/storage/belt/security/tactical/bandolier
	name = "Боевой пояс"
	desc = "Вмещает в себя защитное снаряжение, например, наручники или дубинки. Имеет большое количество карманов для большего объема хранения."
	icon_state = "bandolier"

/obj/item/weapon/storage/belt/janitor
	name = "Пояс уборщика"
	desc = "Пояс, используемый для хранения большинства принадлежностей для уборки."
	icon_state = "janitor"
	storage_slots = 7
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(
		/obj/item/clothing/glasses,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/grenade,
		/obj/item/device/pda,
		/obj/item/device/radio/headset,
		/obj/item/clothing/gloves,
		/obj/item/clothing/mask/surgical, //sterile mask,
		/obj/item/device/assembly/mousetrap,
		/obj/item/weapon/light/bulb,
		/obj/item/weapon/light/tube,
		/obj/item/weapon/flame/lighter,
		/obj/item/device/megaphone,
		/obj/item/taperoll,
		/obj/item/weapon/reagent_containers/spray,
		/obj/item/weapon/soap
		)

/obj/item/weapon/storage/belt/archaeology
	name = "Археологический пояс"
	desc = "Может содержать различное оборудование для проведения раскопок."
	icon_state = "gear"
	can_hold = list(
		/obj/item/weapon/storage/box/samplebags,
		/obj/item/device/core_sampler,
		/obj/item/device/beacon_locator,
		/obj/item/device/radio/beacon,
		/obj/item/device/gps,
		/obj/item/device/measuring_tape,
		/obj/item/device/flashlight,
		/obj/item/weapon/cell/device,
		/obj/item/weapon/pickaxe,
		/obj/item/device/depth_scanner,
		/obj/item/device/camera,
		/obj/item/weapon/paper,
		/obj/item/weapon/photo,
		/obj/item/weapon/folder,
		/obj/item/weapon/pen,
		/obj/item/weapon/folder,
		/obj/item/weapon/clipboard,
		/obj/item/weapon/anodevice,
		/obj/item/clothing/glasses,
		/obj/item/weapon/tool/wrench,
		/obj/item/weapon/storage/excavation,
		/obj/item/weapon/anobattery,
		/obj/item/device/ano_scanner,
		/obj/item/weapon/pickaxe/hand,
		/obj/item/device/xenoarch_multi_tool,
		/obj/item/weapon/pickaxe/excavationdrill
		)

/obj/item/weapon/storage/belt/fannypack
	name = "Кожаная поясная сумка"
	desc = "Забавная поясная сумка для хранения мелких предметов."
	icon_state = "fannypack_leather"
	item_state = "fannypack_leather"
	max_w_class = ITEMSIZE_SMALL
	storage_slots = null
	max_storage_space = ITEMSIZE_COST_NORMAL * 2

/obj/item/weapon/storage/belt/fannypack/black
 	name = "Чёрная поясная сумка"
 	icon_state = "fannypack_black"
 	item_state = "fannypack_black"

/obj/item/weapon/storage/belt/fannypack/blue
 	name = "Синяя поясная сумка"
 	icon_state = "fannypack_blue"
 	item_state = "fannypack_blue"

/obj/item/weapon/storage/belt/fannypack/cyan
 	name = "Голубая поясная сумка"
 	icon_state = "fannypack_cyan"
 	item_state = "fannypack_cyan"

/obj/item/weapon/storage/belt/fannypack/green
 	name = "Зелёная поясная сумка"
 	icon_state = "fannypack_green"
 	item_state = "fannypack_green"

/obj/item/weapon/storage/belt/fannypack/orange
 	name = "Оранжевая поясная сумка"
 	icon_state = "fannypack_orange"
 	item_state = "fannypack_orange"

/obj/item/weapon/storage/belt/fannypack/purple
 	name = "Фиолетовая поясная сумка"
 	icon_state = "fannypack_purple"
 	item_state = "fannypack_purple"

/obj/item/weapon/storage/belt/fannypack/red
 	name = "Красная поясная сумка"
 	icon_state = "fannypack_red"
 	item_state = "fannypack_red"

/obj/item/weapon/storage/belt/fannypack/white
 	name = "Белая поясная сумка"
 	icon_state = "fannypack_white"
 	item_state = "fannypack_white"

/obj/item/weapon/storage/belt/fannypack/yellow
 	name = "Жёлтая поясная сумка"
 	icon_state = "fannypack_yellow"
 	item_state = "fannypack_yellow"

/obj/item/weapon/storage/belt/ranger
	name = "Пояс рейнджера"
	desc = "Пафосный пояс для всевозможных гаджетов, наручников и инструментов, прям как у Go Go ERT-Рейнджеров. Пряжка не из настоящего форона, но в целом пояс удобный."
	icon = 'icons/obj/clothing/ranger.dmi'
	icon_state = "ranger_belt"