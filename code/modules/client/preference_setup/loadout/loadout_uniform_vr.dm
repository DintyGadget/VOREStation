/datum/gear/uniform/suit/permit
	display_name = "Право на наготу"
	path = /obj/item/clothing/under/permit

//Polaris overrides
/datum/gear/uniform/solgov/pt/sifguard
	display_name = "Комплект, военная спортивная форма"
	path = /obj/item/clothing/under/solgov/pt/sifguard

/datum/gear/uniform/job_skirt/sci
	allowed_roles = list("Research Director","Scientist", "Xenobiologist", "Xenobotanist")

/datum/gear/uniform/job_turtle/science
	allowed_roles = list("Research Director", "Scientist", "Roboticist", "Xenobiologist", "Xenobotanist")

/datum/gear/uniform/job_turtle/medical
	display_name = "turtleneck, medical"
	path = /obj/item/clothing/under/rank/medical/turtleneck
	allowed_roles = list("Chief Medical Officer", "Paramedic", "Medical Doctor", "Psychiatrist", "Field Medic", "Chemist")

//KHI Uniforms
/datum/gear/uniform/job_khi/cmd
	display_name = "Униформа KHI: Управление"
	path = /obj/item/clothing/under/rank/khi/cmd
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_khi/sec
	display_name = "Униформа KHI: СБ"
	path = /obj/item/clothing/under/rank/khi/sec
	allowed_roles = list("Head of Security", "Warden", "Detective", "Security Officer")

/datum/gear/uniform/job_khi/med
	display_name = "Униформа KHI: Врач"
	path = /obj/item/clothing/under/rank/khi/med
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Field Medic")

/datum/gear/uniform/job_khi/eng
	display_name = "Униформа KHI: Инженер"
	path = /obj/item/clothing/under/rank/khi/eng
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer")

/datum/gear/uniform/job_khi/sci
	display_name = "Униформа KHI: Учёный"
	path = /obj/item/clothing/under/rank/khi/sci
	allowed_roles = list("Research Director", "Scientist", "Roboticist", "Xenobiologist", "Xenobotanist")

/datum/gear/uniform/job_khi/crg
	display_name = "khi uniform, cargo"
	path = /obj/item/clothing/under/rank/khi/crg
	allowed_roles = list("Quartermaster", "Cargo Technician", "Shaft Miner")

/datum/gear/uniform/job_khi/civ
	display_name = "khi uniform, civ"
	path = /obj/item/clothing/under/rank/khi/civ

//Federation jackets
/datum/gear/suit/job_fed/sec
	display_name = "Униформа Федерации: СБ"
	path = /obj/item/clothing/suit/storage/fluff/fedcoat
	allowed_roles = list("Head of Security", "Warden", "Detective", "Security Officer")

/datum/gear/suit/job_fed/medsci
	display_name = "Униформа Федерации: Врач, Учёный"
	path = /obj/item/clothing/suit/storage/fluff/fedcoat/fedblue
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist","Xenobotanist","Field Medic")

/datum/gear/suit/job_fed/eng
	display_name = "Униформа Федерации: Инженер"
	path = /obj/item/clothing/suit/storage/fluff/fedcoat/fedeng
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer")

// Trekie things
//TOS
/datum/gear/uniform/job_trek/cmd/tos
	display_name = "Униформа TOS: Управление"
	path = /obj/item/clothing/under/rank/trek/command
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_trek/medsci/tos
	display_name = "Униформа TOS: Врач, Учёный"
	path = /obj/item/clothing/under/rank/trek/medsci
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist", "Field Medic")

/datum/gear/uniform/job_trek/eng/tos
	display_name = "Униформа TOS: Инженер, СБ"
	path = /obj/item/clothing/under/rank/trek/engsec
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Detective","Security Officer","Head of Security")

//TNG
/datum/gear/uniform/job_trek/cmd/tng
	display_name = "Униформа TNG: Управление"
	path = /obj/item/clothing/under/rank/trek/command/next
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_trek/medsci/tng
	display_name = "Униформа TNG: Врач, Учёный"
	path = /obj/item/clothing/under/rank/trek/medsci/next
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist", "Field Medic")

/datum/gear/uniform/job_trek/eng/tng
	display_name = "Униформа TNG: Инженер, СБ"
	path = /obj/item/clothing/under/rank/trek/engsec/next
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Detective","Security Officer","Head of Security")

//VOY
/datum/gear/uniform/job_trek/cmd/voy
	display_name = "Униформа VOY: Управление"
	path = /obj/item/clothing/under/rank/trek/command/voy
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_trek/medsci/voy
	display_name = "Униформа VOY: Врач, Учёный"
	path = /obj/item/clothing/under/rank/trek/medsci/voy
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist", "Field Medic")

/datum/gear/uniform/job_trek/eng/voy
	display_name = "Униформа VOY: Инженер, СБ"
	path = /obj/item/clothing/under/rank/trek/engsec/voy
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Detective","Security Officer","Head of Security")

//DS9

/datum/gear/suit/job_trek/ds9_coat
	display_name = "Шинель DS9 (к униформе)"
	path = /obj/item/clothing/suit/storage/trek/ds9
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director",
						"Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist",
						"Scientist","Roboticist","Xenobiologist","Xenobotanist","Atmospheric Technician",
						"Station Engineer","Warden","Detective","Security Officer", "Pathfinder", "Explorer", "Field Medic")


/datum/gear/uniform/job_trek/cmd/ds9
	display_name = "Униформа DS9: Управление"
	path = /obj/item/clothing/under/rank/trek/command/ds9
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_trek/medsci/ds9
	display_name = "Униформа DS9: Врач, Учёный"
	path = /obj/item/clothing/under/rank/trek/medsci/ds9
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist", "Field Medic")

/datum/gear/uniform/job_trek/eng/ds9
	display_name = "Униформа DS9: Инженер, СБ"
	path = /obj/item/clothing/under/rank/trek/engsec/ds9
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Detective","Security Officer","Head of Security")


//ENT
/datum/gear/uniform/job_trek/cmd/ent
	display_name = "Униформа ENT: Управление"
	path = /obj/item/clothing/under/rank/trek/command/ent
	allowed_roles = list("Head of Security","Site Manager","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer")

/datum/gear/uniform/job_trek/medsci/ent
	display_name = "Униформа ENT: Врач, Учёный"
	path = /obj/item/clothing/under/rank/trek/medsci/ent
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist", "Field Medic")

/datum/gear/uniform/job_trek/eng/ent
	display_name = "Униформа ENT: Инженер, СБ"
	path = /obj/item/clothing/under/rank/trek/engsec/ent
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Detective","Security Officer","Head of Security")
/*
Swimsuits
*/

/datum/gear/uniform/swimsuits
	display_name = "Купальник (выбор)"
	path = /obj/item/weapon/storage/box/fluff/swimsuit

/datum/gear/uniform/swimsuits/New()
	..()
	var/list/swimsuits = list()
	for(var/swimsuit in typesof(/obj/item/weapon/storage/box/fluff/swimsuit))
		var/obj/item/weapon/storage/box/fluff/swimsuit/swimsuit_type = swimsuit
		swimsuits[initial(swimsuit_type.name)] = swimsuit_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(swimsuits))

/datum/gear/uniform/suit/gnshorts
	display_name = "Шорты, с ремнём"
	path = /obj/item/clothing/under/fluff/gnshorts

//Latex maid dress
/datum/gear/uniform/latexmaid
	display_name = "Униформа горничной, латекс"
	path = /obj/item/clothing/under/fluff/latexmaid

//Tron Siren outfit
/datum/gear/uniform/siren
	display_name = "Комбинезон, футуристический"
	path = /obj/item/clothing/under/fluff/siren

/datum/gear/uniform/suit/v_nanovest
	display_name = "Наножилет Varmacorp"
	path = /obj/item/clothing/under/fluff/v_nanovest

/*
Qipao
*/
/datum/gear/uniform/qipao
	display_name = "Ципао, черное"
	path = /obj/item/clothing/under/dress/qipao

/datum/gear/uniform/qipao_red
	display_name = "Ципао, красное"
	path = /obj/item/clothing/under/dress/qipao/red

/datum/gear/uniform/qipao_white
	display_name = "Ципао, белое"
	path = /obj/item/clothing/under/dress/qipao/white

/*
Bluespace jumpsuit
*/
/datum/gear/uniform/hfjumpsuit
	display_name = "HYPER jumpsuit"
	path = /obj/item/clothing/under/hyperfiber
	cost = 2