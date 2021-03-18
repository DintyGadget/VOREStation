/client/verb/ignore(key_to_ignore as text)
	set name = "Заблокировать Игрока"
	set category = "OOC"
	set desc = "Скрывает для Вас сообщения OOC и чата мертвецов от определённого игрока."

	if(!key_to_ignore)
		return
	key_to_ignore = ckey(sanitize(key_to_ignore))
	if(prefs && prefs.ignored_players)
		if(key_to_ignore in prefs.ignored_players)
			to_chat(usr, "<span class='warning'>[key_to_ignore] уже игнорируется.</span>")
			return
		if(key_to_ignore == usr.ckey)
			to_chat(usr, "<span class='notice'>Вы не можете игнорировать себя.</span>")
			return

		prefs.ignored_players |= key_to_ignore
		SScharacter_setup.queue_preferences_save(prefs)
		to_chat(usr, "<span class='notice'>Теперь <b>[key_to_ignore]</b> игнорируется.</span>")

/client/verb/unignore(key_to_unignore as text)
	set name = "Разблокировать Игрока"
	set category = "OOC"
	set desc = "Отменяет игнорирование игрока."

	if(!key_to_unignore)
		return
	key_to_unignore = ckey(sanitize(key_to_unignore))
	if(prefs && prefs.ignored_players)
		if(!(key_to_unignore in prefs.ignored_players))
			to_chat(usr, "<span class='warning'>[key_to_unignore] не игнорируется.</span>")
			return
		prefs.ignored_players -= key_to_unignore
		SScharacter_setup.queue_preferences_save(prefs)
		to_chat(usr, "<span class='notice'>Теперь <b>[key_to_unignore] не игнорируется</b>.</span>")

/mob/proc/is_key_ignored(var/key_to_check)
	if(client)
		return client.is_key_ignored(key_to_check)
	return 0

/client/proc/is_key_ignored(var/key_to_check)
	key_to_check = ckey(key_to_check)
	if(key_to_check in prefs.ignored_players)
		if(GLOB.directory[key_to_check] in GLOB.admins) // This is here so this is only evaluated if someone is actually being blocked.
			return 0
		return 1
	return 0