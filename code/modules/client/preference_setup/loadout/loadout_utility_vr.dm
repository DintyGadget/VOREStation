/datum/gear/utility/saddlebag
	display_name = "Седло с сумкой, лошадь"
	path = /obj/item/weapon/storage/backpack/saddlebag
	slot = slot_back
	cost = 2

/datum/gear/utility/saddlebag_common
	display_name = "Седло с сумкой, обычное"
	path = /obj/item/weapon/storage/backpack/saddlebag_common
	slot = slot_back
	cost = 2

/datum/gear/utility/saddlebag_common/robust
	display_name = "Седло с сумкой, прочное"
	path = /obj/item/weapon/storage/backpack/saddlebag_common/robust
	slot = slot_back
	cost = 2

/datum/gear/utility/saddlebag_common/vest
	display_name = "Тавровый рабочий жилет (рюкзак)"
	path = /obj/item/weapon/storage/backpack/saddlebag_common/vest
	slot = slot_back
	cost = 1

/datum/gear/utility/dufflebag
	display_name = "Сумка, спортивная"
	path = /obj/item/weapon/storage/backpack/dufflebag
	slot = slot_back
	cost = 2

/datum/gear/utility/dufflebag/black
	display_name = "Спортивная сумка, черная"
	path = /obj/item/weapon/storage/backpack/dufflebag/fluff

/datum/gear/utility/dufflebag/med
	display_name = "Спортивная сумка, медицинская"
	path = /obj/item/weapon/storage/backpack/dufflebag/med
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist","Psychiatrist","Field Medic")

/datum/gear/utility/dufflebag/med/emt
	display_name = "Спортивная сумка, парамедик"
	path = /obj/item/weapon/storage/backpack/dufflebag/emt

/datum/gear/utility/dufflebag/sec
	display_name = "Спортивная сумка, СБ"
	path = /obj/item/weapon/storage/backpack/dufflebag/sec
	allowed_roles = list("Head of Security","Warden","Detective","Security Officer")

/datum/gear/utility/dufflebag/eng
	display_name = "Спортивная сумка, инженерная"
	path = /obj/item/weapon/storage/backpack/dufflebag/eng
	allowed_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer")

/datum/gear/utility/dufflebag/sci
	display_name = "Спортивная сумка, научная"
	path = /obj/item/weapon/storage/backpack/dufflebag/sci
	allowed_roles = list("Research Director","Scientist","Roboticist","Xenobiologist","Xenobotanist","Explorer","Pathfinder")
