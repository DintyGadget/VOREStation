/datum/job/bartender
	pto_type = PTO_CIVILIAN
	alt_titles = list("Barkeeper" = /datum/alt_title/barkeeper, "Barmaid" = /datum/alt_title/barmaid, "Barista" = /datum/alt_title/barista, "Mixologist" = /datum/alt_title/mixologist)

/datum/alt_title/barkeeper
	title = "Barkeeper"

/datum/alt_title/barmaid
	title = "Barmaid"

/datum/alt_title/mixologist
	title = "Mixologist"


/datum/job/chef
	total_positions = 2 //IT TAKES A LOT TO MAKE A STEW
	spawn_positions = 2 //A PINCH OF SALT AND LAUGHTER, TOO
	pto_type = PTO_CIVILIAN
	alt_titles = list("Sous-chef" = /datum/alt_title/souschef,"Cook" = /datum/alt_title/cook, "Kitchen Worker" = /datum/alt_title/kitchen_worker)

/datum/alt_title/souschef
	title = "Sous-chef"

/datum/alt_title/kitchen_worker
	title = "Kitchen Worker"
	title_blurb = "Кухонный работник выполняет те же обязанности, что и повар, однако менее опытен."


/datum/job/hydro
	spawn_positions = 2
	pto_type = PTO_CIVILIAN
	alt_titles = list("Hydroponicist" = /datum/alt_title/hydroponicist, "Cultivator" = /datum/alt_title/cultivator, "Farmer" = /datum/alt_title/farmer,
						"Gardener" = /datum/alt_title/gardener, "Florist" = /datum/alt_title/florsit)

/datum/alt_title/hydroponicist
	title = "Hydroponicist"

/datum/alt_title/cultivator
	title = "Cultivator"

/datum/alt_title/farmer
	title = "Farmer"

/datum/alt_title/florsit
	title = "Florist"
	title_blurb = "Флорист менее опытен, и, вероятнее всего, присматривает за общим ботаническим садом, если от него ничего не требуется."


/datum/job/qm
	pto_type = PTO_CARGO
	dept_time_required = 20
	alt_titles = list("Supply Chief" = /datum/alt_title/supply_chief, "Logistics Manager" = /datum/alt_title/logistics_manager)

/datum/alt_title/logistics_manager
	title = "Logistics Manager"


/datum/job/cargo_tech
	total_positions = 3
	spawn_positions = 3
	pto_type = PTO_CARGO
	alt_titles = list("Cargo Loader" = /datum/alt_title/cargo_loader, "Cargo Handler" = /datum/alt_title/cargo_handler, "Supply Courier" = /datum/alt_title/supply_courier,
					"Disposals Sorter" = /datum/alt_title/disposal_sorter)

/datum/alt_title/supply_courier
	title = "Supply Courier"
	title_blurb = "На плечи курьера обычно возлагается обязанность доставлять полученный груз по месту назначения."

/datum/alt_title/cargo_loader
	title = "Cargo Loader"
	title_blurb = "Погрузчик обычно занимается более скучной работой в отделе снабжения - разгрузкой и возвратом ящиков."

/datum/alt_title/cargo_handler
	title = "Cargo Handler"
	title_blurb = "Поставщик груза обычно занимается более скучной работой в отделе снабжения - разгрузкой и возвратом ящиков."

/datum/alt_title/disposal_sorter
	title = "Disposals Sorter"
	title_blurb = "Сортировщик обычно занимается сортировкой того, что приходит по трубам, а также доставкой посылок в нужные отделы."


/datum/job/mining
	total_positions = 4
	spawn_positions = 4
	pto_type = PTO_CARGO
	alt_titles = list("Deep Space Miner" = /datum/alt_title/deep_space_miner, "Drill Technician" = /datum/alt_title/drill_tech, "Prospector" = /datum/alt_title/prospector)

/datum/alt_title/deep_space_miner
	title = "Deep Space Miner"
	title_blurb = "Шахтёр астероидов специализируется на добыче руд в вакууме, а именно на астероидах."

/datum/alt_title/prospector
	title = "Prospector"


/datum/job/janitor //Lots of janitor substations on station.
	total_positions = 3
	spawn_positions = 3
	pto_type = PTO_CIVILIAN
	alt_titles = list("Custodian" = /datum/alt_title/custodian, "Sanitation Technician" = /datum/alt_title/sanitation_tech,
					"Maid" = /datum/alt_title/maid, "Garbage Collector" = /datum/alt_title/garbage_collector)

/datum/alt_title/sanitation_tech
	title = "Sanitation Technician"

/datum/alt_title/maid
	title = "Maid"

/datum/alt_title/garbage_collector
	title = "Garbage Collector"
	title_blurb = "Мусорщик специализируется на более крупном мусоре. Влажная чистка для него на втором плане."


/datum/job/librarian
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Journalist" = /datum/alt_title/journalist, "Reporter" =  /datum/alt_title/reporter, "Writer" = /datum/alt_title/writer,
					"Historian" = /datum/alt_title/historian, "Archivist" = /datum/alt_title/archivist, "Professor" = /datum/alt_title/professor,
					"Academic" = /datum/alt_title/academic, "Philosopher" = /datum/alt_title/philosopher)
	pto_type = PTO_CIVILIAN

/datum/alt_title/reporter
	title = "Reporter"
	title_blurb = "Репортёр использует библиотеку как оперативную базу, откуда он может сообщать новости и происходящее на станции с помощью своей камеры."

/datum/alt_title/historian
	title = "Historian"
	title_blurb = "Историк использует библиотеку в качестве своей базы для записи важных событий, происходящих на станции."

/datum/alt_title/archivist
	title = "Archivist"
	title_blurb = "Архивист использует библиотеку в качестве своей базы для записи важных событий, происходящих на станции."

/datum/alt_title/professor
	title = "Professor"
	title_blurb = "Профессор использует библиотеку как персональную аудиторию для просвещения экипажа."

/datum/alt_title/academic
	title = "Academic"
	title_blurb = "Преподаватель использует библиотеку как персональную аудиторию для просвещения экипажа."

/datum/alt_title/philosopher
	title = "Philosopher"
	title_blurb = "Философ использует библиотеку как форум для рассуждений о величайших вопросах жизни и их обсуждения с экипажем."


/datum/job/lawyer
	disallow_jobhop = TRUE
	pto_type = PTO_CIVILIAN
	alt_titles = list("Internal Affairs Liaison" = /datum/alt_title/ia_liaison, "Internal Affairs Delegate" = /datum/alt_title/ia_delegate,
						"Internal Affairs Investigator" = /datum/alt_title/ia_investigator)

/datum/alt_title/ia_liaison
	title = "Internal Affairs Liaison"

/datum/alt_title/ia_delegate
	title = "Internal Affairs Delegate"

/datum/alt_title/ia_investigator
	title = "Internal Affairs Investigator"


/datum/job/chaplain
	pto_type = PTO_CIVILIAN
	alt_titles = list("Missionary" = /datum/alt_title/missionary, "Preacher" = /datum/alt_title/preacher, "Counselor" = /datum/alt_title/counselor, "Guru" = /datum/alt_title/guru)

/datum/alt_title/guru
	title = "Guru"
	title_blurb = "Гуру в общих чертах предоставляет духовный совет тем, кто в нём нуждается."

/datum/alt_title/missionary
	title = "Missionary"

/datum/alt_title/preacher
	title = "Preacher"



//////////////////////////////////
//			Entertainer
//////////////////////////////////

/datum/job/entertainer
	title = "Entertainer"
	flag = ENTERTAINER
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "Главой персонала"
	selection_color = "#515151"
	access = list(access_entertainment)
	minimal_access = list(access_entertainment)
	pto_type = PTO_CIVILIAN

	outfit_type = /decl/hierarchy/outfit/job/assistant/entertainer
	job_description = "Аниматор отвечает за развлечение персонала! Ставьте спектакли, играйте музыку, пойте песни, рассказывайте истории или читайте свои любимые фанфики."
	alt_titles = list("Performer" = /datum/alt_title/performer, "Musician" = /datum/alt_title/musician, "Stagehand" = /datum/alt_title/stagehand,
						"Actor" = /datum/alt_title/actor, "Dancer" = /datum/alt_title/dancer, "Singer" = /datum/alt_title/singer,
						"Magician" = /datum/alt_title/magician, "Comedian" = /datum/alt_title/comedian, "Tragedian" = /datum/alt_title/tragedian)

// Entertainer Alt Titles
/datum/alt_title/actor
	title = "Actor"
	title_blurb = "Актёр отыгрывает роли! Каким бы ни был его персонаж, он должен полностью в него влиться и впечатлять людей силой трагедии и комедии!"

/datum/alt_title/performer
	title = "Performer"
	title_blurb = "Артист - понятие растяжимое! Актерское мастерство, танцы, вокал и так далее!"

/datum/alt_title/musician
	title = "Musician"
	title_blurb = "Музыкант - это тот, кто создаёт музыку! Петь, играть на музыкальных инструментах, слогать стихами - это ваше дело!"

/datum/alt_title/stagehand
	title = "Stagehand"
	title_blurb = "Рабочий сцены обычно выполняет все, что не делают остальные артисты: управляет светом, ставнями, окнами или рассказывает что-либо через микрофон на сцену!"

/datum/alt_title/dancer
	title = "Dancer"
	title_blurb = "Танцор впечатляет людей своим телом! От вальса до брейкданса, лишь бы публика была довольна."

/datum/alt_title/singer
	title = "Singer"
	title_blurb = "Певец одарён мелодичным голосом! Впечатлите людей своим вокалом!"

/datum/alt_title/magician
	title = "Magician"
	title_blurb = "Фокусник поражает своих зрителей невозможными трюками. Демонстрируйте свой репертуар, оставляя секрет фокусов за кулисами!"

/datum/alt_title/comedian
	title = "Comedian"
	title_blurb = "Комедиант поднимает людям настроение при помощи юмора и острого ума! Анекдоты, стендапы, лишь бы люди улыбались!"

/datum/alt_title/tragedian
	title = "Tragedian"
	title_blurb = "Трагик специализируется на донесении до людей мыслей о жизни и о мире вокруг них самих. Жизнь - трагедия, и кто же лучше Вас передаст её эмоции?"