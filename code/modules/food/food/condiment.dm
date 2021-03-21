
///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
//	leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
//	to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/weapon/reagent_containers/food/condiment
	name = "Condiment Container"
	desc = "Просто ваш средний контейнер для приправ."
	icon = 'icons/obj/food.dmi'
	icon_state = "emptycondiment"
	flags = OPENCONTAINER
	possible_transfer_amounts = list(1,5,10)
	center_of_mass = list("x"=16, "y"=6)
	volume = 50

/obj/item/weapon/reagent_containers/food/condiment/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	return

/obj/item/weapon/reagent_containers/food/condiment/attack_self(var/mob/user as mob)
	return

/obj/item/weapon/reagent_containers/food/condiment/attack(var/mob/M as mob, var/mob/user as mob, var/def_zone)
	if(standard_feed_mob(user, M))
		return

/obj/item/weapon/reagent_containers/food/condiment/afterattack(var/obj/target, var/mob/user, var/flag)
	if(!user.Adjacent(target))
		return
	if(standard_dispenser_refill(user, target))
		return
	if(standard_pour_into(user, target))
		return

	if(istype(target, /obj/item/weapon/reagent_containers/food/snacks)) // These are not opencontainers but we can transfer to them
		if(!reagents || !reagents.total_volume)
			to_chat(user, "<span class='notice'>В [src] не осталось никакой приправы.</span>")
			return

		if(!target.reagents.get_free_space())
			to_chat(user, "<span class='notice'>Вы не можете добавить больше приправы к [target].</span>")
			return

		var/trans = reagents.trans_to_obj(target, amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>Вы добавляете [trans] единиц приправы к [target].</span>")
	else
		..()

/obj/item/weapon/reagent_containers/food/condiment/feed_sound(var/mob/user)
	playsound(src, 'sound/items/drink.ogg', rand(10, 50), 1)

/obj/item/weapon/reagent_containers/food/condiment/self_feed_message(var/mob/user)
	to_chat(user, "<span class='notice'>Вы проглатываете часть содержимого [src].</span>")

/obj/item/weapon/reagent_containers/food/condiment/on_reagent_change()
	if(reagents.reagent_list.len > 0)
		switch(reagents.get_master_reagent_id())
			if("ketchup")
				name = "Ketchup"
				desc = "Теперь ты чувствуешь себя американцем."
				icon_state = "ketchup"
				center_of_mass = list("x"=16, "y"=6)
			if("capsaicin")
				name = "Hotsauce"
				desc = "Теперь язвы желудка ощущаются на вкус!"
				icon_state = "hotsauce"
				center_of_mass = list("x"=16, "y"=6)
			if("enzyme")
				name = "Universal Enzyme"
				desc = "Используется при приготовлении различных блюд."
				icon_state = "enzyme"
				center_of_mass = list("x"=16, "y"=6)
			if("soysauce")
				name = "Soy Sauce"
				desc = "Соленый ароматизатор на основе сои."
				icon_state = "soysauce"
				center_of_mass = list("x"=16, "y"=6)
			if("frostoil")
				name = "Coldsauce"
				desc = "Оставляет язык онемевшим после пробы."
				icon_state = "coldsauce"
				center_of_mass = list("x"=16, "y"=6)
			if("sodiumchloride")
				name = "Salt Shaker"
				desc = "Соль. Вероятно, из космических океанов."
				icon_state = "saltshaker"
				center_of_mass = list("x"=17, "y"=11)
			if("blackpepper")
				name = "Pepper Mill"
				desc = "Часто используется для ароматизации пищи или для того, чтобы люди чихали."
				icon_state = "peppermillsmall"
				center_of_mass = list("x"=17, "y"=11)
			if("cornoil")
				name = "Corn Oil"
				desc = "Восхитительное масло, используемое в кулинарии. Сделано из кукурузы."
				icon_state = "oliveoil"
				center_of_mass = list("x"=16, "y"=6)
			if("sugar")
				name = "Sugar"
				desc = "Вкусный космический сахар!"
				center_of_mass = list("x"=16, "y"=6)
			if("peanutbutter")
				name = "Peanut Butter"
				desc = "Баночка гладкого арахисового масла."
				icon_state = "peanutbutter"
				center_of_mass = list("x"=16, "y"=6)
			if("mayo")
				name = "Mayonnaise"
				desc = "Баночка майонеза!"
				icon_state = "mayo"
				center_of_mass = list("x"=16, "y"=6)
			if("yeast")
				name = "Yeast"
				desc = "Это то, что вы используете, чтобы сделать хлеб пушистым."
				icon_state = "yeast"
				center_of_mass = list("x"=16, "y"=6)
			if("spacespice")
				name = "bottle of space spice"
				desc = "Экзотическая смесь специй для приготовления пищи. Определенно не черви."
				icon = 'icons/obj/food_syn.dmi'
				icon_state = "spacespicebottle"
				center_of_mass = list("x"=16, "y"=6)
			if("barbecue")
				name = "barbecue sauce"
				desc = "Соус для барбекю, он помечен как \"сладкий и острый\"."
				icon_state = "barbecue"
				center_of_mass = list("x"=16, "y"=6)
			else
				name = "Misc Condiment Bottle"
				if (reagents.reagent_list.len==1)
					desc = "Выглядит как [reagents.get_master_reagent_name()], но вы не уверены."
				else
					desc = "Смесь различных приправ. [reagents.get_master_reagent_name()] это один из них."
				icon_state = "mixedcondiments"
				center_of_mass = list("x"=16, "y"=6)
	else
		icon_state = "emptycondiment"
		name = "Condiment Bottle"
		desc = "Пустая бутылка из-под приправ."
		center_of_mass = list("x"=16, "y"=6)
		return

/obj/item/weapon/reagent_containers/food/condiment/enzyme
	name = "Universal Enzyme"
	desc = "Используется при приготовлении различных блюд."
	icon_state = "enzyme"

/obj/item/weapon/reagent_containers/food/condiment/enzyme/Initialize()
	. = ..()
	reagents.add_reagent("enzyme", 50)

/obj/item/weapon/reagent_containers/food/condiment/sugar/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 50)

/obj/item/weapon/reagent_containers/food/condiment/ketchup/Initialize()
	. = ..()
	reagents.add_reagent("ketchup", 50)

/obj/item/weapon/reagent_containers/food/condiment/hotsauce/Initialize()
	. = ..()
	reagents.add_reagent("capsaicin", 50)

/obj/item/weapon/reagent_containers/food/condiment/cornoil
	name = "Corn Oil"

/obj/item/weapon/reagent_containers/food/condiment/cornoil/Initialize()
	. = ..()
	reagents.add_reagent("cornoil", 50)

/obj/item/weapon/reagent_containers/food/condiment/coldsauce/Initialize()
	. = ..()
	reagents.add_reagent("frostoil", 50)

/obj/item/weapon/reagent_containers/food/condiment/soysauce/Initialize()
	. = ..()
	reagents.add_reagent("soysauce", 50)

/obj/item/weapon/reagent_containers/food/condiment/yeast
	name = "Yeast"

/obj/item/weapon/reagent_containers/food/condiment/yeast/Initialize()
	. = ..()
	reagents.add_reagent("yeast", 50)

/obj/item/weapon/reagent_containers/food/condiment/small
	possible_transfer_amounts = list(1,20)
	amount_per_transfer_from_this = 1
	volume = 20
	center_of_mass = list()

/obj/item/weapon/reagent_containers/food/condiment/small/on_reagent_change()
	return

/obj/item/weapon/reagent_containers/food/condiment/small/saltshaker	//Seperate from above since it's a small shaker rather then
	name = "salt shaker"											//	a large one.
	desc = "Соль. Вероятно, из космических океанов."
	icon_state = "saltshakersmall"
	center_of_mass = list("x"=17, "y"=11)

/obj/item/weapon/reagent_containers/food/condiment/small/saltshaker/Initialize()
	. = ..()
	reagents.add_reagent("sodiumchloride", 20)

/obj/item/weapon/reagent_containers/food/condiment/small/peppermill
	name = "pepper mill"
	desc = "Часто используется для ароматизации пищи или для того, чтобы люди чихали."
	icon_state = "peppermillsmall"
	center_of_mass = list("x"=17, "y"=11)

/obj/item/weapon/reagent_containers/food/condiment/small/peppermill/Initialize()
	. = ..()
	reagents.add_reagent("blackpepper", 20)

/obj/item/weapon/reagent_containers/food/condiment/small/sugar
	name = "sugar"
	desc = "Сладость в бутылке"
	icon_state = "sugarsmall"

/obj/item/weapon/reagent_containers/food/condiment/small/sugar/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 20)

//MRE condiments and drinks.

/obj/item/weapon/reagent_containers/food/condiment/small/packet
	icon_state = "packet_small"
	w_class = ITEMSIZE_TINY
	possible_transfer_amounts = "1;5;10"
	amount_per_transfer_from_this = 1
	volume = 5

/obj/item/weapon/reagent_containers/food/condiment/small/packet/salt
	name = "salt packet"
	desc = "Содержит 5u поваренной соли."
	icon_state = "packet_small_white"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/salt/Initialize()
	. = ..()
	reagents.add_reagent("sodiumchloride", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/pepper
	name = "pepper packet"
	desc = "Содержит 5u черного перца."
	icon_state = "packet_small_black"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/pepper/Initialize()
	. = ..()
	reagents.add_reagent("blackpepper", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/sugar
	name = "sugar packet"
	desc = "Содержит 5u рафинированного сахара."
	icon_state = "packet_small_white"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/sugar/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/jelly
	name = "jelly packet"
	desc = "Содержит 10u вишневого желе. Лучше всего использовать для намазывания на крекеры."
	icon_state = "packet_medium"
	volume = 10

/obj/item/weapon/reagent_containers/food/condiment/small/packet/jelly/Initialize()
	. = ..()
	reagents.add_reagent("cherryjelly", 10)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/honey
	name = "honey packet"
	desc = "Содержит 10u меда."
	icon_state = "packet_medium"
	volume = 10

/obj/item/weapon/reagent_containers/food/condiment/small/packet/honey/Initialize()
	. = ..()
	reagents.add_reagent("honey", 10)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/capsaicin
	name = "hot sauce packet"
	desc = "Содержит 5u острого соуса. Наслаждайтесь в меру."
	icon_state = "packet_small_red"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/capsaicin/Initialize()
	. = ..()
	reagents.add_reagent("capsaicin", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/ketchup
	name = "ketchup packet"
	desc = "Содержит 5u кетчупа."
	icon_state = "packet_small_red"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/ketchup/Initialize()
	. = ..()
	reagents.add_reagent("ketchup", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/mayo
	name = "mayonnaise packet"
	desc = "Содержит 5u майонеза."
	icon_state = "packet_small_white"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/mayo/Initialize()
	. = ..()
	reagents.add_reagent("mayo", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/soy
	name = "soy sauce packet"
	desc = "Содержит 5u соевого соуса."
	icon_state = "packet_small_black"

/obj/item/weapon/reagent_containers/food/condiment/small/packet/soy/Initialize()
	. = ..()
	reagents.add_reagent("soysauce", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/coffee
	name = "coffee powder packet"
	desc = "Содержит 5u кофейного порошка. Смешайте с 25u воды и нагрейте."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/coffee/Initialize()
	. = ..()
	reagents.add_reagent("coffeepowder", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/tea
	name = "tea powder packet"
	desc = "Содержит 5u порошка черного чая. Смешайте с 25u воды и нагрейте."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/tea/Initialize()
	. = ..()
	reagents.add_reagent("tea", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/cocoa
	name = "cocoa powder packet"
	desc = "Содержит 5u какао-порошка. Смешайте с 25u воды и нагрейте."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/cocoa/Initialize()
	. = ..()
	reagents.add_reagent("coco", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/grape
	name = "grape juice powder packet"
	desc = "Содержит 5u порошкообразного виноградного сока. Смешайте с 15u воды."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/grape/Initialize()
	. = ..()
	reagents.add_reagent("instantgrape", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/orange
	name = "orange juice powder packet"
	desc = "Содержит 5u порошкообразного апельсинового сока. Смешайте с 15u воды."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/orange/Initialize()
	. = ..()
	reagents.add_reagent("instantorange", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/watermelon
	name = "watermelon juice powder packet"
	desc = "Содержит 5u порошкообразного арбузного сока. Смешайте с 15u воды."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/watermelon/Initialize()
	. = ..()
	reagents.add_reagent("instantwatermelon", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/apple
	name = "apple juice powder packet"
	desc = "Содержит 5u порошкообразного яблочного сока. Смешайте с 15u воды."

/obj/item/weapon/reagent_containers/food/condiment/small/packet/apple/Initialize()
	. = ..()
	reagents.add_reagent("instantapple", 5)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/protein
	name = "protein powder packet"
	desc = "Содержит 10u порошкообразного белка. Смешайте с 20u воды."
	icon_state = "packet_medium"
	volume = 10

/obj/item/weapon/reagent_containers/food/condiment/small/packet/protein/Initialize()
	. = ..()
	reagents.add_reagent("protein", 10)

/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon
	name = "crayon powder packet"
	desc = "Содержит 10u порошкообразного мелка. Смешайте с 30u воды."
	volume = 10
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/generic/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/red/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_red", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/orange/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_orange", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/yellow/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_yellow", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/green/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_green", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/blue/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_blue", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/purple/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_purple", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/grey/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_grey", 10)
/obj/item/weapon/reagent_containers/food/condiment/small/packet/crayon/brown/Initialize()
	. = ..()
	reagents.add_reagent("crayon_dust_brown", 10)

//End of MRE stuff.

/obj/item/weapon/reagent_containers/food/condiment/flour
	name = "flour sack"
	desc = "Большой мешок муки. Хорош для выпечки!"
	icon = 'icons/obj/food.dmi'
	icon_state = "flour"
	volume = 220
	center_of_mass = list("x"=16, "y"=8)

/obj/item/weapon/reagent_containers/food/condiment/flour/on_reagent_change()
	return

/obj/item/weapon/reagent_containers/food/condiment/flour/Initialize()
	. = ..()
	reagents.add_reagent("flour", 200)
	randpixel_xy()

/obj/item/weapon/reagent_containers/food/condiment/spacespice
	name = "space spices"
	desc = "Экзотическая смесь специй для приготовления пищи. Определенно не черви."
	icon = 'icons/obj/food_syn.dmi'
	icon_state = "spacespicebottle"
	possible_transfer_amounts = list(1,40) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 40

/obj/item/weapon/reagent_containers/food/condiment/spacespice/on_reagent_change()
	return

/obj/item/weapon/reagent_containers/food/condiment/spacespice/Initialize()
	. = ..()
	reagents.add_reagent("spacespice", 40)