/datum/design/item/prosfab
	build_type = PROSFAB
	category = list("Misc")
	req_tech = list(TECH_MATERIAL = 1)

/datum/design/item/prosfab/pros
	category = list("Prosthetics")

// Make new external organs and make 'em robotish
/datum/design/item/prosfab/pros/Fabricate(var/newloc, var/fabricator)
	if(istype(fabricator, /obj/machinery/mecha_part_fabricator/pros))
		var/obj/machinery/mecha_part_fabricator/pros/prosfab = fabricator
		var/obj/item/organ/O = new build_path(newloc)
		if(prosfab.manufacturer)
			var/datum/robolimb/manf = all_robolimbs[prosfab.manufacturer]

			if(!(O.organ_tag in manf.parts))	// Make sure we're using an actually present icon.
				manf = all_robolimbs["Unbranded"]

			if(prosfab.species in manf.species_alternates)	// If the prosthetics fab is set to say, Unbranded, and species set to 'Tajaran', it will make the Taj variant of Unbranded, if it exists.
				manf = manf.species_alternates[prosfab.species]

			if(!prosfab.species || (prosfab.species in manf.species_cannot_use))	// Fabricator ensures the manufacturer can make parts for the species we're set to.
				O.species = GLOB.all_species["[manf.suggested_species]"]
			else
				O.species = GLOB.all_species[prosfab.species]
		else
			O.species = GLOB.all_species["Human"]
		O.robotize(prosfab.manufacturer)
		O.dna = new/datum/dna() //Uuughhhh... why do I have to do this?
		O.dna.ResetUI()
		O.dna.ResetSE()
		spawn(10) //Limbs love to flop around. Who am I to deny them?
			O.dir = 2
		return O
	return ..()

// Deep Magic for the torso since it needs to be a new mob
/datum/design/item/prosfab/pros/torso/Fabricate(var/newloc, var/fabricator)
	if(istype(fabricator, /obj/machinery/mecha_part_fabricator/pros))
		var/obj/machinery/mecha_part_fabricator/pros/prosfab = fabricator
		var/newspecies = "Human"

		var/datum/robolimb/manf = all_robolimbs[prosfab.manufacturer]

		if(manf)
			if(prosfab.species in manf.species_alternates)	// If the prosthetics fab is set to say, Unbranded, and species set to 'Tajaran', it will make the Taj variant of Unbranded, if it exists.
				manf = manf.species_alternates[prosfab.species]

			if(!prosfab.species || (prosfab.species in manf.species_cannot_use))
				newspecies = manf.suggested_species
			else
				newspecies = prosfab.species

		var/mob/living/carbon/human/H = new(newloc,newspecies)
		H.set_stat(DEAD)
		H.gender = gender
		for(var/obj/item/organ/external/EO in H.organs)
			if(EO.organ_tag == BP_TORSO || EO.organ_tag == BP_GROIN)
				continue //Roboticizing a torso does all the children and wastes time, do it later
			else
				EO.remove_rejuv()

		for(var/obj/item/organ/external/O in H.organs)
			O.species = GLOB.all_species[newspecies]

			if(!(O.organ_tag in manf.parts))	// Make sure we're using an actually present icon.
				manf = all_robolimbs["Unbranded"]

			O.robotize(manf.company)
			O.dna = new/datum/dna()
			O.dna.ResetUI()
			O.dna.ResetSE()

			// Skincolor weirdness.
			O.s_col[1] = 0
			O.s_col[2] = 0
			O.s_col[3] = 0

		// Resetting the UI does strange things for the skin of a non-human robot, which should be controlled by a whole different thing.
		H.r_skin = 0
		H.g_skin = 0
		H.b_skin = 0
		H.dna.ResetUIFrom(H)

		H.real_name = "Synthmorph #[rand(100,999)]"
		H.name = H.real_name
		H.dir = 2
		H.add_language(LANGUAGE_EAL)
		return H

//////////////////// Prosthetics ////////////////////
/datum/design/item/prosfab/pros/torso
	time = 35
	materials = list(DEFAULT_WALL_MATERIAL = 30000, "glass" = 7500)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 3, TECH_DATA = 3)	//Saving the values just in case
	var/gender = MALE

/datum/design/item/prosfab/pros/torso/male
	name = "FBP Торс (M)"
	id = "pros_torso_m"
	build_path = /obj/item/organ/external/chest
	gender = MALE

/obj/item/organ/external/chest/f //To satisfy CI. :|

/datum/design/item/prosfab/pros/torso/female
	name = "FBP Торс (F)"
	id = "pros_torso_f"
	build_path = /obj/item/organ/external/chest/f
	gender = FEMALE

/datum/design/item/prosfab/pros/head
	name = "Протез головы"
	id = "pros_head"
	build_path = /obj/item/organ/external/head
	time = 30
	materials = list(DEFAULT_WALL_MATERIAL = 18750, "glass" = 3750)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 3, TECH_DATA = 3)	//Saving the values just in case

/datum/design/item/prosfab/pros/l_arm
	name = "Протез левой руки"
	id = "pros_l_arm"
	build_path = /obj/item/organ/external/arm
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 10125)

/datum/design/item/prosfab/pros/l_hand
	name = "Протез левой кисти"
	id = "pros_l_hand"
	build_path = /obj/item/organ/external/hand
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 3375)

/datum/design/item/prosfab/pros/r_arm
	name = "Протез правой руки"
	id = "pros_r_arm"
	build_path = /obj/item/organ/external/arm/right
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 10125)

/datum/design/item/prosfab/pros/r_hand
	name = "Протез правой кисти"
	id = "pros_r_hand"
	build_path = /obj/item/organ/external/hand/right
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 3375)

/datum/design/item/prosfab/pros/l_leg
	name = "Протез левой ноги"
	id = "pros_l_leg"
	build_path = /obj/item/organ/external/leg
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 8437)

/datum/design/item/prosfab/pros/l_foot
	name = "Протез левой ступни"
	id = "pros_l_foot"
	build_path = /obj/item/organ/external/foot
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 2813)

/datum/design/item/prosfab/pros/r_leg
	name = "Протез правой ноги"
	id = "pros_r_leg"
	build_path = /obj/item/organ/external/leg/right
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 8437)

/datum/design/item/prosfab/pros/r_foot
	name = "Протез правой ступни"
	id = "pros_r_foot"
	build_path = /obj/item/organ/external/foot/right
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 2813)

/datum/design/item/prosfab/pros/internal
	category = list("Prosthetics, Internal")

/datum/design/item/prosfab/pros/internal/cell
	name = "Протез Энергоячейка"
	id = "pros_cell"
	build_path = /obj/item/organ/internal/cell
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 7500, "glass" = 3000)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/eyes
	name = "Протез глаз"
	id = "pros_eyes"
	build_path = /obj/item/organ/internal/eyes/robot
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 5625, "glass" = 5625)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/hydraulic
	name = "Гидравлический концентратор"
	id = "pros_hydraulic"
	build_path = /obj/item/organ/internal/heart/machine
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 7500, MAT_PLASTIC = 3000)

/datum/design/item/prosfab/pros/internal/reagcycler
	name = "Циклер реагентов"
	id = "pros_reagcycler"
	build_path = /obj/item/organ/internal/stomach/machine
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 7500, MAT_PLASTIC = 3000)

/datum/design/item/prosfab/pros/internal/heatsink
	name = "Радиатор"
	id = "pros_heatsink"
	build_path = /obj/item/organ/internal/robotic/heatsink
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 7500, MAT_PLASTIC = 3000)

/datum/design/item/prosfab/pros/internal/diagnostic
	name = "Диагностический контроллер"
	id = "pros_diagnostic"
	build_path = /obj/item/organ/internal/robotic/diagnostic
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 7500, MAT_PLASTIC = 3000)

/datum/design/item/prosfab/pros/internal/heart
	name = "Протез сердца"
	id = "pros_heart"
	build_path = /obj/item/organ/internal/heart
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 5625, "glass" = 1000)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/lungs
	name = "Протез легких"
	id = "pros_lung"
	build_path = /obj/item/organ/internal/lungs
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 5625, "glass" = 1000)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/liver
	name = "Протез печени"
	id = "pros_liver"
	build_path = /obj/item/organ/internal/liver
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 5625, "glass" = 1000)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/kidneys
	name = "Протез почек"
	id = "pros_kidney"
	build_path = /obj/item/organ/internal/kidneys
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 5625, "glass" = 1000)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/spleen
	name = "Протез селезенки"
	id = "pros_spleen"
	build_path = /obj/item/organ/internal/spleen
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 3000, MAT_GLASS = 750)
//	req_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 2)

/datum/design/item/prosfab/pros/internal/larynx
	name = "Протез гортани"
	id = "pros_larynx"
	build_path = /obj/item/organ/internal/voicebox
	time = 15
	materials = list(DEFAULT_WALL_MATERIAL = 2000, MAT_GLASS = 750, MAT_PLASTIC = 500)

//////////////////// Cyborg Parts ////////////////////
/datum/design/item/prosfab/cyborg
	category = list("Cyborg Parts")
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 3750)

/datum/design/item/prosfab/cyborg/exoskeleton
	name = "Экзоскелет робота"
	id = "robot_exoskeleton"
	build_path = /obj/item/robot_parts/robot_suit
	time = 50
	materials = list(DEFAULT_WALL_MATERIAL = 37500)

/datum/design/item/prosfab/cyborg/torso
	name = "Торс робота"
	id = "robot_torso"
	build_path = /obj/item/robot_parts/chest
	time = 35
	materials = list(DEFAULT_WALL_MATERIAL = 30000)

/datum/design/item/prosfab/cyborg/head
	name = "Голова робота"
	id = "robot_head"
	build_path = /obj/item/robot_parts/head
	time = 35
	materials = list(DEFAULT_WALL_MATERIAL = 18750)

/datum/design/item/prosfab/cyborg/l_arm
	name = "Левая рука робота"
	id = "robot_l_arm"
	build_path = /obj/item/robot_parts/l_arm
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 13500)

/datum/design/item/prosfab/cyborg/r_arm
	name = "Правая рука робота"
	id = "robot_r_arm"
	build_path = /obj/item/robot_parts/r_arm
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 13500)

/datum/design/item/prosfab/cyborg/l_leg
	name = "Левая нога робота"
	id = "robot_l_leg"
	build_path = /obj/item/robot_parts/l_leg
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 11250)

/datum/design/item/prosfab/cyborg/r_leg
	name = "Правая нога робота"
	id = "robot_r_leg"
	build_path = /obj/item/robot_parts/r_leg
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 11250)


//////////////////// Cyborg Internals ////////////////////
/datum/design/item/prosfab/cyborg/component
	category = list("Cyborg Internals")
	build_type = PROSFAB
	time = 12
	materials = list(DEFAULT_WALL_MATERIAL = 7500)

/datum/design/item/prosfab/cyborg/component/binary_communication_device
	name = "Устройство двоичной связи"
	id = "binary_communication_device"
	build_path = /obj/item/robot_parts/robot_component/binary_communication_device

/datum/design/item/prosfab/cyborg/component/radio
	name = "Радио"
	id = "radio"
	build_path = /obj/item/robot_parts/robot_component/radio

/datum/design/item/prosfab/cyborg/component/actuator
	name = "Привод"
	id = "actuator"
	build_path = /obj/item/robot_parts/robot_component/actuator

/datum/design/item/prosfab/cyborg/component/diagnosis_unit
	name = "Блок диагностики"
	id = "diagnosis_unit"
	build_path = /obj/item/robot_parts/robot_component/diagnosis_unit

/datum/design/item/prosfab/cyborg/component/camera
	name = "Камера"
	id = "camera"
	build_path = /obj/item/robot_parts/robot_component/camera

/datum/design/item/prosfab/cyborg/component/armour
	name = "Броня (Робот)"
	id = "armour"
	build_path = /obj/item/robot_parts/robot_component/armour

/datum/design/item/prosfab/cyborg/component/armour_heavy
	name = "Броня (платформа)"
	id = "platform_armour"
	build_path = /obj/item/robot_parts/robot_component/armour_platform

/datum/design/item/prosfab/cyborg/component/ai_shell
	name = "Удаленный интерфейс AI"
	id = "mmi_ai_shell"
	build_path = /obj/item/device/mmi/inert/ai_remote

//////////////////// Cyborg Modules ////////////////////
/datum/design/item/prosfab/robot_upgrade
	category = list("Cyborg Modules")
	build_type = PROSFAB
	time = 12
	materials = list(DEFAULT_WALL_MATERIAL = 7500)

/datum/design/item/prosfab/robot_upgrade/rename
	name = "Модуль переименовки"
	desc = "Используется для переименования киборга."
	id = "borg_rename_module"
	build_path = /obj/item/borg/upgrade/rename

/datum/design/item/prosfab/robot_upgrade/reset
	name = "Модуль сброса"
	desc = "Используется для сброса модуля киборга. Уничтожает любые другие улучшения, примененные к роботу."
	id = "borg_reset_module"
	build_path = /obj/item/borg/upgrade/reset

/datum/design/item/prosfab/robot_upgrade/restart
	name = "Модуль аварийного перезапуска"
	desc = "Используется для принудительного перезапуска неисправного, но отремонтированного робота, чтобы вернуть его в оперативный режим."
	id = "borg_restart_module"
	materials = list(DEFAULT_WALL_MATERIAL = 45000, "glass" = 3750)
	build_path = /obj/item/borg/upgrade/restart

/datum/design/item/prosfab/robot_upgrade/vtec
	name = "Модуль VTEC"
	desc = "Используется для включения систем VTEC робота, увеличивая их скорость."
	id = "borg_vtec_module"
	materials = list(DEFAULT_WALL_MATERIAL = 60000, "glass" = 4500, "gold" = 3750)
	build_path = /obj/item/borg/upgrade/vtec

/datum/design/item/prosfab/robot_upgrade/tasercooler
	name = "Модуль быстрого охлаждения электрошокера"
	desc = "Используется для охлаждения установленного электрошокера, увеличения потенциального тока в нем и, следовательно, скорости его перезарядки."
	id = "borg_taser_module"
	materials = list(DEFAULT_WALL_MATERIAL = 60000, "glass" = 4500, "gold" = 1500, "diamond" = 375)
	build_path = /obj/item/borg/upgrade/tasercooler

/datum/design/item/prosfab/robot_upgrade/jetpack
	name = "Реактивный модуль"
	desc = "Реактивный ранец с диоксидом углерода, подходящий для горных работ в условиях малой гравитации."
	id = "borg_jetpack_module"
	materials = list(DEFAULT_WALL_MATERIAL = 7500, "phoron" = 11250, "uranium" = 15000)
	build_path = /obj/item/borg/upgrade/jetpack

/datum/design/item/prosfab/robot_upgrade/advhealth
	name = "Модуль Продвинутого анализа здоровья"
	desc = "Продвинутый анализатор здоровья, подходящий для диагностики более серьезных травм."
	id = "borg_advhealth_module"
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "glass" = 6500, "diamond" = 350)
	build_path = /obj/item/borg/upgrade/advhealth

/datum/design/item/prosfab/robot_upgrade/syndicate
	name = "Модуль скремблированного оборудования"
	desc = "Позволяет создавать смертоносные улучшения для киборгов."
	id = "borg_syndicate_module"
	req_tech = list(TECH_COMBAT = 4, TECH_ILLEGAL = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 7500, "glass" = 11250, "diamond" = 7500)
	build_path = /obj/item/borg/upgrade/syndicate

/datum/design/item/prosfab/robot_upgrade/language
	name = "Языковой модуль"
	desc = "Используется, чтобы позволить киборгам, кроме клерков или служащих, говорить на разных языках."
	id = "borg_language_module"
	req_tech = list(TECH_DATA = 6, TECH_MATERIAL = 6)
	materials = list(DEFAULT_WALL_MATERIAL = 25000, "glass" = 3000, "gold" = 350)
	build_path = /obj/item/borg/upgrade/language

// Synthmorph Bags.

/datum/design/item/prosfab/synthmorphbag
	name = "Сумка для хранения синтморфа"
	desc = "Используется для хранения или медленной дефрагментации FBP."
	id = "misc_synth_bag"
	materials = list(DEFAULT_WALL_MATERIAL = 250, "glass" = 250, "plastic" = 2000)
	build_path = /obj/item/bodybag/cryobag/robobag

/datum/design/item/prosfab/badge_nt
	name = "NanoTrasen Tag"
	desc = "Used to identify an empty NanoTrasen FBP."
	id = "misc_synth_bag_tag_nt"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag

/datum/design/item/prosfab/badge_morph
	name = "Morpheus Tag"
	desc = "Used to identify an empty Morpheus FBP."
	id = "misc_synth_bag_tag_morph"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/morpheus

/datum/design/item/prosfab/badge_wardtaka
	name = "Ward-Takahashi Tag"
	desc = "Used to identify an empty Ward-Takahashi FBP."
	id = "misc_synth_bag_tag_wardtaka"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/wardtaka

/datum/design/item/prosfab/badge_zenghu
	name = "Zeng-Hu Tag"
	desc = "Used to identify an empty Zeng-Hu FBP."
	id = "misc_synth_bag_tag_zenghu"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/zenghu

/datum/design/item/prosfab/badge_gilthari
	name = "Gilthari Tag"
	desc = "Used to identify an empty Gilthari FBP."
	id = "misc_synth_bag_tag_gilthari"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "gold" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/gilthari
	req_tech = list(TECH_MATERIAL = 4, TECH_ILLEGAL = 2, TECH_PHORON = 2)

/datum/design/item/prosfab/badge_veymed
	name = "Vey-Medical Tag"
	desc = "Used to identify an empty Vey-Medical FBP."
	id = "misc_synth_bag_tag_veymed"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/veymed
	req_tech = list(TECH_MATERIAL = 3, TECH_ILLEGAL = 1, TECH_BIO = 4)

/datum/design/item/prosfab/badge_hephaestus
	name = "Hephaestus Tag"
	desc = "Used to identify an empty Hephaestus FBP."
	id = "misc_synth_bag_tag_heph"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/hephaestus

/datum/design/item/prosfab/badge_grayson
	name = "Grayson Tag"
	desc = "Used to identify an empty Grayson FBP."
	id = "misc_synth_bag_tag_grayson"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/grayson

/datum/design/item/prosfab/badge_xion
	name = "Xion Tag"
	desc = "Used to identify an empty Xion FBP."
	id = "misc_synth_bag_tag_xion"
	materials = list(DEFAULT_WALL_MATERIAL = 1000, "glass" = 500, "plastic" = 1000)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/xion

/datum/design/item/prosfab/badge_bishop
	name = "Bishop Tag"
	desc = "Used to identify an empty Bishop FBP."
	id = "misc_synth_bag_tag_bishop"
	materials = list(DEFAULT_WALL_MATERIAL = 500, "glass" = 2000, "plastic" = 500)
	build_path = /obj/item/clothing/accessory/badge/corporate_tag/bishop
