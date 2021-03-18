//////////////////////////////////
//		Chief Engineer
//////////////////////////////////
/datum/job/chief_engineer
	title = "Chief Engineer"
	flag = CHIEF
	departments_managed = list(DEPARTMENT_ENGINEERING)
	departments = list(DEPARTMENT_ENGINEERING, DEPARTMENT_COMMAND)
	sorting_order = 2
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Директором Колонии"
	selection_color = "#7F6E2C"
	req_admin_notify = 1
	economic_modifier = 10

	minimum_character_age = 25
	ideal_character_age = 50


	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_player_age = 7

	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer
	job_description = "Главный инженер отвечает за весь Инженерный отдел, в том числе и за его ресурсы и работоспособность. \
						От них ожидается быстрое реагирование на структурные повреждения станции, которые могут быть опасны для работы экипажа, и своевременное о них информирование."

//////////////////////////////////
//			Engineer
//////////////////////////////////
/datum/job/engineer
	title = "Station Engineer"
	flag = ENGINEER
	departments = list(DEPARTMENT_ENGINEERING)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "Главным инженером"
	selection_color = "#5B4D20"
	economic_modifier = 5
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction)
	alt_titles = list("Maintenance Technician" = /datum/alt_title/maint_tech,
						"Engine Technician" = /datum/alt_title/engine_tech, "Electrician" = /datum/alt_title/electrician)

	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer
	job_description = "Благодаря инженеру на станции горит свет. Он чинит повреждения, поддерживает стабильную вентиляцию и отвечает за запуск двигателя. \
						На тихих сменах инженера можно попросить помочь со строительством."

// Engineer Alt Titles
/datum/alt_title/maint_tech
	title = "Maintenance Technician"
	title_blurb = "Ремонтник, по сути -- младший инженер, и на него обычно сваливают мелкие вещи, которыми сами инженеры заниматься не хотят."

/datum/alt_title/engine_tech
	title = "Engine Technician"
	title_blurb = "Инженер двигателей отвечает за работу двигателя, чаще всего -- кристалла суперматерии или двигателя на основе катушек Теслы. \
					От них ожидается обеспечение стабильной работы двигателей, и иногда даже их разгон до более высоких уровней."

/datum/alt_title/electrician
	title = "Electrician"
	title_blurb = "Основная цель электрика -- обеспечение правильного распределения по станции электроэнергии при помощи солнечных панелей, подстанций и других методов, позволяющих \
					не оставить ни один отдел без света в случае экстренной ситуации."

//////////////////////////////////
//			Atmos Tech
//////////////////////////////////
/datum/job/atmos
	title = "Atmospheric Technician"
	flag = ATMOSTECH
	departments = list(DEPARTMENT_ENGINEERING)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "Главным инженером"
	selection_color = "#5B4D20"
	economic_modifier = 5
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_external_airlocks)
	minimal_access = list(access_eva, access_engine, access_atmospherics, access_maint_tunnels, access_emergency_storage, access_construction, access_external_airlocks)

	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/engineering/atmos
	job_description = "Атмосферный техник отвечает за вопросы касательно вентиляции и распределения по станции газов, обеспечивая стабильные рабочие условия. \
						От них ожидается хорошее понимание труб, вентиляции и скрубберов, которые перемещают по станции газы, а также порядка действий при пожарах."
