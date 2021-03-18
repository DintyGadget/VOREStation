var/list/_client_preferences
var/list/_client_preferences_by_key
var/list/_client_preferences_by_type

/proc/get_client_preferences()
	if(!_client_preferences)
		_client_preferences = list()
		for(var/ct in subtypesof(/datum/client_preference))
			var/datum/client_preference/client_type = ct
			if(initial(client_type.description))
				_client_preferences += new client_type()
	return _client_preferences

/proc/get_client_preference(var/datum/client_preference/preference)
	if(istype(preference))
		return preference
	if(ispath(preference))
		return get_client_preference_by_type(preference)
	return get_client_preference_by_key(preference)

/proc/get_client_preference_by_key(var/preference)
	if(!_client_preferences_by_key)
		_client_preferences_by_key = list()
		for(var/ct in get_client_preferences())
			var/datum/client_preference/client_pref = ct
			_client_preferences_by_key[client_pref.key] = client_pref
	return _client_preferences_by_key[preference]

/proc/get_client_preference_by_type(var/preference)
	if(!_client_preferences_by_type)
		_client_preferences_by_type = list()
		for(var/ct in get_client_preferences())
			var/datum/client_preference/client_pref = ct
			_client_preferences_by_type[client_pref.type] = client_pref
	return _client_preferences_by_type[preference]

/datum/client_preference
	var/description
	var/key
	var/enabled_by_default = TRUE
	var/enabled_description = "Да"
	var/disabled_description = "Нет"

/datum/client_preference/proc/may_toggle(var/mob/preference_mob)
	return TRUE

/datum/client_preference/proc/toggled(var/mob/preference_mob, var/enabled)
	return

/*********************
* Player Preferences *
*********************/

/datum/client_preference/play_admin_midis
	description ="Слышать MIDI администраторов"
	key = "SOUND_MIDI"

/datum/client_preference/play_lobby_music
	description ="Слышать музыку в лобби"
	key = "SOUND_LOBBY"

/datum/client_preference/play_lobby_music/toggled(var/mob/preference_mob, var/enabled)
	if(!preference_mob.client || !preference_mob.client.media)
		return

	if(enabled)
		preference_mob.client.playtitlemusic()
	else
		preference_mob.client.media.stop_music()

/datum/client_preference/play_ambiance
	description ="Слышать звуки окружения"
	key = "SOUND_AMBIENCE"

/datum/client_preference/play_ambiance/toggled(var/mob/preference_mob, var/enabled)
	if(!enabled)
		preference_mob << sound(null, repeat = 0, wait = 0, volume = 0, channel = 1)
		preference_mob << sound(null, repeat = 0, wait = 0, volume = 0, channel = 2)
//VOREStation Add - Need to put it here because it should be ordered riiiight here.
/datum/client_preference/play_jukebox
	description ="Слышать музыку из проигрывателя"
	key = "SOUND_JUKEBOX"

/datum/client_preference/play_jukebox/toggled(var/mob/preference_mob, var/enabled)
	if(!enabled)
		preference_mob.stop_all_music()
	else
		preference_mob.update_music()

/datum/client_preference/eating_noises
	description = "Звуки поедания"
	key = "EATING_NOISES"
	enabled_description = "Слышны"
	disabled_description = "Отключены"

/datum/client_preference/digestion_noises
	description = "Звуки переваривания"
	key = "DIGEST_NOISES"
	enabled_description = "Слышны"
	disabled_description = "Отключены"

/datum/client_preference/emote_noises
	description = "Звуки эмоций" //MERP
	key = "EMOTE_NOISES"
	enabled_description = "Слышны"
	disabled_description = "Отключены"
/datum/client_preference/whisubtle_vis
	description = "Видно ли Шепот/Скрытные действ. гостам"
	key = "WHISUBTLE_VIS"
	enabled_description = "Видны"
	disabled_description = "Скрыты"
	enabled_by_default = FALSE
//VOREStation Add End
/datum/client_preference/weather_sounds
	description ="Звуки погоды"
	key = "SOUND_WEATHER"
	enabled_description = "Слышны"
	disabled_description = "Отключены"

/datum/client_preference/supermatter_hum
	description ="Гул Суперматерии"
	key = "SOUND_SUPERMATTER"
	enabled_description = "Слышен"
	disabled_description = "Отключен"

/datum/client_preference/ghost_ears
	description ="Слух призрака"
	key = "CHAT_GHOSTEARS"
	enabled_description = "Все разговоры"
	disabled_description = "Поблизости"

/datum/client_preference/ghost_sight
	description ="Зрение призрака"
	key = "CHAT_GHOSTSIGHT"
	enabled_description = "Все эмоции"
	disabled_description = "Поблизости"

/datum/client_preference/ghost_radio
	description ="Призрачное радио"
	key = "CHAT_GHOSTRADIO"
	enabled_description = "Все разговоры"
	disabled_description = "Поблизости"

/datum/client_preference/chat_tags
	description ="Тэги в чате"
	key = "CHAT_SHOWICONS"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/air_pump_noise
	description ="Звуки насосов"
	key = "SOUND_AIRPUMP"
	enabled_description = "Слышны"
	disabled_description = "Отключены"

/datum/client_preference/old_door_sounds
	description ="Старые звуки дверей"
	key = "SOUND_OLDDOORS"
	enabled_description = "Старые"
	disabled_description = "Новые"

/datum/client_preference/department_door_sounds
	description ="Звуки дверей отделов"
	key = "SOUND_DEPARTMENTDOORS"
	enabled_description = "Разные"
	disabled_description = "Одинаковые"

/datum/client_preference/pickup_sounds
	description = "Звуки подбирания предметов"
	key = "SOUND_PICKED"
	enabled_description = "Вкл"
	disabled_description = "Выкл"

/datum/client_preference/drop_sounds
	description = "Звуки падения предмета"
	key = "SOUND_DROPPED"
	enabled_description = "Вкл"
	disabled_description = "Выкл"

/datum/client_preference/mob_tooltips
	description ="Подсказки для существ"
	key = "MOB_TOOLTIPS"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/inv_tooltips
	description ="Подсказки для инвентаря"
	key = "INV_TOOLTIPS"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/attack_icons
	description ="Иконки атак"
	key = "ATTACK_ICONS"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/precision_placement
	description ="Расположение предметов"
	key = "PRECISE_PLACEMENT"
	enabled_description = "Точное"
	disabled_description = "Неточное"

/datum/client_preference/hotkeys_default
	description ="Хоткеи по умолчанию"
	key = "HUD_HOTKEYS"
	enabled_description = "Включены"
	disabled_description = "Выключены"
	enabled_by_default = FALSE // Backwards compatibility

/datum/client_preference/show_typing_indicator
	description ="Индикатор набора текста"
	key = "SHOW_TYPING"
	enabled_description = "Показывать"
	disabled_description = "Скрыть"

/datum/client_preference/show_typing_indicator/toggled(var/mob/preference_mob, var/enabled)
	if(!enabled)
		preference_mob.set_typing_indicator(FALSE)

/datum/client_preference/show_ooc
	description ="Чат ООС"
	key = "CHAT_OOC"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/show_looc
	description ="Чат LOOC"
	key = "CHAT_LOOC"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/show_dsay
	description ="Чат призраков"
	key = "CHAT_DEAD"
	enabled_description = "Показать"
	disabled_description = "Скрыть"

/datum/client_preference/check_mention
	description ="Упоминание имени в чате"
	key = "CHAT_MENTION"
	enabled_description = "Выделять"
	disabled_description = "Не выделять"

/datum/client_preference/show_progress_bar
	description ="Полоса прогресса"
	key = "SHOW_PROGRESS"
	enabled_description = "Показывать"
	disabled_description = "Скрыть"

/datum/client_preference/safefiring
	description = "Режим стрельбы по намерению"
	key = "SAFE_FIRING"
	enabled_description = "Безопасный"
	disabled_description = "Опасный"

/datum/client_preference/browser_style
	description = "Стиль браузеров NanoUI"
	key = "BROWSER_STYLED"
	enabled_description = "Красивый"
	disabled_description = "Обычный"

/datum/client_preference/ambient_occlusion
	description = "Объемное затенение"
	key = "AMBIENT_OCCLUSION_PREF"
	enabled_by_default = FALSE
	enabled_description = "Включено"
	disabled_description = "Выключено"

/datum/client_preference/ambient_occlusion/toggled(var/mob/preference_mob, var/enabled)
	. = ..()
	if(preference_mob && preference_mob.plane_holder)
		var/datum/plane_holder/PH = preference_mob.plane_holder
		PH.set_ao(VIS_OBJS, enabled)
		PH.set_ao(VIS_MOBS, enabled)

/datum/client_preference/instrument_toggle
	description ="Слышать муз. инструменты"
	key = "SOUND_INSTRUMENT"

/datum/client_preference/vchat_enable
	description = "VChat"
	key = "VCHAT_ENABLE"
	enabled_description =  "Включен"
	disabled_description = "Выключен"

/datum/client_preference/status_indicators
	description = "Иконки статуса"
	key = "SHOW_STATUS"
	enabled_description = "Показывать"
	disabled_description = "Скрыть"

/datum/client_preference/status_indicators/toggled(mob/preference_mob, enabled)
	. = ..()
	if(preference_mob && preference_mob.plane_holder)
		var/datum/plane_holder/PH = preference_mob.plane_holder
		PH.set_vis(VIS_STATUS, enabled)

/********************
* Staff Preferences *
********************/
/datum/client_preference/admin/may_toggle(var/mob/preference_mob)
	return check_rights(R_ADMIN|R_EVENT, 0, preference_mob)

/datum/client_preference/mod/may_toggle(var/mob/preference_mob)
	return check_rights(R_MOD|R_ADMIN, 0, preference_mob)

/datum/client_preference/debug/may_toggle(var/mob/preference_mob)
	return check_rights(R_DEBUG|R_ADMIN, 0, preference_mob)

/datum/client_preference/mod/show_attack_logs
	description = "Сообщения лога атак"
	key = "CHAT_ATTACKLOGS"
	enabled_description = "Показывать"
	disabled_description = "Скрыть"
	enabled_by_default = FALSE

/datum/client_preference/debug/show_debug_logs
	description = "Сообщения лога дебаггинга"
	key = "CHAT_DEBUGLOGS"
	enabled_description = "Показывать"
	disabled_description = "Скрывать"
	enabled_by_default = FALSE

/datum/client_preference/admin/show_chat_prayers
	description = "Молитвы в чате"
	key = "CHAT_PRAYER"
	enabled_description = "Показывать"
	disabled_description = "Скрывать"

/datum/client_preference/holder/may_toggle(var/mob/preference_mob)
	return preference_mob && preference_mob.client && preference_mob.client.holder

/datum/client_preference/holder/play_adminhelp_ping
	description = "Админхелпы"
	key = "SOUND_ADMINHELP"
	enabled_description = "Слышны"
	disabled_description = "Бесшумны"

/datum/client_preference/holder/hear_radio
	description = "Болтовня по радио"
	key = "CHAT_RADIO"
	enabled_description = "Показывать"
	disabled_description = "Скрывать"

/datum/client_preference/holder/show_rlooc
	description ="Дистанционный LOOC"
	key = "CHAT_RLOOC"
	enabled_description = "Показывать"
	disabled_description = "Скрывать"
