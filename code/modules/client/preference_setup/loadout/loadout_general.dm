/datum/gear/cane
	display_name = "Трость"
	path = /obj/item/weapon/cane

/datum/gear/cane/white
	display_name = "Трость, белая"
	path = /obj/item/weapon/cane/white

/datum/gear/cane/white2
	display_name = "Трость, белая, складная"
	path = /obj/item/weapon/cane/white/collapsible

/datum/gear/crutch
	display_name = "Костыль"
	path = /obj/item/weapon/cane/crutch

/datum/gear/dice
	display_name = "Набор кубиков, обычный"
	path = /obj/item/weapon/storage/pill_bottle/dice

/datum/gear/dice/nerd
	display_name = "Набор кубиков, особый"
	path = /obj/item/weapon/storage/pill_bottle/dice_nerd

/datum/gear/dice/cup
	display_name = "Набор кубиков со стаканом"
	path = /obj/item/weapon/storage/dicecup/loaded

/datum/gear/cards
	display_name = "Колода игральных карт"
	path = /obj/item/weapon/deck/cards

/datum/gear/tarot
	display_name = "Колода карт таро"
	path = /obj/item/weapon/deck/tarot

/datum/gear/holder
	display_name = "Чехол для колоды карт"
	path = /obj/item/weapon/deck/holder

/datum/gear/cardemon_pack
	display_name = "Набор карточек Кардемон"
	path = /obj/item/weapon/pack/cardemon

/datum/gear/spaceball_pack
	display_name = "Набор карточек Спейсбол"
	path = /obj/item/weapon/pack/spaceball

/datum/gear/plushie
	display_name = "Плюшевая игрушка (выбор)"
	path = /obj/item/toy/plushie/

/datum/gear/plushie/New()
	..()
	var/list/plushies = list()
	for(var/plushie in subtypesof(/obj/item/toy/plushie/) - /obj/item/toy/plushie/therapy)
		var/obj/item/toy/plushie/plushie_type = plushie
		plushies[initial(plushie_type.name)] = plushie_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(plushies))

/datum/gear/figure
	display_name = "Коллекционная фигурка (выбор)"
	description = "Коллекционная фигурка бренда \"Space Life\"."
	path = /obj/item/toy/figure/

/datum/gear/figure/New()
	..()
	var/list/figures = list()
	for(var/figure in typesof(/obj/item/toy/figure/) - /obj/item/toy/figure)
		var/obj/item/toy/figure/figure_type = figure
		figures[initial(figure_type.name)] = figure_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(figures))

/datum/gear/toy
	display_name = "Игрушка"
	description = "Различные игрушки на выбор."
	path = /obj/item/toy/

/* VOREStation removal
/datum/gear/toy/New()
	..()
	var/toytype = list()
	toytype["Светяшка"] = /obj/item/toy/blink
	toytype["Гравитационная сингулярность"] = /obj/item/toy/spinningtoy
	toytype["Цветок-прыскалка"] = /obj/item/weapon/reagent_containers/spray/waterflower
	toytype["Свисток Босуна"] = /obj/item/toy/bosunwhistle
	toytype["Волшебный шар"] = /obj/item/toy/eight_ball
	toytype["Волшебная ракушка"] = /obj/item/toy/eight_ball/conch
	gear_tweaks += new/datum/gear_tweak/path(toytype)
*/

/datum/gear/flask
	display_name = "Фляга"
	path = /obj/item/weapon/reagent_containers/food/drinks/flask/barflask

/datum/gear/flask/New()
	..()
	gear_tweaks += new/datum/gear_tweak/reagents(lunchables_ethanol_reagents())

/datum/gear/vacflask
	display_name = "Термос"
	path = /obj/item/weapon/reagent_containers/food/drinks/flask/vacuumflask

/datum/gear/vacflask/New()
	..()
	gear_tweaks += new/datum/gear_tweak/reagents(lunchables_drink_reagents())

/datum/gear/lunchbox
	display_name = "Ланч-бокс"
	description = "Маленькая коробочка для завтраков."
	cost = 2
	path = /obj/item/weapon/storage/toolbox/lunchbox

/datum/gear/lunchbox/New()
	..()
	var/list/lunchboxes = list()
	for(var/lunchbox_type in typesof(/obj/item/weapon/storage/toolbox/lunchbox))
		var/obj/item/weapon/storage/toolbox/lunchbox/lunchbox = lunchbox_type
		if(!initial(lunchbox.filled))
			lunchboxes[initial(lunchbox.name)] = lunchbox_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(lunchboxes))
	gear_tweaks += new/datum/gear_tweak/contents(lunchables_lunches(), lunchables_snacks(), lunchables_drinks())

/datum/gear/towel
	display_name = "Полотенце"
	path = /obj/item/weapon/towel

/datum/gear/towel/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/cahwhite
	display_name = "Карты Против Галактики (белая колода)"
	path = /obj/item/weapon/deck/cah
	description = "Не выходящая из моды словесная игра: Карты Против Галактики. Предупреждение: может содержать остатки разрушенных четвертых стен. Это белая колода."

/datum/gear/cahblack
	display_name = "Карты Против Галактики (черная колода)"
	path = /obj/item/weapon/deck/cah/black
	description = "Не выходящая из моды словесная игра: Карты Против Галактики. Предупреждение: может содержать остатки разрушенных четвертых стен. Это черная колода."
