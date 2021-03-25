/datum/gear/utility/implant
	display_name = "имплант, сеть нейронной помощи"
	description = "Сложная сеть имплантируется субъекту с медицинской точки зрения, чтобы компенсировать неврологическое заболевание."
	path = /obj/item/weapon/implant/neural
	slot = "implant"
	exploitable = 1
	sort_category = "Импланты"
	cost = 6

/datum/gear/utility/implant/tracking
	display_name = "имплант, трекер"
	path = /obj/item/weapon/implant/tracking/weak
	cost = 0 //VOREStation Edit. Changed cost to 0

// Remove these after generic implant has been in for awhile and everyone has had a reasonable period to copy their old descs.
/datum/gear/utility/implant/dud1
	display_name = "имплант, голова"
	description = "Имплант без очевидной цели (УСТАРЕВШИЙ, ИСПОЛЬЗУЙТЕ ОБЩИЙ ИМПЛАНТ)."
	path = /obj/item/weapon/implant/dud
	cost = 1
/datum/gear/utility/implant/dud2
	display_name = "имплант, торс"
	description = "Имплант без очевидной цели (УСТАРЕВШИЙ, ИСПОЛЬЗУЙТЕ ОБЩИЙ ИМПЛАНТ)."
	path = /obj/item/weapon/implant/dud/torso
	cost = 1
// End removal marker.

/datum/gear/utility/implant/generic
	display_name = "имплантат, универсальный, первичный"
	description = "Имплант без очевидной цели."
	path = /obj/item/weapon/implant
	cost = 1

/datum/gear/utility/implant/generic/second
	display_name = "имплантат, универсальный, вторичный"

/datum/gear/utility/implant/generic/third
	display_name = "имплантат, универсальный, третичный"

/datum/gear/utility/implant/generic/New()
	..()
	gear_tweaks += global.gear_tweak_implant_location

/datum/gear/utility/implant/language
	cost = 2
	exploitable = 0

/datum/gear/utility/implant/language/eal
	display_name = "вокальный синтезатор, EAL"
	description = "Хирургически имплантированный вокальный синтезатор, который позволяет владельцу говорить на EAL, если они его знают."
	path = /obj/item/weapon/implant/language/eal

/datum/gear/utility/implant/language/skrellian
	display_name = "вокальный синтезатор, Скреллиан"
	description = "Хирургически имплантированный вокальный синтезатор, который позволяет владельцу говорить на общем скреллианском языке, если они его знают."
	path = /obj/item/weapon/implant/language/skrellian
