//Food

//////////////////////////////////
//			Bartender
//////////////////////////////////

/datum/job/bartender
	title = "Bartender"
	flag = BARTENDER
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главой персонала"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar)

	outfit_type = /decl/hierarchy/outfit/job/service/bartender
	job_description = "Бармен смешивает напитки для экипажа. Как правило, бармену не следует перебарщивать с обслуживанием ответственных лиц, а также ему разрешено отказать в заказе."
	alt_titles = list("Barista" = /datum/alt_title/barista)

// Bartender Alt Titles
/datum/alt_title/barista
	title = "Barista"
	title_blurb = "Бариста управляет кофейней, в которой подаются исключительно безалкогольные напитки."
	title_outfit = /decl/hierarchy/outfit/job/service/bartender/barista

//////////////////////////////////
//			   Chef
//////////////////////////////////

/datum/job/chef
	title = "Chef"
	flag = CHEF
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главой персонала"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)

	outfit_type = /decl/hierarchy/outfit/job/service/chef
	job_description = "Шеф-повар управляет кухней и отвечает за кормление всего экипажа."
	alt_titles = list("Cook" = /datum/alt_title/cook)

// Chef Alt Titles
/datum/alt_title/cook
	title = "Cook"
	title_blurb = "Обязанности повара точно такие же, однако он может быть менее опытным."

//////////////////////////////////
//			Botanist
//////////////////////////////////

/datum/job/hydro
	title = "Botanist"
	flag = BOTANIST
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главой персонала"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_hydroponics)

	outfit_type = /decl/hierarchy/outfit/job/service/gardener
	job_description = "Ботаник отвечает за ботанический сад, в котором он выращивает необходимые для шеф-повару и бармену травы, фрукты и овощи."
	alt_titles = list("Gardener" = /datum/alt_title/gardener)

//Botanist Alt Titles
/datum/alt_title/gardener
	title = "Gardener"
	title_blurb = "Садовник обычно менее опытен, чем ботаник, и, если от него больше ничего не требуется, он отвечает за поддержание частоты в гидропоническом саду."

//Cargo
//////////////////////////////////
//			Quartermaster
//////////////////////////////////
/datum/job/qm
	title = "Quartermaster"
	flag = QUARTERMASTER
	departments = list(DEPARTMENT_CARGO)
	sorting_order = 1 // QM is above the cargo techs, but below the HoP.
	departments_managed = list(DEPARTMENT_CARGO)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Главой персонала"
	selection_color = "#9b633e"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)

	ideal_character_age = 40

	outfit_type = /decl/hierarchy/outfit/job/cargo/qm
	job_description = "Квартирмейстер управляет отделом снабжения, проверяя заказы на поставку грузов и обеспечивая их доставку туда, где они необходимы."
	alt_titles = list("Supply Chief" = /datum/alt_title/supply_chief)

// Quartermaster Alt Titles
/datum/alt_title/supply_chief
	title = "Supply Chief"

//////////////////////////////////
//			Cargo Tech
//////////////////////////////////
/datum/job/cargo_tech
	title = "Cargo Technician"
	flag = CARGOTECH
	departments = list(DEPARTMENT_CARGO)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Квартирмейстером и Главой персонала"
	selection_color = "#7a4f33"
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)

	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech
	job_description = "Грузовой техник заполняет и доставляет заказы на груз. Им рекомендуется вернуть доставленные ящики в грузовой шаттл, \
						потому что Центральное Командование дает за это частичный возврат денег."

//////////////////////////////////
//			Shaft Miner
//////////////////////////////////

/datum/job/mining
	title = "Shaft Miner"
	flag = MINER
	departments = list(DEPARTMENT_CARGO)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Квартирмейстером и Главой персонала"
	selection_color = "#7a4f33"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_mining, access_mining_station, access_mailsorting)

	outfit_type = /decl/hierarchy/outfit/job/cargo/mining
	job_description = "Шахтёр добывает и перерабатывает полезные ископаемые для доставки в те отделы, которые в них нуждаются."
	alt_titles = list("Drill Technician" = /datum/alt_title/drill_tech)

/datum/alt_title/drill_tech
	title = "Бурильщик специализируется на эксплуатации и обслуживании оборудования, необходимого для извлечения руды из жил глубоко под поверхностью."

//Service
//////////////////////////////////
//			Janitor
//////////////////////////////////
/datum/job/janitor
	title = "Janitor"
	flag = JANITOR
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Главой персонала"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels)
	minimal_access = list(access_janitor, access_maint_tunnels)

	outfit_type = /decl/hierarchy/outfit/job/service/janitor
	job_description = "Уборщик следит за чистотой колонии, за исключением случаев, когда это место активное место преступления."
	alt_titles = list("Custodian" = /datum/alt_title/custodian)

// Janitor Alt Titles
/datum/alt_title/custodian
	title = "Custodian"

//More or less assistants
//////////////////////////////////
//			Librarian
//////////////////////////////////
/datum/job/librarian
	title = "Librarian"
	flag = LIBRARIAN
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Главой Персонала"
	selection_color = "#515151"
	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)

	outfit_type = /decl/hierarchy/outfit/job/librarian
	job_description = "Библиотекарь курирует выбор книг в библиотеке, чтобы экипаж мог приятно провести время за чтением или обучением."
	alt_titles = list("Journalist" = /datum/alt_title/journalist, "Writer" = /datum/alt_title/writer)

// Librarian Alt Titles
/datum/alt_title/journalist
	title = "Journalist"
	title_outfit = /decl/hierarchy/outfit/job/librarian/journalist
	title_blurb = "Журналист использует библиотеку как оперативную базу, откуда он может сообщать новости и происходящее на станции с помощью своей камеры."

/datum/alt_title/writer
	title = "Writer"
	title_blurb = "Писатель использует библиотеку как тихое место, чтобы заниматься написанием книг."

//////////////////////////////////
//		Internal Affairs Agent
//////////////////////////////////

//var/global/lawyer = 0//Checks for another lawyer //This changed clothes on 2nd lawyer, both IA get the same dreds.
/datum/job/lawyer
	title = "Internal Affairs Agent"
	flag = LAWYER
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "должностными лицами компании NT и Корпоративным Регулированием"
	selection_color = "#515151"
	economic_modifier = 7
	access = list(access_lawyer, access_sec_doors, access_maint_tunnels, access_heads)
	minimal_access = list(access_lawyer, access_sec_doors, access_heads)
	minimal_player_age = 7

	outfit_type = /decl/hierarchy/outfit/job/internal_affairs_agent
	job_description = "Агент внутренних дел следит за тем, чтобы экипаж следовал Стандартному Проведению Операций. Он также \
						обрабатывает жалобы на членов экипажа и могут ставить о них в известность Центральное Командование \
						при наличии должных документов."

/*
/datum/job/lawyer/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)
*/
