// Uniform slot
/datum/gear/uniform
	display_name = "Блейзер, синий"
	path = /obj/item/clothing/under/blazer
	slot = slot_w_uniform
	sort_category = "Униформа и одежда"

/datum/gear/uniform/blazerskirt
	display_name = "Блейзер, синий с юбкой"
	path = /obj/item/clothing/under/blazer/skirt

/datum/gear/uniform/cheongsam
	description = "Ассортимент платьев родом со Старой Земли. Они довольно плотно облегают талию."
	display_name = "Ципао (выбор)"

/datum/gear/uniform/cheongsam/New()
	..()
	var/list/cheongasms = list()
	for(var/cheongasm in typesof(/obj/item/clothing/under/cheongsam))
		var/obj/item/clothing/under/cheongsam/cheongasm_type = cheongasm
		cheongasms[initial(cheongasm_type.name)] = cheongasm_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(cheongasms))

/datum/gear/uniform/croptop
	description = "Легкая маечка длиной до живота."
	display_name = "Топик (выбор)"

/datum/gear/uniform/croptop/New()
	..()
	var/list/croptops = list()
	for(var/croptop in typesof(/obj/item/clothing/under/croptop))
		var/obj/item/clothing/under/croptop/croptop_type = croptop
		croptops[initial(croptop_type.name)] = croptop_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(croptops))

/datum/gear/uniform/kilt
	display_name = "Килт"
	path = /obj/item/clothing/under/kilt

/datum/gear/uniform/cuttop
	display_name = "Топ с вырезом, серый"
	path = /obj/item/clothing/under/cuttop

/datum/gear/uniform/cuttop/red
	display_name = "Топ с вырезом, красный"
	path = /obj/item/clothing/under/cuttop/red

/datum/gear/uniform/jumpsuit
	display_name = "Комбинезон (выбор)"
	path = /obj/item/clothing/under/color/grey

/datum/gear/uniform/jumpsuit/New()
	..()
	var/list/jumpclothes = list()
	for(var/jump in typesof(/obj/item/clothing/under/color))
		var/obj/item/clothing/under/color/jumps = jump
		jumpclothes[initial(jumps.name)] = jumps
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(jumpclothes))

/datum/gear/uniform/skirt
	display_name = "Юбка (выбор)"
	path = /obj/item/clothing/under/skirt

/datum/gear/uniform/skirt/New()
	..()
	var/list/skirts = list()
	for(var/skirt in (typesof(/obj/item/clothing/under/skirt)))
		if((skirt in typesof(/obj/item/clothing/under/skirt/fluff)) || (skirt in typesof(/obj/item/clothing/under/skirt/outfit/fluff)))	//VOREStation addition
			continue												//VOREStation addition
		var/obj/item/clothing/under/skirt/skirt_type = skirt
		skirts[initial(skirt_type.name)] = skirt_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(skirts))

/datum/gear/uniform/pants
	display_name = "Штаны (выбор)"
	path = /obj/item/clothing/under/pants/white

/datum/gear/uniform/pants/New()
	..()
	var/list/pants = list()
	for(var/pant in typesof(/obj/item/clothing/under/pants))
		var/obj/item/clothing/under/pants/pant_type = pant
		pants[initial(pant_type.name)] = pant_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(pants))

/datum/gear/uniform/shorts
	display_name = "Шорты (выбор)"
	path = /obj/item/clothing/under/shorts/jeans

/datum/gear/uniform/shorts/New()
	..()
	var/list/shorts = list()
	for(var/short in typesof(/obj/item/clothing/under/shorts))
		var/obj/item/clothing/under/pants/short_type = short
		shorts[initial(short_type.name)] = short_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(shorts))

/datum/gear/uniform/job_skirt/ce
	display_name = "Инженер: Юбка Главного Инженера"
	path = /obj/item/clothing/under/rank/chief_engineer/skirt
	allowed_roles = list("Chief Engineer")

/datum/gear/uniform/job_skirt/atmos
	display_name = "Инженер: Юбка атмосферщика"
	path = /obj/item/clothing/under/rank/atmospheric_technician/skirt
	allowed_roles = list("Chief Engineer","Atmospheric Technician")

/datum/gear/uniform/job_skirt/eng
	display_name = "Инженер: Юбка инженера"
	path = /obj/item/clothing/under/rank/engineer/skirt
	allowed_roles = list("Chief Engineer","Station Engineer")

/datum/gear/uniform/job_skirt/roboticist
	display_name = "Учёный: Юбка робототехника"
	path = /obj/item/clothing/under/rank/roboticist/skirt
	allowed_roles = list("Research Director","Roboticist")

/datum/gear/uniform/job_skirt/cmo
	display_name = "Врач: Юбка Главврача"
	path = /obj/item/clothing/under/rank/chief_medical_officer/skirt
	allowed_roles = list("Chief Medical Officer")

/datum/gear/uniform/job_skirt/chem
	display_name = "Врач: Юбка химика"
	path = /obj/item/clothing/under/rank/chemist/skirt
	allowed_roles = list("Chief Medical Officer","Chemist")

/datum/gear/uniform/job_skirt/viro
	display_name = "Врач: Юбка вирусолога"
	path = /obj/item/clothing/under/rank/virologist/skirt
	allowed_roles = list("Chief Medical Officer","Medical Doctor")

/datum/gear/uniform/job_skirt/med
	display_name = "Врач: Юбка врача"
	path = /obj/item/clothing/under/rank/medical/skirt
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Psychiatrist","Paramedic")

/datum/gear/uniform/job_skirt/sci
	display_name = "Учёный: Юбка ученого"
	path = /obj/item/clothing/under/rank/scientist/skirt
	allowed_roles = list("Research Director","Scientist", "Xenobiologist")

/datum/gear/uniform/job_skirt/cargo
	display_name = "Карго: Юбка карго"
	path = /obj/item/clothing/under/rank/cargotech/skirt
	allowed_roles = list("Quartermaster","Cargo Technician")

/datum/gear/uniform/job_skirt/qm
	display_name = "Карго: Юбка Квартирмейстера"
	path = /obj/item/clothing/under/rank/cargo/skirt
	allowed_roles = list("Quartermaster")

/datum/gear/uniform/job_skirt/warden
	display_name = "СБ: Юбка надзирателя"
	path = /obj/item/clothing/under/rank/warden/skirt
	allowed_roles = list("Head of Security", "Warden")

/datum/gear/uniform/job_skirt/security
	display_name = "СБ: Юбка СБ"
	path = /obj/item/clothing/under/rank/security/skirt
	allowed_roles = list("Head of Security", "Warden", "Detective", "Security Officer")

/datum/gear/uniform/job_skirt/head_of_security
	display_name = "СБ: Юбка Главы СБ"
	path = /obj/item/clothing/under/rank/head_of_security/skirt
	allowed_roles = list("Head of Security")

/datum/gear/uniform/job_turtle/science
	display_name = "Учёный: Водолазка"
	path = /obj/item/clothing/under/rank/scientist/turtleneck
	allowed_roles = list("Research Director", "Scientist", "Roboticist", "Xenobiologist")

/datum/gear/uniform/job_turtle/security
	display_name = "СБ: Водолазка"
	path = /obj/item/clothing/under/rank/security/turtleneck
	allowed_roles = list("Head of Security", "Warden", "Detective", "Security Officer")

/datum/gear/uniform/job_turtle/engineering
	display_name = "Инженер: Водолазка"
	path = /obj/item/clothing/under/rank/engineer/turtleneck
	allowed_roles = list("Chief Engineer", "Atmospheric Technician", "Station Engineer")

/datum/gear/uniform/job_turtle/medical
	display_name = "Врач: Водолазка"
	path = /obj/item/clothing/under/rank/medical/turtleneck
	allowed_roles = list("Chief Medical Officer", "Paramedic", "Medical Doctor", "Psychiatrist", "Search and Rescue", "Chemist")

/datum/gear/uniform/jeans_qm
	display_name = "Карго: Джинсы Квартирмейстера"
	path = /obj/item/clothing/under/rank/cargo/jeans
	allowed_roles = list("Quartermaster")

/datum/gear/uniform/jeans_qmf
	display_name = "Карго: Джинсы Квартирмейстера, женские"
	path = /obj/item/clothing/under/rank/cargo/jeans/female
	allowed_roles = list("Quartermaster")

/datum/gear/uniform/jeans_cargo
	display_name = "Карго: Джинсы"
	path = /obj/item/clothing/under/rank/cargotech/jeans
	allowed_roles = list("Quartermaster","Cargo Technician")

/datum/gear/uniform/jeans_cargof
	display_name = "Карго: Джинсы, женские"
	path = /obj/item/clothing/under/rank/cargotech/jeans/female
	allowed_roles = list("Quartermaster","Cargo Technician")

/datum/gear/uniform/suit/lawyer
	display_name = "Костюм, официальный (выбор)"
	path = /obj/item/clothing/under/lawyer

/datum/gear/uniform/suit/lawyer/New()
	..()
	var/list/lsuits = list()
	for(var/lsuit in typesof(/obj/item/clothing/under/lawyer))
		var/obj/item/clothing/suit/lsuit_type = lsuit
		lsuits[initial(lsuit_type.name)] = lsuit_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(lsuits))

/datum/gear/uniform/suit/suit_jacket
	display_name = "Костюм, формальный (выбор)"
	path = /obj/item/clothing/under/suit_jacket

/datum/gear/uniform/suit/suit_jacket/New()
	..()
	var/list/msuits = list()
	for(var/msuit in typesof(/obj/item/clothing/under/suit_jacket))
		if(msuit in typesof(/obj/item/clothing/under/suit_jacket/female/fluff))	//VOREStation addition
			continue															//VOREStation addition
		var/obj/item/clothing/suit/msuit_type = msuit
		msuits[initial(msuit_type.name)] = msuit_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(msuits))

/datum/gear/uniform/suit/amish  //amish
	display_name = "Костюм, амиш"
	path = /obj/item/clothing/under/sl_suit

/datum/gear/uniform/suit/gentle
	display_name = "Костюм, джентльмен"
	path = /obj/item/clothing/under/gentlesuit

/datum/gear/uniform/suit/gentleskirt
	display_name = "Костюм, леди"
	path = /obj/item/clothing/under/gentlesuit/skirt

/datum/gear/uniform/suit/white
	display_name = "Костюм, белый"
	path = /obj/item/clothing/under/scratch

/datum/gear/uniform/suit/whiteskirt
	display_name = "Костюм, белый с юбкой"
	path = /obj/item/clothing/under/scratch/skirt

/datum/gear/uniform/suit/detectiveskirt
	display_name = "Детектив: Костюм с юбкой"
	path = /obj/item/clothing/under/det/skirt
	allowed_roles = list("Detective")

/datum/gear/uniform/suit/iaskirt
	display_name = "Агент Внутренних Дел: Костюм с юбкой"
	path = /obj/item/clothing/under/rank/internalaffairs/skirt
	allowed_roles = list("Internal Affairs Agent")

/datum/gear/uniform/suit/bartenderskirt
	display_name = "Бармен: Костюм с юбкой"
	path = /obj/item/clothing/under/rank/bartender/skirt
	allowed_roles = list("Bartender")

/datum/gear/uniform/scrub
	display_name = "Медицинская одежда (выбор)"
	path = /obj/item/clothing/under/rank/medical/scrubs

/datum/gear/uniform/scrub/New()
	..()
	var/list/scrubs = list()
	for(var/scrub in typesof(/obj/item/clothing/under/rank/medical/scrubs))
		var/obj/item/clothing/under/rank/medical/scrubs/scrub_type = scrub
		scrubs[initial(scrub_type.name)] = scrub_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(scrubs))

/datum/gear/uniform/oldwoman
	display_name = "Одежда пожилой женщины"
	path = /obj/item/clothing/under/oldwoman

/datum/gear/uniform/sundress
	display_name = "Сарафан"
	path = /obj/item/clothing/under/sundress

/datum/gear/uniform/sundress/white
	display_name = "Сарафан, белый"
	path = /obj/item/clothing/under/sundress_white

/datum/gear/uniform/dress_fire
	display_name = "Платье, огненный принт"
	path = /obj/item/clothing/under/dress/dress_fire

/datum/gear/uniform/uniform_captain
	display_name = "Управление: Платье ДК"
	path = /obj/item/clothing/under/dress/dress_cap
	allowed_roles = list("Site Manager")

/datum/gear/uniform/corpdetsuit
	display_name = "Детектив: Униформа, фирменная"
	path = /obj/item/clothing/under/det/corporate
	allowed_roles = list("Detective","Head of Security")

/datum/gear/uniform/corpsecsuit
	display_name = "СБ: Униформа, фирменная"
	path = /obj/item/clothing/under/rank/security/corp
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/uniform/corpwarsuit
	display_name = "СБ: Униформа, фирменная (Надзиратель)"
	path = /obj/item/clothing/under/rank/warden/corp
	allowed_roles = list("Head of Security","Warden")

/datum/gear/uniform/corphossuit
	display_name = "СБ: Униформа, фирменная (Глава СБ)"
	path = /obj/item/clothing/under/rank/head_of_security/corp
	allowed_roles = list("Head of Security")

/datum/gear/uniform/uniform_hop
	display_name = "Управление: Платье ГП"
	path = /obj/item/clothing/under/dress/dress_hop
	allowed_roles = list("Head of Personnel")

/datum/gear/uniform/uniform_hr
	display_name = "Управление: Платье ГП, альт"
	path = /obj/item/clothing/under/dress/dress_hr

	allowed_roles = list("Head of Personnel")

/datum/gear/uniform/navysecsuit
	display_name = "СБ: Униформа, морской синий"
	path = /obj/item/clothing/under/rank/security/navyblue
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/uniform/navywarsuit
	display_name = "СБ: Униформа, морской синий (Надзиратель)"
	path = /obj/item/clothing/under/rank/warden/navyblue
	allowed_roles = list("Head of Security","Warden")

/datum/gear/uniform/navyhossuit
	display_name = "СБ: Униформа, морской синий (Глава СБ)"
	path = /obj/item/clothing/under/rank/head_of_security/navyblue
	allowed_roles = list("Head of Security")

/datum/gear/uniform/shortplaindress
	display_name = "Платье, простое"
	path = /obj/item/clothing/under/dress/white3

/datum/gear/uniform/shortplaindress/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/longdress
	display_name = "Платье, длинное"
	path = /obj/item/clothing/under/dress/white2

/datum/gear/uniform/longdress/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/longwidedress
	display_name = "Платье, длинное, широкое"
	path = /obj/item/clothing/under/dress/white4

/datum/gear/uniform/longwidedress/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/reddress
	display_name = "Платье, красное с ремнём"
	path = /obj/item/clothing/under/dress/darkred

/datum/gear/uniform/whitewedding
	display_name= "Платье, белое свадебное"
	path = /obj/item/clothing/under/wedding/bride_white

/datum/gear/uniform/skirts
	display_name = "Юбка, должностное лицо"
	path = /obj/item/clothing/under/suit_jacket/female/skirt

/datum/gear/uniform/dresses
	display_name = "Платье, морячка"
	path = /obj/item/clothing/under/dress/sailordress

/datum/gear/uniform/dresses/eveninggown
	display_name = "Платье, красное вечернее"
	path = /obj/item/clothing/under/dress/redeveninggown

/datum/gear/uniform/dresses/maid
	display_name = "Униформа горничной (выбор)"
	path = /obj/item/clothing/under/dress/maid

/datum/gear/uniform/dresses/maid/New()
	..()
	var/list/maids = list()
	for(var/maid in typesof(/obj/item/clothing/under/dress/maid))
		var/obj/item/clothing/under/dress/maid/maid_type = maid
		maids[initial(maid_type.name)] = maid_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(maids))

/datum/gear/uniform/utility
	display_name = "Комплект, черный"
	path = /obj/item/clothing/under/utility

/datum/gear/uniform/utility/blue
	display_name = "Комплект, синий"
	path = /obj/item/clothing/under/utility/blue

/datum/gear/uniform/utility/grey
	display_name = "Комплект, серый"
	path = /obj/item/clothing/under/utility/grey

/datum/gear/uniform/sweater
	display_name = "Свитер, серый"
	path = /obj/item/clothing/under/rank/psych/turtleneck/sweater

/datum/gear/uniform/brandsuit/aether
	display_name = "Комбинезон, Aether"
	path = /obj/item/clothing/under/aether

/datum/gear/uniform/brandsuit/focal
	display_name = "Комбинезон, Focal"
	path = /obj/item/clothing/under/focal

/datum/gear/uniform/mbill
	display_name = "Комбинезон, Major Bill"
	path = /obj/item/clothing/under/mbill

/datum/gear/uniform/pcrc
	display_name = "СБ: Униформа, PCRC"
	path = /obj/item/clothing/under/pcrc
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/uniform/brandsuit/grayson
	display_name = "Комбинезон: Grayson"
	path = /obj/item/clothing/under/grayson

/datum/gear/uniform/brandsuit/wardt
	display_name = "Комбинезон, Ward-Takahashi"
	path = /obj/item/clothing/under/wardt

/datum/gear/uniform/frontier
	display_name = "Комбинезон, граница"
	path = 	/obj/item/clothing/under/frontier

/datum/gear/uniform/brandsuit/hephaestus
	display_name = "Комбинезон, Hephaestus"
	path = 	/obj/item/clothing/under/hephaestus

/datum/gear/uniform/yogapants
	display_name = "Штаны, йога"
	path = /obj/item/clothing/under/pants/yogapants

/datum/gear/uniform/yogapants/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/black_corset
	display_name = "Корсет, черный"
	path = /obj/item/clothing/under/dress/black_corset

/datum/gear/uniform/flower_dress
	display_name = "Платье, цветочное"
	path = /obj/item/clothing/under/dress/flower_dress

/datum/gear/uniform/red_swept_dress
	display_name = "Платье, стянутое, красное"
	path = /obj/item/clothing/under/dress/red_swept_dress

/datum/gear/uniform/bathrobe
	display_name = "Халат, банный"
	path = /obj/item/clothing/under/bathrobe

/datum/gear/uniform/flamenco
	display_name = "Платье, фламенко"
	path = /obj/item/clothing/under/dress/flamenco

/datum/gear/uniform/westernbustle
	display_name = "Турнюр, западный"
	path = /obj/item/clothing/under/dress/westernbustle

/datum/gear/uniform/circuitry
	display_name = "Комбинезон, программируемый (пустой)"
	path = /obj/item/clothing/under/circuitry

/datum/gear/uniform/sleekoverall
	display_name = "Комбинезон, модерн"
	path = /obj/item/clothing/under/overalls/sleek

/datum/gear/uniform/sarired
	display_name = "Сари, красное"
	path = /obj/item/clothing/under/dress/sari

/datum/gear/uniform/sarigreen
	display_name = "Сари, зеленое"
	path = /obj/item/clothing/under/dress/sari/green

/datum/gear/uniform/wrappedcoat
	display_name = "Пальто, обернутое"
	path = /obj/item/clothing/under/moderncoat

/datum/gear/uniform/ascetic
	display_name = "Комплект, аскетичный белый"
	path = /obj/item/clothing/under/ascetic

/datum/gear/uniform/pleated
	display_name = "Юбка, плиссированная"
	path = /obj/item/clothing/under/skirt/pleated

/datum/gear/uniform/pleated/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/lilacdress
	display_name = "Платье, сиреневое"
	path = /obj/item/clothing/under/dress/lilacdress

/datum/gear/uniform/polka
	display_name = "Платье, в горошек"
	path = /obj/item/clothing/under/dress/polka

/datum/gear/uniform/twistfront
	display_name = "Платье, скрученный топ"
	path = /obj/item/clothing/under/dress/twistfront

/datum/gear/uniform/cropdress
	display_name = "Платье, топ"
	path = /obj/item/clothing/under/dress/cropdress

/datum/gear/uniform/vneckdress
	display_name = "Платье, V-образный вырез"
	path = /obj/item/clothing/under/dress/vneck

/datum/gear/uniform/bluedress
	display_name = "Платье, синее"
	path = /obj/item/clothing/under/dress/bluedress

/datum/gear/uniform/wench
	display_name = "Платье, распутница"
	path = /obj/item/clothing/under/dress/wench

/datum/gear/uniform/littleblackdress
	display_name = "Платье, небольшое черное"
	path = /obj/item/clothing/under/dress/littleblackdress

/datum/gear/uniform/pinktutu
	display_name = "Балетная пачка, розовая"
	path = /obj/item/clothing/under/dress/pinktutu

/datum/gear/uniform/festivedress
	display_name = "Платье, праздничное"
	path = /obj/item/clothing/under/dress/festivedress

/datum/gear/uniform/haltertop
	display_name = "Халтер"
	path = /obj/item/clothing/under/haltertop

/datum/gear/uniform/revealingdress
	display_name = "Платье, откровенное"
	path = /obj/item/clothing/under/dress/revealingdress

/datum/gear/uniform/rippedpunk
	display_name = "Комплект, панк, рваный"
	path = /obj/item/clothing/under/rippedpunk

/datum/gear/uniform/gothic
	display_name = "Платье, готическое"
	path = /obj/item/clothing/under/dress/gothic

/datum/gear/uniform/formalred
	display_name = "Платье, красное формальное"
	path = /obj/item/clothing/under/dress/formalred

/datum/gear/uniform/pentagram
	display_name = "Платье, пентаграмма"
	path = /obj/item/clothing/under/dress/pentagram

/datum/gear/uniform/yellowswoop
	display_name = "Платье, стянутое, желтое"
	path = /obj/item/clothing/under/dress/yellowswoop

/datum/gear/uniform/greenasym
	display_name = "Асимметричный комбинезон, зеленый"
	path = /obj/item/clothing/under/greenasym

/datum/gear/uniform/cyberpunkharness
	display_name = "Упряжь, киберпанк"
	path = /obj/item/clothing/under/cyberpunkharness

/datum/gear/uniform/whitegown
	display_name = "Платье, белое"
	path = /obj/item/clothing/under/wedding/whitegown

/datum/gear/uniform/floofdress
	display_name = "Платье, пышное"
	path = /obj/item/clothing/under/wedding/floofdress

/datum/gear/uniform/floofdress/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/blackngold
	display_name = "Платье, черно-золотое"
	path = /obj/item/clothing/under/blackngold

/datum/gear/uniform/sheerblue
	display_name = "Платье, голубое"
	path = /obj/item/clothing/under/sheerblue

/datum/gear/uniform/disheveled
	display_name = "Костюм, растрепанный"
	path = /obj/item/clothing/under/disheveled

/datum/gear/uniform/orangedress
	display_name = "Платье, оранжевое"
	path = /obj/item/clothing/under/dress/dress_orange

/datum/gear/uniform/sundress_pink
	display_name = "Сарафан, розовый"
	path = /obj/item/clothing/under/dress/sundress_pink

/datum/gear/uniform/sundress_white
	display_name = "Сарафан, белый"
	path = /obj/item/clothing/under/dress/sundress_white

/datum/gear/uniform/sundress_pinkbow
	display_name = "Сарафан, розовый с бантом"
	path = /obj/item/clothing/under/dress/sundress_pinkbow

/datum/gear/uniform/sundress_blue
	display_name = "Сарафан, голубой длинный"
	path = /obj/item/clothing/under/dress/sundress_blue

/datum/gear/uniform/sundress_pinkshort
	display_name = "Сарафан, розовый короткий"
	path = /obj/item/clothing/under/dress/sundress_pinkshort

/datum/gear/uniform/twopiece
	display_name = "Платье, двойное"
	path = /obj/item/clothing/under/dress/twopiece

/datum/gear/uniform/gothic2
	display_name = "Платье, готическое"
	path = /obj/item/clothing/under/dress/gothic2

/datum/gear/uniform/flowerskirt
	display_name = "flower skirt"
	path = /obj/item/clothing/under/flower_skirt

/datum/gear/uniform/flowerskirt/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/uniform/countess
	display_name = "countess dress"
	path = /obj/item/clothing/under/dress/countess