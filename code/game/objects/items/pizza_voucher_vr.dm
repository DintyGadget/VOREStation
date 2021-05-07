/obj/item/pizzavoucher
	name = "бесплатный ваучер на пиццу"
	desc = "Карманный пластиковый слип с пуговицей посередине. Надпись на нем, кажется, потускнела."
	icon = 'icons/obj/items.dmi'
	icon_state = "pizza_voucher"
	var/spent = FALSE
	var/special_delivery = FALSE
	w_class = ITEMSIZE_SMALL

/obj/item/pizzavoucher/New()
	..()
	var/list/descstrings = list("24/7 ПИЦЦА ПИРОГ НЕБО",
	"МЫ ВСЕГДА ДОСТАВЛЯЕМ!",
	"24-ЧАСОВАЯ СИЛА ПИЦЦЫ!",
	"ТОМАТНЫЙ СОУС, СЫР, У НАС ЕСТЬ И ТО, И ДРУГОЕ!",
	"ПРИГОТОВЛЕНО С ЛЮБОВЬЮ В БОЛЬШОЙ ДУХОВКЕ!",
	"КОГДА ВАМ НУЖЕН КУСОЧЕК РАДОСТИ В ВАШЕЙ ЖИЗНИ!",
	"КОГДА ВАМ НУЖЕН ДИСК ЗАПЕЧЕННОГО В ДУХОВКЕ БЛАЖЕНСТВА!",
	"КАЖДЫЙ РАЗ, КОГДА ВЫ МЕЧТАЕТЕ О КРУГЛОЙ КУХНЕ!",
	"МЫ ВСЕГДА ДОСТАВЛЯЕМ! МЫ ВСЕГДА ДОСТАВЛЯЕМ! МЫ ВСЕГДА ДОСТАВЛЯЕМ!")
	desc = "Пластиковая накладка карманного размера с пуговицей посередине. \"[pick(descstrings)]\" написано на обороте."

/obj/item/pizzavoucher/attack_self(mob/user)
	add_fingerprint(user)
	if(!spent)
		user.visible_message("<span class='notice'>[user] нажимает кнопку на [src]!</span>")
		desc = desc + " Этот, кажется, израсходован."
		spent = TRUE
		user.visible_message("<span class='notice'>Небольшая bluespace трещина открывается прямо над головой [user] и выплевывает коробку из-под пиццы!</span>",
			"<span class='notice'>Прямо над вашей головой открывается небольшой bluespace, из которого выплевывается коробка из-под пиццы!</span>",
			"<span class='notice'>Вы слышите фуршет, за которым следует стук.</span>")
		if(special_delivery)
			command_announcement.Announce("СПЕЦИАЛЬНАЯ ДОСТАВКА ЗАКАЗ ПИЦЦЫ #[rand(1000,9999)]-[rand(100,999)] БЫЛ ПОЛУЧЕН. ОТГРУЗКА ОТПРАВЛЯЕТСЯ С ПОМОЩЬЮ МОЩНЫХ БАЛЛИСТИЧЕСКИХ ПУСКОВ ДЛЯ НЕМЕДЛЕННОЙ ДОСТАВКИ! СПАСИБО И НАСЛАЖДАЙТЕСЬ ПИЦЦЕЙ!", "МЫ ВСЕГДА ДОСТАВЛЯЕМ!")
			new /obj/effect/falling_effect/pizza_delivery/special(user.loc)
		else
			new /obj/effect/falling_effect/pizza_delivery(user.loc)
	else
		to_chat(user, "<span class='warning'>[src] потрачен!</span>")

/obj/item/pizzavoucher/emag_act(var/remaining_charges, var/mob/user)
	if(spent)
		to_chat(user, "<span class='warning'>[src] потрачен!</span>")
		return
	if(!special_delivery)
		to_chat(user, "<span class='warning'>Вы активируете специальный протокол доставки на [src]!</span>")
		special_delivery = TRUE
		return 1
	else
		to_chat(user, "<span class='warning'>[src] уже находится в специальном режиме доставки!</span>")

/obj/effect/falling_effect/pizza_delivery
	name = "PIZZA PIE POWER!"
	crushing = FALSE

/obj/effect/falling_effect/pizza_delivery/Initialize(mapload)
	..()
	falling_type = pick(prob(20);/obj/item/pizzabox/meat,
				prob(20);/obj/item/pizzabox/margherita,
				prob(20);/obj/item/pizzabox/vegetable,
				prob(20);/obj/item/pizzabox/mushroom,
				prob(20);/obj/item/pizzabox/pineapple)
	return INITIALIZE_HINT_LATELOAD

/obj/effect/falling_effect/pizza_delivery/special
	crushing = TRUE
