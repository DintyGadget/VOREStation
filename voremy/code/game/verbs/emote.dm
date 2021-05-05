/mob/living/var/emoteCooldown = (5 SECONDS)
/mob/living/var/emoteLastUse = -1000

var/list/sounded_species = null

/mob/living/proc/emoteCooldownCheck()
	if(emoteLastUse <= (world.time - emoteCooldown))
		emoteLastUse = world.time
		return 1
	else
		to_chat(src, "<span class='warning'>Между эмоциями должно пройти не менее [emoteCooldown/10] секунд.</span>")
		return 0

/mob/living/verb/emote1()
	set name = "Нья~"
	set category = "Эмоции"
	sounded_species = null
	emote("nya")

/mob/living/verb/emote2()
	set name = "Кричать"
	set category = "Эмоции"
	sounded_species = null
	emote("scream")

/mob/living/verb/emote3()
	set name = "Щелкнуть пальцами"
	set category = "Эмоции"
	sounded_species = null
	emote("snap")

/mob/living/verb/emote4()
	set name = "Блевануть"
	set category = "Эмоции"
	sounded_species = null
	emote("vomit")

/mob/living/verb/emote5()
	set name = "Пожать руку"
	set category = "Эмоции"
	sounded_species = null
	emote("handshake")

/mob/living/verb/emote6()
	set name = "Обнять"
	set category = "Эмоции"
	sounded_species = null
	emote("hug")

/mob/living/verb/emote7()
	set name = "Рычать"
	set category = "Эмоции"
	emote("growl")

/mob/living/verb/emote8()
	set name = "Мяукать"
	set category = "Эмоции"
	emote("mrowl")

/mob/living/verb/emote9()
	set name = "Пищать (птич)"
	set category = "Эмоции"
	emote("peep")

/mob/living/verb/emote10()
	set name = "Чирикать"
	set category = "Эмоции"
	emote("chirp")

/mob/living/verb/emote11()
	set name = "Лай"
	set category = "Эмоции"
	emote("bark")

/mob/living/verb/emote12()
	set name = "Тявкать"
	set category = "Эмоции"
	emote("bork")

/mob/living/verb/emote13()
	set name = "Мяукать 2"
	set category = "Эмоции"
	emote("mrow")

/mob/living/verb/emote14()
	set name = "Загадочный звук"
	set category = "Эмоции"
	emote("hypno")

mob/living/verb/emote15()
	set name = "Шипеть"
	set category = "Эмоции"
	sounded_species = list(SPECIES_UNATHI)
	emote("hiss")

/mob/living/verb/emote16()
	set name = "Смеяться"
	set category = "Эмоции"
	emote("laugh")

/mob/living/verb/emote17()
	set name = "Хихикать"
	set category = "Эмоции"
	emote("giggle")

/mob/living/verb/emote18()
	set name = "Плакать"
	set category = "Эмоции"
	emote("cry")

/mob/living/verb/emote19()
	set name = "Стонать"
	set category = "Эмоции"
	emote("moan")

/mob/living/verb/emote20()
	set name = "Храпеть"
	set category = "Эмоции"
	emote("snore")

/mob/living/verb/emote21()
	set name = "Вздохнуть"
	set category = "Эмоции"
	emote("sigh")

/mob/living/verb/emote22()
	set name = "Зевнуть"
	set category = "Эмоции"
	emote("yawn")

/mob/living/verb/emote23()
	set name = "Улыбнуться"
	set category = "Эмоции"
	emote("smile")

/mob/living/verb/emote24()
	set name = "Трясти головой"
	set category = "Эмоции"
	emote("shake")

/mob/living/verb/emote25()
	set name = "Хрустеть пальцами"
	set category = "Эмоции"
	emote("crack")

/mob/living/verb/emote26()
	set name = "Бормотать"
	set category = "Эмоции"
	emote("mumble")

/mob/living/verb/emote27()
	set name = "Ворчать"
	set category = "Эмоции"
	emote("grumble")

/mob/living/verb/emote28()
	set name = "Кашлять"
	set category = "Эмоции"
	emote("cough")

/mob/living/verb/emote29()
	set name = "Отдать честь"
	set category = "Эмоции"
	emote("salute")