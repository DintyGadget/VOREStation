/datum/species/sergal
	name = SPECIES_SERGAL
	name_plural = "Sergals"
	icobase = 'icons/mob/human_races/r_sergal.dmi'
	deform = 'icons/mob/human_races/r_def_sergal.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	//darksight = 8
	//slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_SAGARU)
	name_language = LANGUAGE_SAGARU
	color_mult = 1

	min_age = 18
	max_age = 80

	blurb = "Выделяют два подвида Сергалов: южные и северные. Северные сергалы - крайне агрессивная раса, \
	проживающая на равнинах и тундрах родной планеты. Они обладают продолговатым пушистым телом холодных цветов: \
	преимущественно белые животы, коротковатые уши и пухлые лица. Южные сергалы гораздо более миролюбивые, и\
	живут в основном в Городе Золотого Кольца, а также по окрестностям сельских земель и в маленьких городах. Обычно имеют короткую шерсть \
	желтого или коричневого (или другого 'земляного') цвета, длинные уши и лицо, ростом ниже своих северных соседей. Оба подвида \
	страдают от расовых междуособиц, что привело к большому количеству воин и даже попыток совершить геноцид. \
	Сергалы обладают высокой средней продолжительностью жизни, однако в связи со своей склонности к насилию, лишь немногие доживают до 80. \
	Легендарный сергальский Генерал Райн Сильвис прожил более 5000 лет."

	wikilink="https://wiki.vore-station.net/Backstory#Sergal"

	catalogue_data = list(/datum/category_item/catalogue/fauna/sergal)

	primitive_form = "Saru"

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#777777"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	heat_discomfort_strings = list(
		"Ваша шерсть колется на жаре.",
		"Вы ощущаете некомфортное тепло.",
		"Ваша перегретая кожа чешется."
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/sergal),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

/datum/species/akula
	name = SPECIES_AKULA
	name_plural = "Akula"
	icobase = 'icons/mob/human_races/r_akula.dmi'
	deform = 'icons/mob/human_races/r_def_akula.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	//darksight = 8
	//slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_SKRELLIAN)
	name_language = LANGUAGE_SKRELLIAN
	color_mult = 1
	assisted_langs = list(LANGUAGE_EAL, LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL, LANGUAGE_VOX)

	min_age = 18
	max_age = 80

	blurb = "Акулами именуется раса гуманоидных амфибий, отличающихся от Скреллов своим акулоподобным внешним видом. \
	Изначально были открыты Скреллам будучи примитивной расой подводных существ. На тот момент они ничем не отличались от животных, \
	однако Акулы проявили настолько высокую способность к обучению, что Скреллы быстро переклассифицировали их в разумных существ. \
	Говорят, что Акулы -- первая разумная раса, с которой сталкивались Скреллы, и поэтому оба вида быстро стали хорошими союзниками в течение следующих пятьсот лет. \
	С помощью скрелльских технологий Акулы смогли получить модификации генома, что позволило им выживать на открытом воздухе в течение длительного времени. \
	Однако Акулам по-прежнему необходима высокая влажность в атмосфере, чтобы не пересохнуть за несколько дней, \
	в связи с чем жизнь на пустынной планете вроде Вирго-Прайм для Акул невозможно без помощи скрелльских технологий."

	wikilink="https://wiki.vore-station.net/Backstory#Akula"

	catalogue_data = list(/datum/category_item/catalogue/fauna/akula)

	primitive_form = "Sobaka"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#777777"
	blood_color = "#1D2CBF"

/datum/species/akula/can_breathe_water()
	return TRUE // Surprise, SHERKS.

/datum/species/nevrean
	name = SPECIES_NEVREAN
	name_plural = "Nevreans"
	icobase = 'icons/mob/human_races/r_nevrean.dmi'
	deform = 'icons/mob/human_races/r_def_nevrean.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	//darksight = 8
	//slowdown = -0.5
	//brute_mod = 1.15
	//burn_mod =  1.15
	//gluttonous = 1
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_BIRDSONG)
	name_language = LANGUAGE_BIRDSONG
	color_mult = 1
	inherent_verbs = list(/mob/living/proc/flying_toggle,/mob/living/proc/start_wings_hovering)

	min_age = 18
	max_age = 80

	blurb = "Невреаны - раса птичьих динозавроподобных существ родом с Таля. Они принадлежат к группе рас, зародившихся на Элте с системе Вилос. \
	В отличие от сергалов -- соседей невреанов по звездной системе -- невреаны весьма мирные. Они обладают выдающимся интеллектом и одаренными руками, \
	с помощью которых они изготавливают высококачественные инструменты, однако которые очень быстро устают при постоянной работе. \
	Как следствие, они с большим трудом изготавливают одно и то же. Голос обоих полов сопровождается слышимым эхом. \
	Их обыкновенный тон колеблется между тенором и сопрано. В спорах на родном языке они становятся крайне шумными."

	wikilink="https://wiki.vore-station.net/Backstory#Nevrean"

	catalogue_data = list(/datum/category_item/catalogue/fauna/nevrean)

	primitive_form = "Sparra"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#AFA59E"
	base_color = "#333333"

	heat_discomfort_strings = list(
		"Ваше оперение колется на жаре.",
		"Вы ощущаете некомфортное тепло.",
		"Ваша перегретая кожа чешется."
		)

/datum/species/hi_zoxxen
	name = SPECIES_ZORREN_HIGH
	name_plural = "Zorren"
	icobase = 'icons/mob/human_races/r_fox_vr.dmi'
	deform = 'icons/mob/human_races/r_def_fox.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_TERMINUS)
	name_language = LANGUAGE_TERMINUS
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds)

	min_age = 18
	max_age = 80

	blurb = "Лисоподобные зоррены произошли на Вирго-Прайм, однако существует два совершенно разных подвида. \
	Один обладает длинными ушами и короткой шерстью — равнинные зоррены, прозванные в честь своего привычного ареала. \
	Равнинные зоррены весьма традиционны и почитают шаманизм, и транскосмические корпорации начали их нанимать совсем недавно. \
	Горные зоррены обычно обустраиваются на более холмистых и горных местностях и привыкли жить с иной, более феодальной, социальной структурой, чем равнинные. \
	Как и равнинные, горные зоррены начали работать на транскосмические корпорации совсем недавно, однако благодаря иной социальной структуре они смогли быстрее \
	адаптироваться к своей новой жизни. Существуют и другие лисоподобные виды, однако они отличаются от зорренов."

	catalogue_data = list(/datum/category_item/catalogue/fauna/zorren)

	//primitive_form = "" //We don't have fox-monkey sprites.

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	flesh_color = "#AFA59E"
	base_color = "#333333"
	blood_color = "#240bc4"
	color_mult = 1

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	heat_discomfort_strings = list(
		"Ваша шерсть колется на жаре.",
		"Вы ощущаете некомфортное тепло.",
		"Ваша перегретая кожа чешется."
		)
	inherent_verbs = list(/mob/living/proc/shred_limb)

/datum/species/vulpkanin
	name = SPECIES_VULPKANIN
	name_plural = "Vulpkanin"
	icobase = 'icons/mob/human_races/r_vulpkanin.dmi'
	deform = 'icons/mob/human_races/r_vulpkanin.dmi'
//	path = /mob/living/carbon/human/vulpkanin
//	default_language = "Sol Common"
	secondary_langs = list(LANGUAGE_CANILUNZT)
	name_language = LANGUAGE_CANILUNZT
	primitive_form = "Wolpin"
	tail = "vulptail"
	tail_animation = 'icons/mob/species/vulpkanin/tail.dmi' // probably need more than just one of each, but w/e
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	darksight = 5 //worse than cats, but better than lizards. -- Poojawa
//	gluttonous = 1
	num_alternate_languages = 3
	color_mult = 1
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds)

	blurb = "Вульпканины - раса хитроумных собачьих, проживающих на планете Альтам на самом краешке двухзвездной системы Ваззенд. \
	Их политически децентрализованное общество и независимый характер привели к тому, что расу вульпканинов остерегаются и уважают \
	за их научные прорывы. Открытия, верность и утилитаризм преобладают в их жизни настолько, что это нередко приводит к конфликтам с авторитетами. \
	Они разговаривают на языке под названием Канилунцт, который основывается на движениях хвоста и ушей для сообщения намерений."

	wikilink="https://wiki.vore-station.net/Backstory#Vulpkanin"

	catalogue_data = list(/datum/category_item/catalogue/fauna/vulpkanin)

	primitive_form = "Wolpin"

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	flesh_color = "#966464"
	base_color = "#B43214"

	min_age = 18
	max_age = 80

/datum/species/unathi
	mob_size = MOB_MEDIUM //To allow normal mob swapping
	spawn_flags = SPECIES_CAN_JOIN //Species_can_join is the only spawn flag all the races get, so that none of them will be whitelist only if whitelist is enabled.
	icobase = 'icons/mob/human_races/r_lizard_vr.dmi'
	deform = 'icons/mob/human_races/r_def_lizard_vr.dmi'
	tail_animation = 'icons/mob/species/unathi/tail_vr.dmi'
	color_mult = 1
	min_age = 18
	gluttonous = 0
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	descriptors = list()
	wikilink="https://wiki.vore-station.net/Unathi"

/datum/species/tajaran
	spawn_flags = SPECIES_CAN_JOIN
	icobase = 'icons/mob/human_races/r_tajaran_vr.dmi'
	deform = 'icons/mob/human_races/r_def_tajaran_vr.dmi'
	tail_animation = 'icons/mob/species/tajaran/tail_vr.dmi'
	color_mult = 1
	min_age = 18
	allergens = null
	gluttonous = 0 //Moving this here so I don't have to fix this conflict every time polaris glances at station.dm
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds)
	heat_discomfort_level = 295 //Prevents heat discomfort spam at 20c
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	wikilink="https://wiki.vore-station.net/Tajaran"
	agility = 90

/datum/species/skrell
	spawn_flags = SPECIES_CAN_JOIN
	icobase = 'icons/mob/human_races/r_skrell_vr.dmi'
	deform = 'icons/mob/human_races/r_def_skrell_vr.dmi'
	color_mult = 1
	min_age = 18
	reagent_tag = null
	allergens = null
	assisted_langs = list(LANGUAGE_EAL, LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL, LANGUAGE_VOX)
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	wikilink="https://wiki.vore-station.net/Skrell"

/datum/species/zaddat
	spawn_flags = SPECIES_CAN_JOIN
	min_age = 18
	gluttonous = 0
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	descriptors = list()
	// no wiki link exists for Zaddat yet

/datum/species/zaddat/equip_survival_gear(var/mob/living/carbon/human/H)
	.=..()
	var/obj/item/weapon/storage/toolbox/lunchbox/survival/zaddat/L = new(get_turf(H))
	if(H.backbag == 1)
		H.equip_to_slot_or_del(L, slot_r_hand)
	else
		H.equip_to_slot_or_del(L, slot_in_backpack)

/datum/species/diona
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE
	min_age = 18
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	wikilink="https://wiki.vore-station.net/Diona"

/datum/species/human
	blurb = "Humanity originated in the Sol system, and over the last three centuries has spread \
	colonies across a wide swathe of space. They hold a wide range of forms and creeds.<br/><br/> \
	While the central Sol government maintains control of its far-flung people, powerful corporate \
	interests, rampant cyber and bio-augmentation and secretive factions make life on most human \
	worlds tumultous at best."
	color_mult = 1
	icobase = 'icons/mob/human_races/r_human_vr.dmi'
	deform = 'icons/mob/human_races/r_def_human_vr.dmi'
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR
	min_age = 18
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	base_color = "#EECEB3"
	wikilink="https://wiki.vore-station.net/Human"

/datum/species/human/vatgrown
	spawn_flags = SPECIES_IS_RESTRICTED

/datum/species/vox
	gluttonous = 0
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE
	min_age = 18
	icobase = 'icons/mob/human_races/r_vox_old.dmi'
	deform = 'icons/mob/human_races/r_def_vox_old.dmi'
	descriptors = list(
		/datum/mob_descriptor/vox_markings = 0
		)
	wikilink="https://wiki.vore-station.net/Vox"

datum/species/harpy
	name = SPECIES_RAPALA
	name_plural = "Rapalans"
	icobase = 'icons/mob/human_races/r_harpy_vr.dmi'
	deform = 'icons/mob/human_races/r_def_harpy_vr.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_BIRDSONG)
	name_language = null
	color_mult = 1
	genders = list(MALE, FEMALE, PLURAL, NEUTER)
	inherent_verbs = list(/mob/living/proc/flying_toggle,/mob/living/proc/start_wings_hovering)

	min_age = 18
	max_age = 80

	base_color = "#EECEB3"

	blurb = "Крайне гордая раса птичьих с отдалённой планеты. \
	Исследователи с Сол сравнивают с мифической расой 'гарпий', славившейся своими огромными крылатыми руками и когтями на ногах.'. \
	Рапалы могут достигать до 35 миль в час в погоне за рыбьей фауной планеты. Родной мир Рапал - Верита - это на удивление обитаемый газовый гигант. \
	Там не существует 'земли', и вместо этого Верита состоит из плодородных островов, орбитирующих вокруг планеты в результате бурной астероидной активности."

	wikilink="https://wiki.vore-station.net/Backstory#Rapala"

	catalogue_data = list(/datum/category_item/catalogue/fauna/rapala)

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR


	heat_discomfort_strings = list(
		"Ваши перья колятся на жаре.",
		"Вы ощущаете некомфортное тепло.",
		"Ваша перегретая кожа чешется."
		)

/datum/species/crew_shadekin
	name = SPECIES_SHADEKIN_CREW
	name_plural = "Black-Eyed Shadekin"
	icobase = 'icons/mob/human_races/r_shadekin_vr.dmi'
	deform = 'icons/mob/human_races/r_shadekin_vr.dmi'
	tail = "tail"
	icobase_tail = 1
	blurb = "Немногое известно об этих существах. Внешность их в целом подобна млекопитающим. \
	Будучи крайне редкими, они стали широко распространенным по галактике мифом без каких-либо приемлемых доказательств их существования. \
	Тем не менее, за недавнее время они были обнаружены в системе Вирго после рудодобывающей бомбардировки Вирго 3. \
	Персонал NSB Adephagia привык называть их Шейдкинами, и имя довольно быстро приелось и распространилось."		//TODO: Something more fitting for black-eyes
	wikilink = "https://wiki.vore-station.net/Shadekin"
	catalogue_data = list(/datum/category_item/catalogue/fauna/shadekin)

	language = LANGUAGE_SHADEKIN
	name_language = LANGUAGE_SHADEKIN
	species_language = LANGUAGE_SHADEKIN
	secondary_langs = list(LANGUAGE_SHADEKIN)
	num_alternate_languages = 3
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	rarity_value = 5	//INTERDIMENSIONAL FLUFFERS

	siemens_coefficient = 0
	darksight = 10

	slowdown = 0.5
	item_slowdown_mod = 1.5

	total_health = 75
	brute_mod = 1.25 // Frail
	burn_mod = 1.25	// Furry
	blood_volume = 500
	hunger_factor = 0.2

	warning_low_pressure = 50
	hazard_low_pressure = -1

	warning_high_pressure = 300
	hazard_high_pressure = INFINITY

	cold_level_1 = -1	//Immune to cold
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 850	//Resistant to heat
	heat_level_2 = 1000
	heat_level_3 = 1150

	flags =  NO_SCAN
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE

	reagent_tag = IS_SHADEKIN		// for shadekin-unqiue chem interactions

	flesh_color = "#FFC896"
	blood_color = "#A10808"
	base_color = "#f0f0f0"
	color_mult = 1

	//has_glowing_eyes = TRUE			// Applicable through traits.

	male_cough_sounds = null
	female_cough_sounds = null
	male_sneeze_sound = null
	female_sneeze_sound = null

	speech_bubble_appearance = "ghost"

	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	breath_type = null
	poison_type = null

	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_SKIN_COLOR | HAS_UNDERWEAR

	move_trail = /obj/effect/decal/cleanable/blood/tracks/paw

	has_organ = list(
		O_HEART =		/obj/item/organ/internal/heart,
		O_VOICE = 		/obj/item/organ/internal/voicebox,
		O_LIVER =		/obj/item/organ/internal/liver,
		O_KIDNEYS =		/obj/item/organ/internal/kidneys,
		O_BRAIN =		/obj/item/organ/internal/brain,
		O_EYES =		/obj/item/organ/internal/eyes,
		O_STOMACH =		/obj/item/organ/internal/stomach,
		O_INTESTINE =	/obj/item/organ/internal/intestine
		)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest/crewkin),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/crewkin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/crewkin),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/crewkin),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/crewkin),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/crewkin),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/crewkin),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/crewkin),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/crewkin),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/crewkin),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/crewkin)
		)

/datum/species/shadekin/get_bodytype()
	return SPECIES_SHADEKIN

/datum/species/shadekin/can_breathe_water()
	return TRUE	//they dont quite breathe

//These species are not really species but are just there for custom species selection

/datum/species/fl_zorren
	name = SPECIES_FENNEC
	name_plural = "Fennec"
	icobase = 'icons/mob/human_races/r_fennec_vr.dmi'
	deform = 'icons/mob/human_races/r_def_fennec.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	num_alternate_languages = 3
	secondary_langs = list(LANGUAGE_TERMINUS)
	name_language = LANGUAGE_TERMINUS
	inherent_verbs = list(/mob/living/carbon/human/proc/lick_wounds)

	min_age = 18
	max_age = 80

	//primitive_form = "" //We don't have fennec-monkey sprites.
	spawn_flags = SPECIES_IS_RESTRICTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	flesh_color = "#AFA59E"
	base_color = "#333333"
	blood_color = "#240bc4"
	color_mult = 1
	inherent_verbs = list(/mob/living/proc/shred_limb)

	heat_discomfort_strings = list(
		"Ваша шерсть колется на жаре.",
		"Вы ощущаете некомфортное тепло.",
		"Ваша перегретая кожа чешется."
		)

/datum/species/xenohybrid
	name = SPECIES_XENOHYBRID
	name_plural = "Xenomorphs"
	icobase = 'icons/mob/human_races/r_xenomorph.dmi'
	deform = 'icons/mob/human_races/r_def_xenomorph.dmi'
	tail = "tail"
	icobase_tail = 1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	darksight = 4 //Better hunters in the dark.
	hunger_factor = 0.1 //In exchange, they get hungry a tad faster.
	num_alternate_languages = 2

	min_age = 18
	max_age = 80

	blurb = "Ксеноморфные гибриды являются результатом скрещивания ДНК ксеноморфа с ДНК другой гуманоидной расы. \
	Благодаря процессу модификации генов, ксеноморфные гибриды лишены своей естественной агрессии, однако из правила бывают и исключения, \
	например, когда они ранены. Большинство гибридов являются представителями женского пола в связи с естественными генами ксеноморфов. \
	Все гибриды были также лишены своей способности откладывать яйца с лицесосами."
	// No wiki page for xenohybrids at present

	//primitive_form = "" //None for these guys

	spawn_flags = SPECIES_IS_RESTRICTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	genders = list(MALE, FEMALE, PLURAL, NEUTER)

	blood_color = "#12ff12"
	flesh_color = "#201730"
	base_color = "#201730"

	heat_discomfort_strings = list(
		"Ваш хитин перегревается.",
		"Вы ощущаете неприятное тепло.",
		"Вашему хитину жарко."
		)
