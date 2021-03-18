//////////////////////////////////
//		Chief Medical Officer
//////////////////////////////////
/datum/job/cmo
	title = "Chief Medical Officer"
	flag = CMO
	departments_managed = list(DEPARTMENT_MEDICAL)
	departments = list(DEPARTMENT_MEDICAL, DEPARTMENT_COMMAND)
	sorting_order = 2
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Директором колонии"
	selection_color = "#026865"
	req_admin_notify = 1
	economic_modifier = 10
	access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks, access_maint_tunnels)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks, access_maint_tunnels)

	minimum_character_age = 25
	minimal_player_age = 10
	ideal_character_age = 50

	outfit_type = /decl/hierarchy/outfit/job/medical/cmo
	job_description = "Главврач распоряжается медицинским отделом. Для работе на такой должности необходимы опыт и навыки: его задача — \
						поддерживать здоровье и целостность персонала станции. Одной из главных задач главврача является убедиться в обнаружении пациентов и их \
						безопасной транспортировке на лечение в медцентр. От них требуется информировать персонал об угрозах для здоровья, а также о важности нательных датчиков на костюмах."

//////////////////////////////////
//		Medical Doctor
//////////////////////////////////
/datum/job/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	departments = list(DEPARTMENT_MEDICAL)
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "Главврачом"
	selection_color = "#013D3B"
	economic_modifier = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_eva)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_eva)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor
	job_description = "Врач -- общее название всех должностей в медицинском отделе. Врачи обладают обширным набором навыков, \
						включая первую помощь и применение лекарств, а также поддержание здоровья (или даже полное лечение) пациентов."
	alt_titles = list(
					"Surgeon" = /datum/alt_title/surgeon,
					"Emergency Physician" = /datum/alt_title/emergency_physician,
					"Nurse" = /datum/alt_title/nurse,
					"Virologist" = /datum/alt_title/virologist)

//Medical Doctor Alt Titles
/datum/alt_title/surgeon
	title = "Surgeon"
	title_blurb = "Хирург специализируется на оказании хирургической помощи травмированным пациентам. В это входят ампутация и восстановление конечностей. \
					От них ожидается доскональное знание хирургии и анестезии."
	title_outfit = /decl/hierarchy/outfit/job/medical/doctor/surgeon

/datum/alt_title/emergency_physician
	title = "Emergency Physician"
	title_blurb = "Врач скорой помощи специлализируется на оказании неотложной помощи по прибытии травмированного или умирающего пациента в медцентр. \
					Он поддерживает пациента в стабильном состоянии и может помочь ему полностью восстановиться."
	title_outfit = /decl/hierarchy/outfit/job/medical/doctor/emergency_physician

/datum/alt_title/nurse
	title = "Nurse"
	title_blurb = "Медсестра в первую очередь оказывает помощь врачам, заботясь о пациентах, не пребывающих в критическом состоянии, \
					и стабилизируя состояние остальных в случае высокой нагрузки на медцентр. Она периодически проверяет консоль датчиков, позволяя врачам не тратить на это время. \
					В редких случаях медсестру могут вызвать для проведения воскрешения погибшего члена экипажа."
	title_outfit = /decl/hierarchy/outfit/job/medical/doctor/nurse

/datum/alt_title/virologist
	title = "Virologist"
	title_blurb = "Вирусолог отвечает за излечение персонала от болезней и приготовление антител для предупреждения их возникновения. \
					Они также обладают навыками, необходимыми для изготовления мутагенов и вирусной пищи."
	title_outfit = /decl/hierarchy/outfit/job/medical/doctor/virologist

//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
//////////////////////////////////
//			Chemist
//////////////////////////////////
/datum/job/chemist
	title = "Chemist"
	flag = CHEMIST
	departments = list(DEPARTMENT_MEDICAL)
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главврачом"
	selection_color = "#013D3B"
	economic_modifier = 5
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_chemistry)
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/medical/chemist
	job_description = "Химик отвечает за изготовление как простых, так и сложных химикатов, необходимых для медцентра и, иногда, отдела исследований. \
						От них ожидается понимание назначения лекарств и прочих химикатов, а также знание о связанных с ними опасностях."
	alt_titles = list("Pharmacist" = /datum/alt_title/pharmacist)

// Chemist Alt Titles
/datum/alt_title/pharmacist
	title = "Pharmacist"
	title_blurb = "Фармацевт специализируется на изготовлении лекарств и выдаче таковых персоналу по рецепту."

/* I'm commenting out Geneticist so you can't actually see it in the job menu, given that you can't play as one - Jon.
//////////////////////////////////
//			Geneticist
//////////////////////////////////
/datum/job/geneticist
	title = "Geneticist"
	flag = GENETICIST
	departments = list(DEPARTMENT_MEDICAL, DEPARTMENT_RESEARCH)
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the Chief Medical Officer and Research Director"
	selection_color = "#013D3B"
	economic_modifier = 7
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_research)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_research)

	outfit_type = /decl/hierarchy/outfit/job/medical/geneticist
	job_description = "A Geneticist operates genetic manipulation equipment to repair any genetic defects encountered in crew, from cloning or radiation as examples. \
						When required, geneticists have the skills to clone, and are the superior choice when available for doing so."
*/

//////////////////////////////////
//			Psychiatrist
//////////////////////////////////
/datum/job/psychiatrist
	title = "Psychiatrist"
	flag = PSYCHIATRIST
	departments = list(DEPARTMENT_MEDICAL)
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	supervisors = "Главврачом"
	selection_color = "#013D3B"
	access = list(access_medical, access_medical_equip, access_morgue, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	outfit_type = /decl/hierarchy/outfit/job/medical/psychiatrist
	job_description = "Психиатр оказывает душевную помощь тем, кто в ней нуждается. Психиатр может вызван для диагностики душевных заболеваний, \
					порой под присмотром службы безопасности. Психиатр ознакомлен с психоактивными лекарствами."
	alt_titles = list("Psychologist" = /datum/alt_title/psychologist)

//Psychiatrist Alt Titles
/datum/alt_title/psychologist
	title = "Psychologist"
	title_blurb = "Психолог специализируется в первую очередь на беседах, нежели на лекарствах."
	title_outfit = /decl/hierarchy/outfit/job/medical/psychiatrist/psychologist

//////////////////////////////////
//			Paramedic
//////////////////////////////////
/datum/job/paramedic
	title = "Paramedic"
	flag = PARAMEDIC
	departments = list(DEPARTMENT_MEDICAL)
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главврачом"
	selection_color = "#013D3B"
	economic_modifier = 4
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva, access_maint_tunnels, access_external_airlocks, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/medical/paramedic
	job_description = "Парамедик в первую очередь заботится о спасении пациентов, которые не способны добраться до медбея самостоятельно. \
						Они также могут оказать им медицинскую помощь при недостаче кадров или повышенной нагрузке на медцентр."
	alt_titles = list("Emergency Medical Technician" = /datum/alt_title/emt)

// Paramedic Alt Titles
/datum/alt_title/emt
	title = "Emergency Medical Technician"
	title_blurb = "Чаще всего, фельшеры заботятся о состоянии пациента, пока не появится возможность передать его в более опытные руки."
	title_outfit = /decl/hierarchy/outfit/job/medical/paramedic/emt