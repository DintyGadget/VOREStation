/datum/gear/eyes/medical
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist", "Field Medic")

/datum/gear/eyes/meson
	display_name = "Оптический мезонный сканер (Инж, Науч)"
	allowed_roles = list("Station Engineer","Chief Engineer","Atmospheric Technician", "Scientist", "Research Director", "Explorer", "Pathfinder")

/datum/gear/eyes/arglasses
	display_name = "AR-очки"
	path = /obj/item/clothing/glasses/omnihud

/datum/gear/eyes/arglassespres
	display_name = "AR-очки, (близ.)"
	path = /obj/item/clothing/glasses/omnihud/prescription

/datum/gear/eyes/arglasses/sec
	display_name = "AR-S очки (СБ)"
	path = /obj/item/clothing/glasses/omnihud/sec
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective")

/datum/gear/eyes/arglasses/sci
	display_name = "AR-R очки (Учёный)"
	path = /obj/item/clothing/glasses/omnihud/rnd
	allowed_roles = list("Research Director","Scientist","Xenobiologist","Xenobotanist","Roboticist")

/datum/gear/eyes/arglasses/eng
	display_name = "AR-E очки (Инженер)"
	path = /obj/item/clothing/glasses/omnihud/eng
	allowed_roles = list("Station Engineer","Chief Engineer","Atmospheric Technician")

/datum/gear/eyes/arglasses/med
	display_name = "AR-M очки (Врач)"
	path = /obj/item/clothing/glasses/omnihud/med
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist", "Field Medic")

/datum/gear/eyes/arglasses/all
	display_name = "AR-B очки (ДК, ГП)"
	path = /obj/item/clothing/glasses/omnihud/all
	cost = 2
	allowed_roles = list("Site Manager","Head of Personnel")

/datum/gear/eyes/spiffygogs
	display_name = "Стильные оранжевые очки"
	path = /obj/item/clothing/glasses/fluff/spiffygogs

/datum/gear/eyes/science_proper
	display_name = "Научные очки (без оверлея)"
	path = /obj/item/clothing/glasses/fluff/science_proper

/datum/gear/eyes/meson/retinal
	display_name = "Ретинальный проектор (Инж, Науч, Шахт)"
	path = /obj/item/clothing/glasses/omnihud/eng/meson

/datum/gear/eyes/security/secpatch
	display_name = "Служба Безопасности: HUD-повязка"
	path = /obj/item/clothing/glasses/hud/security/eyepatch

/datum/gear/eyes/medical/medpatch
	display_name = "Врач: HUD-повязка"
	path = /obj/item/clothing/glasses/hud/health/eyepatch
