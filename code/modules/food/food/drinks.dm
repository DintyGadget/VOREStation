////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/food/drinks
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks.dmi'
	drop_sound = 'sound/items/drop/drinkglass.ogg'
	pickup_sound =  'sound/items/pickup/drinkglass.ogg'
	icon_state = null
	flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5,10,15,25,30)
	volume = 50
	var/trash = null

/obj/item/weapon/reagent_containers/food/drinks/on_reagent_change()
	if (reagents.reagent_list.len > 0)
		var/datum/reagent/R = reagents.get_master_reagent()
		if(R.price_tag)
			price_tag = R.price_tag
		else
			price_tag = null
	return

/obj/item/weapon/reagent_containers/food/drinks/proc/On_Consume(var/mob/M)
	if(!usr)
		usr = M
	if(!reagents.total_volume)
		M.visible_message("<span class='notice'>[M] заканчивает пить [src].</span>","<span class='notice'>Вы заканчиваете пить [src].</span>")
		if(trash)
			usr.drop_from_inventory(src)	//so icons update :[
			if(ispath(trash,/obj/item))
				var/obj/item/TrashItem = new trash(usr)
				usr.put_in_hands(TrashItem)
			else if(istype(trash,/obj/item))
				usr.put_in_hands(trash)
			qdel(src)
	return

/obj/item/weapon/reagent_containers/food/drinks/attack_self(mob/user as mob)
	if(!is_open_container())
		open(user)

/obj/item/weapon/reagent_containers/food/drinks/proc/open(mob/user)
	playsound(src,"canopen", rand(10,50), 1)
	GLOB.cans_opened_roundstat++
	to_chat(user, "<span class='notice'>Вы открываете [src] с громким хлопком!</span>")
	flags |= OPENCONTAINER

/obj/item/weapon/reagent_containers/food/drinks/attack(mob/M as mob, mob/user as mob, def_zone)
	if(force && !(flags & NOBLUDGEON) && user.a_intent == I_HURT)
		return ..()

	if(standard_feed_mob(user, M))
		return

	return 0

/obj/item/weapon/reagent_containers/food/drinks/afterattack(obj/target, mob/user, proximity)
	if(!proximity) return

	if(standard_dispenser_refill(user, target))
		return
	if(standard_pour_into(user, target))
		return
	return ..()

/obj/item/weapon/reagent_containers/food/drinks/standard_feed_mob(var/mob/user, var/mob/target)
	if(!is_open_container())
		to_chat(user, "<span class='notice'>Вам нужно открыть [src]!</span>")
		return 1
	On_Consume(target,user)
	return ..()

/obj/item/weapon/reagent_containers/food/drinks/standard_dispenser_refill(var/mob/user, var/obj/structure/reagent_dispensers/target)
	if(!is_open_container())
		to_chat(user, "<span class='notice'>Вам нужно открыть [src]!</span>")
		return 1
	return ..()

/obj/item/weapon/reagent_containers/food/drinks/standard_pour_into(var/mob/user, var/atom/target)
	if(!is_open_container())
		to_chat(user, "<span class='notice'>Вам нужно открыть [src]!</span>")
		return 1
	return ..()

/obj/item/weapon/reagent_containers/food/drinks/self_feed_message(var/mob/user)
	to_chat(user, "<span class='notice'>Вы делаете глоток из [src].</span>")

/obj/item/weapon/reagent_containers/food/drinks/feed_sound(var/mob/user)
	playsound(src, 'sound/items/drink.ogg', rand(10, 50), 1)

/obj/item/weapon/reagent_containers/food/drinks/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		if(!reagents?.total_volume)
			. += "<span class='notice'>Она пуста!</span>"
		else if (reagents.total_volume <= volume * 0.25)
			. += "<span class='notice'>Она почти пуста!</span>"
		else if (reagents.total_volume <= volume * 0.66)
			. += "<span class='notice'>Она наполовину полна!</span>"
		else if (reagents.total_volume <= volume * 0.90)
			. += "<span class='notice'>Она почти полна!</span>"
		else
			. += "<span class='notice'>Она полна!</span>"


////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/drinks/golden_cup
	desc = "Золотая чаша"
	name = "золотая чашка"
	icon_state = "golden_cup"
	item_state = "" //nope :(
	w_class = ITEMSIZE_LARGE
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = null
	volume = 150
	flags = OPENCONTAINER

/obj/item/weapon/reagent_containers/food/drinks/golden_cup/on_reagent_change()
	..()

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
//	rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
//	Formatting is the same as food.

/obj/item/weapon/reagent_containers/food/drinks/milk
	name = "пакет молока"
	desc = "Это молоко. Белое и питательное добро!"
	description_fluff = "Продукт Нано-пастбищ. Кто бы мог подумать, что коровы будут жить в невесомости?"
	icon_state = "milk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/reagent_containers/food/drinks/milk/Initialize()
	. = ..()
	reagents.add_reagent("milk", 50)

/obj/item/weapon/reagent_containers/food/drinks/soymilk
	name = "пакет соевого молока"
	desc = "Это соевое молоко. Белое и питательное добро!"
	description_fluff = "Продукт Нано-пастбищ. Для тех, кто скептически относится к тому, что коровы могут жить в невесомости."
	icon_state = "soymilk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/reagent_containers/food/drinks/soymilk/Initialize()
	. = ..()
	reagents.add_reagent("soymilk", 50)

/obj/item/weapon/reagent_containers/food/drinks/smallmilk
	name = "маленький пакет молока"
	desc = "Это молоко. Белое и питательное добро!"
	description_fluff = "Продукт Нано-пастбищ. Кто бы мог подумать, что коровы будут жить в невесомости?"
	volume = 30
	icon_state = "mini-milk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/reagent_containers/food/drinks/smallmilk/Initialize()
	. = ..()
	reagents.add_reagent("milk", 30)

/obj/item/weapon/reagent_containers/food/drinks/smallchocmilk
	name = "маленькая коробка шоколадного молока"
	desc = "Это молоко! Этот с восхитительным шоколадным вкусом."
	description_fluff = "Продукт Нано-пастбищ. Кто бы мог подумать, что коровы будут жить в невесомости?"
	volume = 30
	icon_state = "mini-milk_choco"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/reagent_containers/food/drinks/smallchocmilk/Initialize()
	. = ..()
	reagents.add_reagent("chocolate_milk", 30)

/obj/item/weapon/reagent_containers/food/drinks/coffee
	name = "крепкий кофе"
	desc = "Осторожно, напиток, которым вы собираетесь насладиться, очень горячий."
	description_fluff = "Свежий кофе почти не встречается за пределами планет и станций, где его выращивают. Крепкий кофе с гордостью рекламирует шесть отдельных раз, когда он подвергается сублимационной сушке в процессе производства каждой чашки растворимого кофе."
	icon_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=15, "y"=10)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/coffee/Initialize()
	. = ..()
	reagents.add_reagent("coffee", 30)

/obj/item/weapon/reagent_containers/food/drinks/tea
	name = "чашка чая Duke Purple"
	desc = "Оскорбление герцога Пурпурного-это оскорбление Космической королевы! Любой порядочный джентльмен будет драться с вами, если вы запачкаете этот чай."
	description_fluff = "Duke Purple-это фирменный сорт черного чая Нано-пастбищ, известный своим сильным, но в остальном совершенно не отличительным вкусом."
	icon_state = "chai_vended"
	item_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=16, "y"=14)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/tea/Initialize()
	. = ..()
	reagents.add_reagent("tea", 30)

/obj/item/weapon/reagent_containers/food/drinks/ice
	name = "чашка льда"
	desc = "Осторожно, холодный лед, не жуйте."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
/obj/item/weapon/reagent_containers/food/drinks/ice/Initialize()
	. = ..()
	reagents.add_reagent("ice", 30)

/obj/item/weapon/reagent_containers/food/drinks/h_chocolate
	name = "чашка горячего какао Counselor's Choice"
	desc = "Кому нужны черты характера, когда можно насладиться горячей кружкой какао?"
	description_fluff = "Горячее какао марки Advisor's Choice производится из смеси горячей воды и немолочного заменителя сухого молока, что является компромиссом, предназначенным для раздражения всех сторон."
	icon_state = "coffee"
	item_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=15, "y"=13)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/h_chocolate/Initialize()
	. = ..()
	reagents.add_reagent("hot_coco", 30)

/obj/item/weapon/reagent_containers/food/drinks/greentea
	name = "чашка зеленого чая"
	desc = "Исключительно традиционное, восхитительно утонченное."
	description_fluff = "Чай остается важной традицией во многих культурах, зародившихся на Земле. Среди них зеленый чай, пожалуй, самый традиционный из всех... Через торговые автоматы современной эпохи вряд ли можно отдать ему должное."
	icon_state = "greentea_vended"
	item_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=16, "y"=14)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/greentea/Initialize()
	. = ..()
	reagents.add_reagent("greentea", 30)

/obj/item/weapon/reagent_containers/food/drinks/chaitea
	name = "чашка чаи чая"
	desc = "Название излишне, но вкус восхитительный!"
	description_fluff = "Чаи чай - чай, смешанный с пряной смесью корицы и гвоздики - граничит с национальным напитком на Кишаре."
	icon_state = "chai_vended"
	item_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=16, "y"=14)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/chaitea/Initialize()
	. = ..()
	reagents.add_reagent("chaitea", 30)

/obj/item/weapon/reagent_containers/food/drinks/decaf
	name = "чашка кофе без кофеина"
	desc = "Кофе с высосанным пробуждением."
	description_fluff = "A trial run on two NanoTrasen stations in 2481 attempted to replace all vending machine coffee with decaf in order to combat an epidemic of caffeine addiction. After two days, three major industrial accidents and a death, the initiative was cancelled. Decaf is now thankfully optional."
	icon_state = "coffee"
	item_state = "coffee"
	trash = /obj/item/trash/coffee
	center_of_mass = list("x"=16, "y"=14)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/decaf/Initialize()
	. = ..()
	reagents.add_reagent("decaf", 30)

/obj/item/weapon/reagent_containers/food/drinks/dry_ramen
	name = "Чашка Рамена"
	desc = "Просто добавьте 10 мл воды, самонагревается! Вкус, напоминающий о школьных годах."
	description_fluff = "Бренд Konohagakure Ramen был одним из основных продуктов быстрого приготовления на протяжении веков. Дешево, быстро и доступно более двухсот сортов, хотя большинство из них по вкусу напоминает искусственную курицу."
	icon_state = "ramen"
	trash = /obj/item/trash/ramen
	center_of_mass = list("x"=16, "y"=11)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/dry_ramen/Initialize()
	. = ..()
	reagents.add_reagent("dry_ramen", 30)

/obj/item/weapon/reagent_containers/food/drinks/sillycup
	name = "бумажный стакан"
	desc = "Бумажный стаканчик для воды."
	icon_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = list("x"=16, "y"=12)
	drop_sound = 'sound/items/drop/papercup.ogg'
	pickup_sound = 'sound/items/pickup/papercup.ogg'

/obj/item/weapon/reagent_containers/food/drinks/sillycup/Initialize()
	. = ..()

/obj/item/weapon/reagent_containers/food/drinks/sillycup/on_reagent_change()
	..()
	if(reagents.total_volume)
		icon_state = "water_cup"
	else
		icon_state = "water_cup_e"

/obj/item/weapon/reagent_containers/food/drinks/sillycup/MouseDrop(obj/over_object as obj)
	if(!reagents.total_volume && istype(over_object, /obj/structure/reagent_dispensers/water_cooler))
		if(over_object.Adjacent(usr))
			var/obj/structure/reagent_dispensers/water_cooler/W = over_object
			if(W.cupholder && W.cups < 10)
				W.cups++
				to_chat(usr, "<span class='notice'>Вы кладете [src] в дозатор стаканов.</span>")
				qdel(src)
				W.update_icon()
	else
		return ..()

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
//	itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
//	icon states.

/obj/item/weapon/reagent_containers/food/drinks/shaker
	name = "шейкер"
	desc = "Металлический шейкер для смешивания напитков."
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = list("x"=17, "y"=10)

/obj/item/weapon/reagent_containers/food/drinks/shaker/on_reagent_change()
	..()

/obj/item/weapon/reagent_containers/food/drinks/teapot
	name = "чайник"
	desc = "Элегантный чайник. Он просто источает класс."
	icon_state = "teapot"
	item_state = "teapot"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/food/drinks/teapot/on_reagent_change()
	..()

/obj/item/weapon/reagent_containers/food/drinks/flask
	name = "фляжка Директора Колонии"
	desc = "Металлическая фляга, принадлежащая Директору колонии."
	icon_state = "flask"
	volume = 60
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/food/drinks/flask/on_reagent_change()
	..()

/obj/item/weapon/reagent_containers/food/drinks/flask/shiny
	name = "блестящая фляжка"
	desc = "Блестящая металлическая фляга. Похоже, на нем написан греческий символ."
	icon_state = "shinyflask"

/obj/item/weapon/reagent_containers/food/drinks/flask/lithium
	name = "литиевая фляжка"
	desc = "Фляжка с символом атома лития на ней."
	icon_state = "lithiumflask"

/obj/item/weapon/reagent_containers/food/drinks/flask/detflask
	name = "фляжка Детектива"
	desc = "Металлическая фляга с кожаным ремешком и золотым значком, принадлежащая детективу."
	icon_state = "detflask"
	volume = 60
	center_of_mass = list("x"=17, "y"=8)

/obj/item/weapon/reagent_containers/food/drinks/flask/barflask
	name = "фляжка"
	desc = "Для тех, кто не хочет тусоваться в баре, чтобы выпить."
	icon_state = "barflask"
	volume = 60
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/food/drinks/flask/vacuumflask
	name = "термос"
	desc = "Хранение напитков при идеальной температуре с 1892 года."
	icon_state = "vacuumflask"
	volume = 60
	center_of_mass = list("x"=15, "y"=4)

/obj/item/weapon/reagent_containers/food/drinks/britcup
	name = "чашка"
	desc = "Чашка с изображением британского флага."
	icon_state = "britcup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)

/obj/item/weapon/reagent_containers/food/drinks/britcup/on_reagent_change()
	..()

