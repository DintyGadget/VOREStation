var/global/list/seen_citizenships = list()
var/global/list/seen_systems = list()
var/global/list/seen_factions = list()
var/global/list/seen_antag_factions = list()
var/global/list/seen_religions = list()

//Commenting this out for now until I work the lists it into the event generator/journalist/chaplain.
/proc/UpdateFactionList(mob/living/carbon/human/M)
	/*if(M && M.client && M.client.prefs)
		seen_citizenships |= M.client.prefs.citizenship
		seen_systems      |= M.client.prefs.home_system
		seen_factions     |= M.client.prefs.faction
		seen_religions    |= M.client.prefs.religion*/
	return

// VOREStation Edits Start
var/global/list/citizenship_choices = list(
	"Земля",
	"Марс",
	"Сиф",
	"Бинма",
	"Могес",
	"Мералар",
	"Керр'Балак",
	"Колония Вирго 3Б",
	"Союз НТ Вирго 4",
	"Венера",
	"Тиамат",
	"Ан-Так-Ет"
	)

var/global/list/home_system_choices = list(
	"Дева-Эригон",
	"Сол",
	"Проксима Центавра",
	"Процион",
	"Вир",
	"Никс",
	"Тау Кита",
	"Керр'Валис",
	"Эпсилон Малой Медведицы",
	"Раркаджар"
	)


var/global/list/faction_choices = list(
	"Содружество Сол-Процион",
	"Объединенные Фирды",
  	"Колонии Элизия",
 	"Конфедерация Арес",
	"Вей Мед",
	"Einstein Engines",
	"Вольный Торговый Союз",
	"НаноТрасен",
	"Ward-Takahashi GMB",
	"Gilthari Exports",
	"Grayson Manufactories Ltd.",
	"Aether Atmospherics",
	"Zeng-Hu Pharmaceuticals",
	"Hephaestus Industries",
	"Morpheus Cyberkinetics",
	"Xion Manufacturing Group"
	)
// VOREStation Edits Stop

var/global/list/antag_faction_choices = list()	//Should be populated after brainstorming. Leaving as blank in case brainstorming does not occur.

var/global/list/antag_visiblity_choices = list(
	"Скрытый",
	"Малоизвестный",
	"Известный"
	)

var/global/list/religion_choices = list(
	"Унитарианство",
	"Неоязычество",
	"Ислам",
	"Христианство",
	"Иудаизм",
	"Индуизм",
	"Буддизм",
	"Плероманизм",
	"Спектрализм",
	"Синтоизм",
	"Вера Кишари",
	"Вера Работяг",
	"Нок",
	"Сингулярное Поклонение",
	"Кзилар Калл",
	"Раркаджарский Таджр-кий",
	"Агностицизм",
	"Деизм",
	"Нео-Мороизм",
	"Традиционный Мороизм"
	)