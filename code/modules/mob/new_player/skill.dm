var/global/const
	SKILL_NONE = 0
	SKILL_BASIC = 1
	SKILL_ADEPT = 2
	SKILL_EXPERT = 3
	SKILL_PROF = 4

/datum/skill/var
	ID = "none" // ID of the skill, used in code
	name = "None" // name of the skill
	desc = "Placeholder skill" // detailed description of the skill
	field = "Другое" // the field under which the skill will be listed
	secondary = 0 // secondary skills only have two levels and cost significantly less

var/global/list/SKILLS = null
var/list/SKILL_ENGINEER = list("field" = "Инженерное дело", "EVA" = SKILL_BASIC, "construction" = SKILL_ADEPT, "electrical" = SKILL_BASIC, "engines" = SKILL_ADEPT)
var/list/SKILL_ORGAN_ROBOTICIST = list("field" = "Наука", "devices" = SKILL_ADEPT, "electrical" = SKILL_BASIC, "computer" = SKILL_ADEPT, "anatomy" = SKILL_BASIC)
var/list/SKILL_SECURITY_OFFICER = list("field" = "Безопасность", "combat" = SKILL_BASIC, "weapons" = SKILL_ADEPT, "law" = SKILL_ADEPT, "forensics" = SKILL_BASIC)
var/list/SKILL_CHEMIST = list("field" = "Наука", "chemistry" = SKILL_ADEPT, "science" = SKILL_ADEPT, "medical" = SKILL_BASIC, "devices" = SKILL_BASIC)
var/global/list/SKILL_PRE = list("Инженер" = SKILL_ENGINEER, "Робототехник" = SKILL_ORGAN_ROBOTICIST, "Офицер безопасности" = SKILL_SECURITY_OFFICER, "Химик" = SKILL_CHEMIST)

/datum/skill/management
	ID = "management"
	name = "Командование"
	desc = "Ваша способность распоряжаться и управлять другими членами экипажа."

/datum/skill/combat
	ID = "combat"
	name = "Ближний бой"
	desc = "Этот навык описывает Вашу подготовку в рукопашном бою и владение оружием ближнего боя. Хотя опыт в этой области редок в эпоху огнестрельного оружия, среди атлетов существуют и эксперты."
	field = "Безопасность"

/datum/skill/weapons
	ID = "weapons"
	name = "Дальний бой"
	desc = "Этот навык описывает Ваше знания оружия и опыт в его использовании. Низкий уровень этого навыка подразумевает знание простого оружия, например, тазеров и вспышек. Высокий уровень в этом навыке подразумевает знание сложного оружия, такого как гранаты, щиты, боеприпасы или бомбы. Низкий уровень этого навыка типичен для офицеров безопасности, высокий уровень этого навыка типичен для специальных агентов и солдат."
	field = "Безопасность"

/datum/skill/EVA
	ID = "EVA"
	name = "Внекорабельная деятельность"
	desc = "Этот навык описывает Ваши навыки работы в открытом космосе, а также знания скафандров."
	field = "Инженерное дело"
	secondary = 1

/datum/skill/forensics
	ID = "forensics"
	name = "Криминалистика"
	desc = "Описывает Ваши навыки в проведении судебных экспертиз и выявлении жизненно важных доказательств. Не распространяется на аналитические способности, и, как таковой, не является единственным показателем Ваших навыков исследования. Обратите внимание, что для выполнения вскрытия также требуется навык хирургии."
	field = "Безопасность"

/datum/skill/construction
	ID = "construction"
	name = "Строительство"
	desc = "Ваша способность конструировать стены, полы, столы и так далее. Обратите внимание, что для создания таких устройств, как APC, требуется навык электроники. Низкий уровень этого навыка характерен для уборщиков, высокий уровень этого навыка характерен для инженеров."
	field = "Инженерное дело"

/datum/skill/management
	ID = "management"
	name = "Коммандование"
	desc = "Ваша способность управлять другими членами экипажа и командовать ими."

/datum/skill/knowledge/law
	ID = "law"
	name = "Корпоративный Закон"
	desc = "Ваше знание Корпоративного Закона и соответствующих процедур, а также других правил, установленных на данной станции. Низкий уровень этого навыка свойственнен офицерам службы безопасности, а высокий — Директорам Колонии."
	field = "Безопасность"
	secondary = 1

/datum/skill/devices
	ID = "devices"
	name = "Сложные устройства"
	desc = "Описывает способность конструировать сложные механизмы, такие как компьютеры, микросхемы, принтеры, роботы и бомбы. Учтите, что если механизм требует электронику или программирование, для него потребуются соответствующие навыки."
	field = "Наука"

/datum/skill/electrical
	ID = "electrical"
	name = "Электротехника"
	desc = "Этот навык описывает Ваше знание об электронике и связанной с ней физике. На низких уровнях этот навык открывает знание о том, как прокладывать проводку и настраивать электрические цепи, а на высоких - о том, как оперировать сложными электронными механизмами, таких как микросхемы или боты."
	field = "Инженерное дело"

/datum/skill/atmos
	ID = "atmos"
	name = "Атмосфера"
	desc = "Описывает Ваше знание о прокладывании труб, дистрибуции воздуха и динамике газов."
	field = "Инженерное дело"

/datum/skill/engines
	ID = "engines"
	name = "Двигатели"
	desc = "Описывает Ваше знание различных типов двигателей, распространенных на космических станциях, таких как двигатель Тесла или двигатель на основе суперматерии."
	field = "Инженерное дело"
	secondary = 1

/datum/skill/computer
	ID = "computer"
	name = "Компьютеры"
	desc = "Описывает Ваше понимание компьютеров, программ и средств связи. Не требуется для использования компьютеров, но помогает. Используется для телекоммуникаций, программирования роботов и ИИ."
	field = "Наука"

/datum/skill/pilot
	ID = "pilot"
	name = "Пилотирование"
	desc = "Описывает Ваши опыт и понимание в орудовании крупными машинами, таких как мехи или прочие крупные экзокостюмы. Используется в пилотировании мех."
	field = "Инженерное дело"

/datum/skill/medical
	ID = "medical"
	name = "Врачевание"
	desc = "Сюда входит понимание человеческого тела и медицины. При низком уровне обученности этот навык открывает простейшее знание об оказании первой помощи и использовании медицинских приборов (например, анализатор здоровья). На высоком уровне, навык открывает точные знания обо всех доступных лекарствах, а также знание о сложных медицинских аппаратах (например, сканер тела или массовый спектрометр)."
	field = "Медицина"

/datum/skill/anatomy
	ID = "anatomy"
	name = "Анатомия"
	desc = "Открывает Вашему персонажу подробное знание человеческого тела. Высокий навык необходим для проведения хирургических операций. Этот навык также позволит лучше обследовать инопланетных существ."
	field = "Медицина"

/datum/skill/virology
	ID = "virology"
	name = "Вирусология"
	desc = "Этот навык описывает понимание микроорганизмов и их воздействия на людей."
	field = "Медицина"

/datum/skill/genetics
	ID = "genetics"
	name = "Генетика"
	desc = "Описывает понимание принципов работы ДНК и структуры ДНК человека."
	field = "Наука"

/datum/skill/chemistry
	ID = "chemistry"
	name = "Химия"
	desc = "Опыт Вашего персонажа в проведении химических реакций, а также знание о получаемых продуктах. Сюда не входит знание о воздействии химикатов на тело, и поэтому фармацевтам также необходимо иметь навык врачевания."
	field = "Наука"

/datum/skill/botany
	ID = "botany"
	name = "Ботаника"
	desc = "Описывает умение Вашего персонажа выращивать и содержать растения."

/datum/skill/cooking
	ID = "cooking"
	name = "Готовка"
	desc = "Умение Вашего персонажа готовить еду и прочие употребляемые продукты. Сюда входит и смешивание алкогольных напитков."

/datum/skill/science
	ID = "science"
	name = "Наука"
	desc = "Знания и опыт Вашего персонажа в работе с методами научного исследования."
	field = "Наука"

/datum/attribute/var
	ID = "none"
	name = "Нет"
	desc = "Это заполнитель"


/proc/setup_skills()
	if(SKILLS == null)
		SKILLS = list()
		for(var/T in (typesof(/datum/skill)-/datum/skill))
			var/datum/skill/S = new T
			if(S.ID != "none")
				if(!SKILLS.Find(S.field))
					SKILLS[S.field] = list()
				var/list/L = SKILLS[S.field]
				L += S


/mob/living/carbon/human/proc/GetSkillClass(points)
	return CalculateSkillClass(points, age)

/proc/show_skill_window(var/mob/user, var/mob/living/carbon/human/M)
	if(!istype(M)) return
	if(SKILLS == null)
		setup_skills()

	if(!M.skills || M.skills.len == 0)
		to_chat(user, "Нет доступных навыков.")
		return

	var/HTML = "<meta charset=\"utf-8\"><body>"
	HTML += "<b>Настройте свои навыки в пределах разумного</b><br>"
	HTML += "Текущий уровень навыков: <b>[M.GetSkillClass(M.used_skillpoints)]</b> ([M.used_skillpoints])<br>"
	HTML += "<table>"
	for(var/V in SKILLS)
		HTML += "<tr><th colspan = 5><b>[V]</b>"
		HTML += "</th></tr>"
		for(var/datum/skill/S in SKILLS[V])
			var/level = M.skills[S.ID]
			HTML += "<tr style='text-align:left;'>"
			HTML += "<th>[S.name]</th>"
			HTML += "<th><font color=[(level == SKILL_NONE) ? "red" : "black"]>\[Неопытный\]</font></th>"
			// secondary skills don't have an amateur level
			if(S.secondary)
				HTML += "<th></th>"
			else
				HTML += "<th><font color=[(level == SKILL_BASIC) ? "red" : "black"]>\[Любитель\]</font></th>"
			HTML += "<th><font color=[(level == SKILL_ADEPT) ? "red" : "black"]>\[Обученный\]</font></th>"
			HTML += "<th><font color=[(level == SKILL_EXPERT) ? "red" : "black"]>\[Профи\]</font></th>"
			HTML += "</tr>"
	HTML += "</table>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=show_skills;size=600x800")
	return

/mob/living/carbon/human/verb/show_skills()
	set category = "IC"
	set name = "Показать Собственные Навыки"

	show_skill_window(src, src)
