/datum/job/chief_engineer
	disallow_jobhop = TRUE
	pto_type = PTO_ENGINEERING
	dept_time_required = 60

	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload, access_gateway)

	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload, access_gateway)
	alt_titles = list("Head Engineer" = /datum/alt_title/head_engineer, "Foreman" = /datum/alt_title/foreman, "Maintenance Manager" = /datum/alt_title/maintenance_manager)

/datum/alt_title/head_engineer
	title = "Head Engineer"

/datum/alt_title/foreman
	title = "Foreman"

/datum/alt_title/maintenance_manager
	title = "Maintenance Manager"


/datum/job/engineer
	pto_type = PTO_ENGINEERING
	alt_titles = list("Maintenance Technician" = /datum/alt_title/maint_tech, "Engine Technician" = /datum/alt_title/engine_tech,
						"Electrician" = /datum/alt_title/electrician, "Construction Engineer" = /datum/alt_title/construction_engi)

/datum/alt_title/construction_engi
	title = "Construction Engineer"
	title_blurb = "Инженер-конструктор имеет схожие обязанности с остальными инженерами, но обычно проводит свободное время за постройкой дополнительных комнат \
					и ремонтом заброшенных мест."



/datum/job/atmos
	spawn_positions = 3
	pto_type = PTO_ENGINEERING
	alt_titles = list("Atmospheric Engineer" = /datum/alt_title/atmos_engi, "Atmospheric Maintainer" = /datum/alt_title/atmos_maint, "Disposals Technician" = /datum/alt_title/disposals_tech)

/datum/alt_title/atmos_maint
	title = "Atmospheric Maintainer"

/datum/alt_title/atmos_engi
	title = "Atmospheric Engineer"

/datum/alt_title/disposals_tech
	title = "Disposals Technician"
	title_blurb = "Заведующий по выбросам занимается тем же, что и атмосферный техник, однако специализируется на работе системы выбросов."