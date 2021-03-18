//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

var/cultwords = list()
var/runedec = 0
var/global/list/engwords = list("путешествие", "кровь", "присоединение", "ад", "разрушение", "технологии", "я", "видимость", "другое", "скрытность")
var/global/list/rnwords = list("гнев","эго","нахлизет","определенность","правда","джатка","мгар","балак", "каразет", "гиери")

/client/proc/check_words() // -- Urist
	set category = "Special Verbs"
	set name = "Проверить рунические слова"
	set desc = "Check the rune-word meaning"
	if(!cultwords["travel"])
		runerandom()
	for (var/word in engwords)
		to_chat(usr, "[cultwords[word]] это [word]")

/proc/runerandom() //randomizes word meaning
	var/list/runewords=rnwords
	for (var/word in engwords)
		cultwords[word] = pick(runewords)
		runewords-=cultwords[word]

/obj/effect/rune
	desc = "Странная коллекция символов, нарисованных кровью."
	anchored = 1
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	var/visibility = 0
	unacidable = 1
	layer = TURF_LAYER


	var/word1
	var/word2
	var/word3
	var/image/blood_image
	var/list/converting = list()

// Places these combos are mentioned: this file - twice in the rune code, once in imbued tome, once in tome's HTML runes.dm - in the imbue rune code. If you change a combination - dont forget to change it everywhere.

// travel self [word] - Teleport to random [rune with word destination matching]
// travel other [word] - Portal to rune with word destination matching - kinda doesnt work. At least the icon. No idea why.
// see blood Hell - Create a new tome
// join blood self - Incorporate person over the rune into the group
// Hell join self - Summon TERROR
// destroy see technology - EMP rune
// travel blood self - Drain blood
// see Hell join - See invisible
// blood join Hell - Raise dead

// hide see blood - Hide nearby runes
// blood see hide - Reveal nearby runes  - The point of this rune is that its reversed obscure rune. So you always know the words to reveal the rune once oyu have obscured it.

// Hell travel self - Leave your body and ghost around
// blood see travel - Manifest a ghost into a mortal body
// Hell tech join - Imbue a rune into a talisman
// Hell blood join - Sacrifice rune
// destroy travel self - Wall rune
// join other self - Summon cultist rune
// travel technology other - Freeing rune    //    other blood travel was freedom join other

// hide other see - Deafening rune     //     was destroy see hear
// destroy see other - Blinding rune
// destroy see blood - BLOOD BOIL

// self other technology - Communication rune  //was other hear blood
// join hide technology - stun rune. Rune color: bright pink.
	New()
		..()
		blood_image = image(loc = src)
		blood_image.override = 1
		for(var/mob/living/silicon/ai/AI in player_list)
			if(AI.client)
				AI.client.images += blood_image
		rune_list.Add(src)

	Destroy()
		for(var/mob/living/silicon/ai/AI in player_list)
			if(AI.client)
				AI.client.images -= blood_image
		qdel(blood_image)
		blood_image = null
		rune_list.Remove(src)
		..()

	examine(mob/user)
		. = ..()
		if(iscultist(user))
			. += "Этот круг заклинаний гласит: <i>[word1] [word2] [word3]</i>."


	attackby(I as obj, user as mob)
		if(istype(I, /obj/item/weapon/book/tome) && iscultist(user))
			to_chat(user, "Вы возвращаетесь по своим следам, осторожно разглаживая линии руны.")
			qdel(src)
			return
		else if(istype(I, /obj/item/weapon/nullrod))
			to_chat(user, "<span class='notice'>Вы разрушаете мерзкую магию мертвящим полем нулевого стержня!</span>")
			qdel(src)
			return
		return


	attack_hand(mob/living/user as mob)
		if(!iscultist(user))
			to_chat(user, "Вы не можете выговорить загадочные царапины, не перебирая их.")
			return
		if(user.is_muzzled())
			to_chat(user, "Вы не можете произносить слова руны.")
			return
		if(!word1 || !word2 || !word3 || prob(user.getBrainLoss()))
			return fizzle()
//		if(!src.visibility)
//			src.visibility=1
		if(word1 == cultwords["путешествие"] && word2 == cultwords["я"])
			return teleport(src.word3)
		if(word1 == cultwords["видимость"] && word2 == cultwords["кровь"] && word3 == cultwords["ад"])
			return tomesummon()
		if(word1 == cultwords["ад"] && word2 == cultwords["разрушение"] && word3 == cultwords["другое"])
			return armor()
		if(word1 == cultwords["присоединение"] && word2 == cultwords["кровь"] && word3 == cultwords["я"])
			return convert()
		if(word1 == cultwords["ад"] && word2 == cultwords["присоединение"] && word3 == cultwords["я"])
			return tearreality()
		if(word1 == cultwords["разрушение"] && word2 == cultwords["видимость"] && word3 == cultwords["технологии"])
			return emp(src.loc,5)
		if(word1 == cultwords["путешествие"] && word2 == cultwords["кровь"] && word3 == cultwords["я"])
			return drain()
		if(word1 == cultwords["видимость"] && word2 == cultwords["ад"] && word3 == cultwords["присоединение"])
			return seer()
		if(word1 == cultwords["кровь"] && word2 == cultwords["присоединение"] && word3 == cultwords["ад"])
			return raise()
		if(word1 == cultwords["скрытность"] && word2 == cultwords["видимость"] && word3 == cultwords["кровь"])
			return obscure(4)
		if(word1 == cultwords["ад"] && word2 == cultwords["путешествие"] && word3 == cultwords["я"])
			return ajourney()
		if(word1 == cultwords["кровь"] && word2 == cultwords["видимость"] && word3 == cultwords["путешествие"])
			return manifest()
		if(word1 == cultwords["ад"] && word2 == cultwords["технологии"] && word3 == cultwords["присоединение"])
			return talisman()
		if(word1 == cultwords["ад"] && word2 == cultwords["кровь"] && word3 == cultwords["присоединение"])
			return sacrifice()
		if(word1 == cultwords["кровь"] && word2 == cultwords["видимость"] && word3 == cultwords["скрытность"])
			return revealrunes(src)
		if(word1 == cultwords["разрушение"] && word2 == cultwords["путешествие"] && word3 == cultwords["я"])
			return wall()
		if(word1 == cultwords["путешествие"] && word2 == cultwords["технологии"] && word3 == cultwords["другое"])
			return freedom()
		if(word1 == cultwords["присоединение"] && word2 == cultwords["другое"] && word3 == cultwords["я"])
			return cultsummon()
		if(word1 == cultwords["скрытность"] && word2 == cultwords["другое"] && word3 == cultwords["видимость"])
			return deafen()
		if(word1 == cultwords["разрушение"] && word2 == cultwords["видимость"] && word3 == cultwords["другое"])
			return blind()
		if(word1 == cultwords["разрушение"] && word2 == cultwords["видимость"] && word3 == cultwords["кровь"])
			return bloodboil()
		if(word1 == cultwords["я"] && word2 == cultwords["другое"] && word3 == cultwords["технологии"])
			return communicate()
		if(word1 == cultwords["путешествие"] && word2 == cultwords["другое"])
			return itemport(src.word3)
		if(word1 == cultwords["присоединение"] && word2 == cultwords["скрытность"] && word3 == cultwords["технологии"])
			return runestun()
		else
			return fizzle()


	proc
		fizzle()
			if(istype(src,/obj/effect/rune))
				usr.say(pick("Hakkrutju gopoenjim.", "Nherasai pivroiashan.", "Firjji prhiv mazenhor.", "Tanah eh wakantahe.", "Obliyae na oraie.", "Miyf hon vnor'c.", "Wakabai hij fen juswix."))
			else
				usr.whisper(pick("Hakkrutju gopoenjim.", "Nherasai pivroiashan.", "Firjji prhiv mazenhor.", "Tanah eh wakantahe.", "Obliyae na oraie.", "Miyf hon vnor'c.", "Wakabai hij fen juswix."))
			for (var/mob/V in viewers(src))
				V.show_message("<span class='warning'>Маркировка пульсирует небольшой вспышкой света, затем темнеет.</span>", 3, "<span class='warning'>Вы слышите слабое шипение.</span>", 2)
			return

		check_icon()
			icon = get_uristrune_cult(word1, word2, word3)

/obj/item/weapon/book/tome
	name = "arcane tome"
	icon = 'icons/obj/weapons.dmi'
	item_icons = list(
		icon_l_hand = 'icons/mob/items/lefthand_books.dmi',
		icon_r_hand = 'icons/mob/items/righthand_books.dmi',
		)
	icon_state ="tome"
	item_state = "tome"
	throw_speed = 1
	throw_range = 5
	w_class = ITEMSIZE_SMALL
	unique = 1
	var/tomedat = ""
	var/list/words = list("гнев" = "гнев", "эго" = "эго", "нахлизет" = "нахлизет", "определенность" = "определенность", "правда" = "правда", "джатка" = "джатка", "балак" = "балак", "мгар" = "мгар", "каразет" = "каразет", "гиери" = "гиери")

	tomedat = {"<html><meta charset=\"utf-8\">
				<head>
				<style>
				h1 {font-size: 25px; margin: 15px 0px 5px;}
				h2 {font-size: 20px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h1>Священные Писания Нар-Си, Тот, Кто Видит, Геометр Крови.</h1>

				<i>Книга написана на неизвестном диалекте, в ней много изображений различных сложных геометрических форм. Вы найдете несколько заметок на русском, которые дадут вам базовое представление о многих рунах, написанных в книге. Примечания дают вам понимание того, какими должны быть слова для рун. Однако вы не умеете писать все эти слова на этом диалекте.</i><br>
				<i>Ниже приводится сводка рун.</i> <br>

				<h2>СОДЕРЖАНИЕ</h2>
				<p>
				<b>Телепорт себя: </b>Путешествие Я (слово)<br>
				<b>Телепорт кого-то: </b>Путешествие Другое (слово)<br>
				<b>Призвать новый фолиант: </b>Видимость Кровь Ад<br>
				<b>Преобраз. персону: </b>Присоединение Кровь Я<br>
				<b>Призвать Нар-Си: </b>Ад Присоединение Я<br>
				<b>Отключить технологии: </b>Разрушение Видимость Технологии<br>
				<b>Слить кровь: </b>Путешествие Кровь Я<br>
				<b>Воскрешение мертвых: </b>Кровь Присоединение Ад<br>
				<b>Hide runes: </b>Hide See Blood<br>
				<b>Раскрыть скрытые руны: </b>Кровь Видимость Скрытность<br>
				<b>Покинуть тело: </b>Ад Путешествие Я<br>
				<b>Ghost Manifest: </b>Кровь Видимость Путешествие<br>
				<b>Наполнить талисман: </b>Ад Технологии Присоединение<br>
				<b>Жертва: </b>Ад Кровь Присоединение<br>
				<b>Создать стену: </b>Разрушение Путешествие Я<br>
				<b>Призвать культиста: </b>Присоединение Другое Я<br>
				<b>Освободить культиста: </b>Путешествие Технологии Другое<br>
				<b>Оглушение: </b>Скрытность Другое Видимость<br>
				<b>Слепота: </b>Разрушение Видимость Другое<br>
				<b>Вскипание крови: </b>Разрушение Видимость Кровь<br>
				<b>Связаться: </b>Я Другое Технологии<br>
				<b>Стан: </b>Присоединение Скрытность Технологии<br>
				<b>Призвать доспехи культиста: </b>Ад Разрушение Другое<br>
				<b>Увидеть невидимое: </b>Видимость Ад Присоединение<br>
				</p>
				<h2>Описание рун</h2>
				<h3>Телепорт себя</h3>
				Руна телепортации - это особая руна, так как для нее нужно всего два слова, третье слово - пункт назначения. Обычно, когда у вас есть две руны с одним и тем же местом назначения, при вызове одной вы телепортируетесь к другой. Если рун больше 2, вы будете телепортированы к случайной. Руны с разными третьими словами будут создавать отдельные сети. Вы можете превратить эту руну в талисман, что даст вам отличный механизм побега.<br>
				<h3>Телепорт другого</h3>
				Телепорт другого - позволяет телепортировать любой подвижный объект к другой руне с тем же третьим словом. Чтобы эта руна сработала, вам нужно 3 культиста, произносящих заклинание.<br>
				<h3>Призвать новый фолиант</h3>
				Призыв этой руны вызывает новый тайный фолиант.
				<h3>Преобразовать персону</h3>
				Эта руна открывает разум цели в царство Нар-Си, что обычно приводит к тому, что этот человек присоединяется к культу. Однако некоторые люди (в основном те, кто обладает высоким авторитетом) обладают достаточно сильной волей, чтобы оставаться верными своим старым идеалам. <br>
				<h3>Призвать Нар-Си</h3>
				Конечная руна. Он вызывает самого Аватара Нар-Си, разрывая огромную дыру в реальности и поглощая все вокруг. Призвать его - конечная цель любого культа.<br>
				<h3>Отключить технологии</h3>
				Призыв этой руны создает сильный электромагнитный импульс в небольшом радиусе, что делает его в основном аналогом ЭМИ-гранаты. Вы можете превратить эту руну в талисман, сделав ее достойным защитным предметом.<br>
				<h3>Слить кровь</h3>
				Эта руна мгновенно исцеляет вас от некоторых грубых повреждений за счет персоны, помещенной поверх руны. Каждый раз, когда вы вызываете руну высасывания, активируются ВСЕ руны высасывания на станции, высасывая кровь из любого, кто находится поверх этих рун. Это включает и вас самих, хотя кровь, которую вы истекаете из себя, просто возвращается к вам. Это может помочь вам идентифицировать эту руну при изучении слов. Один слив дает до 25ХП на каждую жертву, но вы можете повторить его, если вам нужно больше. Осушение работает только с живыми людьми, поэтому вам может потребоваться подзарядить «Батарею», когда она разрядится. Употребление слишком большого количества крови за один раз может вызвать кровяной голод.<br>
				<h3>Воскрешение мертвых</h3>
				Эта руна позволяет воскресить любого мертвого человека. Вам понадобится мертвое человеческое тело и живое человеческое жертвоприношение. Сделайте 2 руны воскрешения мертвых. Положите живого бодрствующего человека на одно, а на другое - мертвое тело. Когда вы вызываете руну, жизненная сила живого человека переносится в мертвое тело, позволяя призраку, стоящему наверху мертвого тела, войти в него, мгновенно и полностью исцелив его. Используйте другие руны, чтобы убедиться, что призрак готов к воскрешению.<br>
				<h3>Скрыть руны</h3>
				Эта руна делает все близлежащие руны полностью невидимыми. Они все еще там и будут работать, если каким-то образом активировать их, но вы не можете вызывать их напрямую, если не видите их.<br>
				<h3>Раскрыть руны</h3>
				Эта руна предназначена для обращения вспять процесса сокрытия руны. Он показывает все скрытые руны на довольно большой площади вокруг него.
				<h3>Покинуть тело</h3>
				Эта руна мягко вырывает вашу душу из вашего тела, оставляя его нетронутым. Вы можете наблюдать за окружающей обстановкой как призрак, а также общаться с другими призраками. Пока вы там, ваше тело получает повреждения, поэтому убедитесь, что ваше путешествие не будет слишком долгим, иначе вы никогда не вернетесь.<br>
				<h3>Manifest a ghost</h3>
				В отличие от руны Воскрешение метрвых, эта руна не требует специальной подготовки или сосудов. Вместо того, чтобы использовать всю жизненную силу жертвы, она истощит ВАШУ жизненную силу. Встаньте на руну и призовите ее. Если над руной стоит призрак, он материализуется и будет жить до тех пор, пока вы не отойдете от руны и не умрете. Вы можете наклеить листок с именем на руну, чтобы новое тело выглядело как этот человек.<br>
				<h3>Наполнить талисман</h3>
				Эта руна позволяет вам наделить магию некоторых рун бумажными талисманами. Создайте руну наполнения, а затем соответствующую руну рядом с ней. Положите пустой лист бумаги на руну наполнения и призовите ее. Теперь у вас будет одноразовый талисман с силой целевой руны. Использование талисмана истощает здоровье, поэтому будьте осторожны с ним. Вы можете наделить талисман силой следующих рун: вызвать фолиант, раскрыть, скрыть, телепортировать, тизабельная технология, общаться, оглушить, ослепить и оглушить.<br>
				<h3>Жертва</h3>
				Руна жертвоприношения позволяет принести в жертву Геометру крови живое существо или тело. Обезьяны и мертвые люди - самые простые жертвы, их может хватить, а может и не хватить, чтобы снискать Его благосклонность. Живой человек - это то, чем должна быть настоящая жертва, однако для принесения в жертву живого человека вам понадобятся 3 человека, повторяющих призыв.
				<h3>Создать стену</h3>
				Призыв этой руны укрепляет воздух над собой, создавая невидимую стену. Чтобы убрать стену, просто снова вызовите руну.
				<h3>Призвать культиста</h3>
				Эта руна позволяет вам призвать другого культиста к себе. Целевой культист должен быть без наручников и ни к чему не пристегнут. Вам также нужно, чтобы 3 человека повторяли руну, чтобы успешно ее вызвать. Призыв к нему вызывает тяжелую нагрузку на тела всех воспевающих культистов.<br>
				<h3>Освободить культиста</h3>
				Эта руна снимает наручники и расстегивает любого культиста по вашему выбору, где бы он ни находился. Чтобы руна сработала, вам нужно, чтобы 3 человека вызывали ее. Призыв к нему вызывает тяжелую нагрузку на тела всех воспевающих культистов.<br>
				<h3>Оглушение</h3>
				Эта руна временно оглушает всех некультистов вокруг вас.<br>
				<h3>Ослепление</h3>
				Эта руна временно ослепляет всех некультистов вокруг вас. Очень прочный. Используйте вместе с оглушающей руной, чтобы оставить врагов совершенно беспомощными.<br>
				<h3>Вскипание крови</h3>
				Эта руна вскипает в крови всех некультистов в видимом диапазоне. Урон достаточно, чтобы мгновенно нанести критический вред любому человеку. Вам нужно 3 культиста, призывающих руну, чтобы это сработало. Эта руна ненадежна и может вызвать непредсказуемый эффект при использовании. Он также истощает значительное количество вашего здоровья при успешном вызове.<br>
				<h3>Связаться</h3>
				Вызов этой руны позволяет передать сообщение всем культистам на станции и близлежащих космических объектах.
				<h3>Стан</h3>
				В отличие от других рун, эта руна предназначена для использования в форме талисмана. При прямом вызове он просто высвобождает некоторую темную энергию, ненадолго оглушая всех вокруг. Находясь в талисмане, вы можете направить всю его энергию в одного человека, оглушая его так сильно, что он даже не может говорить. Однако эффект проходит довольно быстро.<br>
				<h3>Броня культа</h3>
				Когда эта руна вызывается из руны или талисмана, она снабжает пользователя доспехами последователей Нар-Си. Чтобы использовать эту руну в полной мере, убедитесь, что вы не носите никаких головных уборов, доспехов, перчаток или обуви, и убедитесь, что вы ничего не держите в руках.<br>
				<h3>Видеть Невидимое</h3>
				При вызове, стоя на ней, эта руна позволяет пользователю видеть мир за его пределами, пока он не двигается.<br>
				</body>
				</html>
				"}

	New()
		..()
		if(!cultwords["путешествие"])
			runerandom()
		for(var/V in cultwords)
			words[cultwords[V]] = V

	attack(mob/living/M as mob, mob/living/user as mob)
		add_attack_logs(user,M,"Hit with [name]")

		if(istype(M,/mob/observer/dead))
			var/mob/observer/dead/D = M
			D.manifest(user)
			return
		if(!istype(M))
			return
		if(!iscultist(user))
			return ..()
		if(iscultist(M))
			return
		M.take_organ_damage(0,rand(5,20)) //really lucky - 5 hits for a crit
		for(var/mob/O in viewers(M, null))
			O.show_message("<span class='warning'>[user] превосходит [M] с помощью [src]!</span>", 1)
		to_chat(M, "<span class='danger'>Вы чувствуете жгучий жар внутри!</span>")


	attack_self(mob/living/user as mob)
		usr = user
		if(!usr.canmove || usr.stat || usr.restrained())
			return

		if(!cultwords["путешествие"])
			runerandom()
		if(iscultist(user))
			var/C = 0
			for(var/obj/effect/rune/N in rune_list)
				C++
			if (!istype(user.loc,/turf))
				to_chat(user, "<span class='warning'>У вас недостаточно места, чтобы написать правильную руну.</span>")
				return

			if (C>=26 + runedec + cult.current_antagonists.len) //including the useless rune at the secret room, shouldn't count against the limit of 25 runes - Urist
				alert("Ткань реальности не выдерживает такой большой нагрузки. Сначала удалите несколько рун!")
				return
			else
				switch(alert("Вы открываете фолиант",,"Прочитать","Начертать руну", "Отмена"))
					if("Отмена")
						return
					if("Прочитать")
						if(usr.get_active_hand() != src)
							return
						user << browse("[tomedat]", "window=Arcane Tome")
						return
			if(usr.get_active_hand() != src)
				return

			var/list/dictionary = list (
				"превращение" = list("присоединение","кровь","я"),
				"стена" = list("разрушение","путешествие","я"),
				"вскипание крови" = list("разрушение","видимость","кровь"),
				"слить кровь" = list("путешествие","кровь","я"),
				"воскрешение мертвых" = list("кровь","присоединение","ад"),
				"призвать нарси" = list("ад","присоединение","я"),
				"связаться" = list("я","другое","технологии"),
				"эми" = list("разрушение","видимость","технологии"),
				"манифест" = list("кровь","видимость","путешествие"),
				"призвать фолиант" = list("видимость","кровь","ад"),
				"видеть невидимое" = list("видимость","ад","присоединение"),
				"скрыть" = list("скрытность","видимость","кровь"),
				"раскрыть" = list("кровь","видимость","скрытность"),
				"астральное путешествие" = list("ад","путешествие","я"),
				"насыщение" = list("ад","технологии","присоединение"),
				"жертва" = list("ад","кровь","присоединение"),
				"призвать культиста" = list("присоединение","другое","я"),
				"освободить культиста" = list("путешествие","технологии","другое"),
				"оглушение" = list("скрытность","другое","видимость"),
				"ослепление" = list("разрушение","видимость","другое"),
				"стан" = list("присоединение","скрытность","технологии"),
				"броня" = list("ад","разрушение","другое"),
				"телепорт" = list("путешествие","я"),
				"телепорт другое" = list("путешествие","другое")
			)

			var/list/english = list()

			var/list/scribewords = list("none")

			for (var/entry in words)
				if (words[entry] != entry)
					english += list(words[entry] = entry)

			for (var/entry in dictionary)
				var/list/required = dictionary[entry]
				if (length(english&required) == required.len)
					scribewords += entry

			var/chosen_rune = null

			if(usr)
				chosen_rune = input ("Выберите руну, которую хотите написать.") in scribewords
				if (!chosen_rune)
					return
				if (chosen_rune == "none")
					to_chat(user, "<span class='notice'>Вы решаете не писать руну, возможно, вам стоит на этот раз изучить свои записи.</span>")
					return
				if (chosen_rune == "телепорт")
					dictionary[chosen_rune] += input ("Выберите слово назначения") in english
				if (chosen_rune == "телепорт другое")
					dictionary[chosen_rune] += input ("Выберите слово назначения") in english

			if(usr.get_active_hand() != src)
				return

			for (var/mob/V in viewers(src))
				V.show_message("<span class='danger'>[user] разрезает палец и начинает петь и рисовать символы на полу.</span>", 3, "<span class='danger'>Вы слышите пение.</span>", 2)
			to_chat(user, "<span class='danger'>Вы разрезаете один из пальцев и начинаете рисовать руну на полу, одновременно повторяя ритуал, связывающий вашу жизненную сущность с темными тайными энергиями, текущими через окружающий мир.</span>")
			user.take_overall_damage((rand(9)+1)/10) // 0.1 to 1.0 damage
			if(do_after(user, 50))
				var/area/A = get_area(user)
				log_and_message_admins("created \an [chosen_rune] rune at \the [A.name] - [user.loc.x]-[user.loc.y]-[user.loc.z].")
				if(usr.get_active_hand() != src)
					return
				var/mob/living/carbon/human/H = user
				var/obj/effect/rune/R = new /obj/effect/rune(user.loc)
				to_chat(user, "<span class='notice'>Вы закончили рисовать загадочные отметки Геометра.</span>")
				var/list/required = dictionary[chosen_rune]
				R.word1 = english[required[1]]
				R.word2 = english[required[2]]
				R.word3 = english[required[3]]
				R.check_icon()
				R.blood_DNA = list()
				R.blood_DNA[H.dna.unique_enzymes] = H.dna.b_type
			return
		else
			to_chat(user, "Книга кажется заполненной неразборчивыми каракулями. Это шутка?")
			return

	examine(mob/user)
		. = ..()
		if(!iscultist(user))
			. += "Старый пыльный фолиант с потрепанными краями и зловещей обложкой."
		else
			. += "Священные Писания Нар-Си, Тот, Кто Видит, Геометр Крови. Содержит подробности каждого ритуала, о котором могли подумать его последователи. Однако большинство из них бесполезны."

/obj/item/weapon/book/tome/cultify()
	return

/obj/item/weapon/book/tome/imbued //admin tome, spawns working runes without waiting
	w_class = ITEMSIZE_SMALL
	var/cultistsonly = 1
	attack_self(mob/user as mob)
		if(src.cultistsonly && !iscultist(usr))
			return
		if(!cultwords["путешествие"])
			runerandom()
		if(user)
			var/r
			if (!istype(user.loc,/turf))
				to_chat(user, "<span class='notice'>У вас недостаточно места, чтобы написать правильную руну.</span>")
			var/list/runes = list("телепорт", "предметпорт", "фолиант", "броня", "превращение", "слеза наяву", "эми", "слить", "провидец", "возвышение", "скрыть", "раскрыть", "астральное путешествие", "манифест", "наполнить талисман", "жертва", "стена", "свобода", "призывкультиста", "оглушение", "ослепление", "вскипание", "связаться", "стан")
			r = input("Выберите руну для начертания", "Rune Scribing") in runes //not cancellable.
			var/obj/effect/rune/R = new /obj/effect/rune
			if(istype(user, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = user
				R.blood_DNA = list()
				R.blood_DNA[H.dna.unique_enzymes] = H.dna.b_type
			var/area/A = get_area(user)
			log_and_message_admins("created \an [r] rune at \the [A.name] - [user.loc.x]-[user.loc.y]-[user.loc.z].")
			switch(r)
				if("телепорт")
					var/list/words = list("гнев", "эго", "нахлизет", "определенность", "правда", "джатка", "мгар", "балак", "каразет", "гиери")
					var/beacon
					if(usr)
						beacon = input("Выберите последнюю руну", "Rune Scribing") in words
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["я"]
					R.word3=beacon
					R.loc = user.loc
					R.check_icon()
				if("предметпорт")
					var/list/words = list("гнев", "эго", "нахлизет", "определенность", "правда", "джатка", "мгар", "балак", "каразет", "гиери")
					var/beacon
					if(usr)
						beacon = input("Выберите последнюю руну", "Rune Scribing") in words
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["другое"]
					R.word3=beacon
					R.loc = user.loc
					R.check_icon()
				if("фолиант")
					R.word1=cultwords["видимость"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["ад"]
					R.loc = user.loc
					R.check_icon()
				if("броня")
					R.word1=cultwords["ад"]
					R.word2=cultwords["разрушение"]
					R.word3=cultwords["другое"]
					R.loc = user.loc
					R.check_icon()
				if("превращение")
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("слеза наяву")
					R.word1=cultwords["ад"]
					R.word2=cultwords["присоединение"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("эми")
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["технологии"]
					R.loc = user.loc
					R.check_icon()
				if("слить")
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("провидец")
					R.word1=cultwords["видимость"]
					R.word2=cultwords["ад"]
					R.word3=cultwords["присоединение"]
					R.loc = user.loc
					R.check_icon()
				if("возвышение")
					R.word1=cultwords["кровь"]
					R.word2=cultwords["присоединение"]
					R.word3=cultwords["ад"]
					R.loc = user.loc
					R.check_icon()
				if("скрыть")
					R.word1=cultwords["скрытность"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["кровь"]
					R.loc = user.loc
					R.check_icon()
				if("астральное путешествие")
					R.word1=cultwords["ад"]
					R.word2=cultwords["присоединение"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("манифесть")
					R.word1=cultwords["кровь"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["путешествие"]
					R.loc = user.loc
					R.check_icon()
				if("наполнить талисман")
					R.word1=cultwords["ад"]
					R.word2=cultwords["технологии"]
					R.word3=cultwords["присоединение"]
					R.loc = user.loc
					R.check_icon()
				if("жертва")
					R.word1=cultwords["ад"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["присоединение"]
					R.loc = user.loc
					R.check_icon()
				if("раскрыть")
					R.word1=cultwords["кровь"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["скрыть"]
					R.loc = user.loc
					R.check_icon()
				if("стена")
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["путешествие"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("свобода")
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["технологии"]
					R.word3=cultwords["другое"]
					R.loc = user.loc
					R.check_icon()
				if("призывкультиста")
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["я"]
					R.loc = user.loc
					R.check_icon()
				if("оглушение")
					R.word1=cultwords["скрытность"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["видимость"]
					R.loc = user.loc
					R.check_icon()
				if("ослепление")
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["другое"]
					R.loc = user.loc
					R.check_icon()
				if("вскипание")
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["кровь"]
					R.loc = user.loc
					R.check_icon()
				if("связаться")
					R.word1=cultwords["я"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["технологии"]
					R.loc = user.loc
					R.check_icon()
				if("стан")
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["скрытность"]
					R.word3=cultwords["технологии"]
					R.loc = user.loc
					R.check_icon()
