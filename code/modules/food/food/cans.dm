/obj/item/weapon/reagent_containers/food/drinks/cans
	volume = 40 //just over one and a half cups
	amount_per_transfer_from_this = 5
	flags = 0 //starts closed
	drop_sound = 'sound/items/drop/soda.ogg'
	pickup_sound = 'sound/items/pickup/soda.ogg'

//DRINKS

/obj/item/weapon/reagent_containers/food/drinks/cans/cola
	name = "\improper Space Cola"
	desc = "Обнадеживающе искусственно."
	description_fluff = "Бренд \"Космос\" был первоначально добавлен в линейку продуктов \"Альфа-Кола\", чтобы оправдать продажу банок по 50% более высоким ценам \"внешним\" розничным торговцам. Несмотря на химическую идентичность, Космическая кола оказалась настолько популярной, что Centauri Provisions в конце концов применила это название ко всей линейке продуктов - повышение цен и все такое."
	icon_state = "cola"
	center_of_mass = list("x"=16, "y"=10)

/obj/item/weapon/reagent_containers/food/drinks/cans/cola/Initialize()
	. = ..()
	reagents.add_reagent("cola", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle
	name = "bottled water"
	desc = "Ледяная и совершенно безвкусная, эта \"полностью натуральная\" минеральная вода поступает \"свежая\" с одного из сверхмощных заводов по розливу NanoTrasen на Сивийских полюсах."
	icon_state = "waterbottle"
	center_of_mass = list("x"=16, "y"=8)
	drop_sound = 'sound/items/drop/disk.ogg'
	pickup_sound = 'sound/items/pickup/disk.ogg'

/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle/Initialize()
	. = ..()
	reagents.add_reagent("water", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/space_mountain_wind
	name = "\improper Space Mountain Wind"
	desc = "Дует прямо сквозь тебя, как космический ветер."
	description_fluff = "Бренд \"Космос\" был первоначально добавлен в линейку продуктов \"Альфа-Кола\", чтобы оправдать продажу банок по 50% более высоким ценам \"внешним\" розничным торговцам. Несмотря на химическую идентичность, Космическая кола оказалась настолько популярной, что Centauri Provisions в конце концов применила это название ко всей линейке продуктов - повышение цен и все такое."
	icon_state = "space_mountain_wind"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/space_mountain_wind/Initialize()
	. = ..()
	reagents.add_reagent("spacemountainwind", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/thirteenloko
	name = "\improper Thirteen Loko"
	desc = "Совет по здравоохранению Вирго предупредил потребителей, что потребление Тринадцати Локо может привести к судорогам, слепоте, пьянству или даже смерти. Пожалуйста, Пейте Ответственно."
	icon_state = "thirteen_loko"
	center_of_mass = list("x"=16, "y"=10)

/obj/item/weapon/reagent_containers/food/drinks/cans/thirteenloko/Initialize()
	. = ..()
	reagents.add_reagent("thirteenloko", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb
	name = "\improper Dr. Gibb"
	desc = "Восхитительная смесь из 42 различных вкусов."
	description_fluff = "После 2490 судебных процессов и череды смертей Gilthari Exports напоминает клиентам, что \"Доктор\" юридически означает \"Напиток\"."
	icon_state = "dr_gibb"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb/Initialize()
		..()
		reagents.add_reagent("dr_gibb", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb_diet
	name = "\improper Diet Dr. Gibb"
	desc = "Восхитительная смесь из 42 различных вкусов, один из которых-вода."
	description_fluff = "После 2490 судебных процессов и череды смертей Gilthari Exports напоминает клиентам, что \"Доктор\" юридически означает \"Напиток\"."
	icon_state = "dr_gibb_diet"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb_diet/Initialize()
		..()
		reagents.add_reagent("diet_dr_gibb", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/starkist
	name = "\improper Star-kist"
	desc = "Вкус звезды в жидком виде. И немного тунца...?"
	description_fluff = "Вызванный массовым спросом в 2515 году после ограниченного выпуска в 2510 году, культовый успех этой странной на вкус соды никогда по-настоящему не учитывался экономистами."
	icon_state = "starkist"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/starkist/Initialize()
	. = ..()
	reagents.add_reagent("brownstar", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/space_up
	name = "\improper Space-Up"
	desc = "Во рту вкус, как от пробоины в корпусе."
	description_fluff = "Бренд \"Космос\" был первоначально добавлен в линейку продуктов \"Альфа-Кола\", чтобы оправдать продажу банок по 50% более высоким ценам \"внешним\" розничным торговцам. Несмотря на химическую идентичность, Космическая кола оказалась настолько популярной, что Centauri Provisions в конце концов применила это название ко всей линейке продуктов - повышение цен и все такое."
	icon_state = "space-up"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/space_up/Initialize()
	. = ..()
	reagents.add_reagent("space_up", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/lemon_lime
	name = "\improper Lemon-Lime"
	desc = "Вы хотели АПЕЛЬСИН. Он дал вам Лимонно-лаймовый."
	description_fluff = "Не путайте с \"лимонно-лаймовой содой\", Лимонно-лаймовая сода специально разработана с использованием высоко запатентованных фруктов Лимонно-лаймовой соды. Выращивание лимона-лайма без лицензии карается штрафом или тюремным заключением. Не принимайте подражаний."
	icon_state = "lemon-lime"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/lemon_lime/Initialize()
	. = ..()
	reagents.add_reagent("lemon_lime", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/iced_tea
	name = "\improper Vrisk Serket Iced Tea"
	desc = "Этот сладкий, освежающий южный землистый аромат. Это ведь оттуда, верно? Южная Земля?"
	description_fluff = "Произведенный исключительно на планете Оазис, Холодный чай Вриска Серкет не продается за пределами Золотого Полумесяца, не говоря уже о Земле."
	icon_state = "ice_tea_can"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/iced_tea/Initialize()
	. = ..()
	reagents.add_reagent("icetea", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/grape_juice
	name = "\improper Grapel Juice"
	desc = "500 страниц правил, как правильно вступать в бой с этим соком!"
	description_fluff = "Как ни странно, эта непритязательная виноградная сода-продукт Гефестус Индастриз."
	icon_state = "purple_can"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/grape_juice/Initialize()
	. = ..()
	reagents.add_reagent("grapejuice", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/tonic
	name = "\improper T-Borg's Tonic Water"
	desc = "У хинина странный вкус, но, по крайней мере, он убережет от малярии."
	description_fluff = "Благодаря своим технически целебным свойствам и сложностям химического авторского права тонизирующая вода T-Borg является редким продуктом подразделения освежающих напитков Zeng-Hu \"LifeWater\"."
	icon_state = "tonic"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/tonic/Initialize()
	. = ..()
	reagents.add_reagent("tonic", 50)

/obj/item/weapon/reagent_containers/food/drinks/cans/sodawater
	name = "soda water"
	desc = "Банка содовой воды. Все - таки вода более освежающая."
	icon_state = "sodawater"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/sodawater/Initialize()
	. = ..()
	reagents.add_reagent("sodawater", 50)

/obj/item/weapon/reagent_containers/food/drinks/cans/gingerale
	name = "\improper Classic Ginger Ale"
	desc = "Для тех случаев, когда вам нужно быть более ретро, чем вам уже платит НаноТразен."
	description_fluff = "\"Классические\" напитки являются зарегистрированной торговой маркой корпорации Centauri Provisions."
	icon_state = "gingerale"
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/cans/gingerale/Initialize()
	. = ..()
	reagents.add_reagent("gingerale", 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/root_beer
	name = "\improper R&D Root Beer"
	desc = "Гарантированно будет и Корень, и Зубец."
	description_fluff = "Несмотря на многовековую экспансию человечества, эта особая сода все еще производится почти исключительно на Земле, в Северной Америке."
	icon_state = "root_beer"
	center_of_mass = list("x"=16, "y"=10)

/obj/item/weapon/reagent_containers/food/drinks/cans/root_beer/Initialize()
	. = ..()
	reagents.add_reagent("rootbeer", 30)

