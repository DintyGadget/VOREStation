/spell/rune_write
	name = "Начертить руну"
	desc = "Let's you instantly manifest a working rune."

	school = "evocation"
	charge_max = 100
	charge_type = Sp_RECHARGE
	invocation_type = SpI_NONE

	spell_flags = CONSTRUCT_CHECK

	hud_state = "const_rune"

	smoke_amt = 1

/spell/rune_write/choose_targets(mob/user = usr)
	return list(user)

/spell/rune_write/cast(null, mob/user = usr)
	if(!cultwords["путешествие"])
		runerandom()
	var/list/runes = list("Телепорт", "Телепорт другое", "Спавн фолианта", "Изменить тип конструкции", "Превращение", "ЭМИ", "Слить кровь", "Видеть невидимое", "Воскрешение", "Скрыть руны", "Раскрыть руны", "Астральное путешествие", "Manifest a Ghost", "Наполнить талисман", "Жертва", "Стена", "Освободить", "Призвать культиста", "Оглушение", "Ослепление", "Вскипание крови", "Связь", "Стан")
	var/r = input(user, "Выберите руну для начертания", "Rune Scribing") in runes //not cancellable.
	var/obj/effect/rune/R = new /obj/effect/rune(user.loc)
	if(istype(user.loc,/turf))
		var/area/A = get_area(user)
		log_and_message_admins("created \an [r] rune at \the [A.name] - [user.loc.x]-[user.loc.y]-[user.loc.z].", user)
		switch(r)
			if("Телепорт")
				if(cast_check(1))
					var/beacon
					if(user)
						beacon = input(user, "Выберите последнюю руну", "Rune Scribing") in rnwords
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["я"]
					R.word3=beacon
					R.check_icon()
			if("Телепорт другое")
				if(cast_check(1))
					var/beacon
					if(user)
						beacon = input(user, "Выберите последнюю руну", "Rune Scribing") in rnwords
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["другое"]
					R.word3=beacon
					R.check_icon()
			if("Спавн фолианта")
				if(cast_check(1))
					R.word1=cultwords["видимость"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["ад"]
					R.check_icon()
			if("Изменить тип конструкции")
				if(cast_check(1))
					R.word1=cultwords["ад"]
					R.word2=cultwords["разрушение"]
					R.word3=cultwords["другое"]
					R.check_icon()
			if("Превращение")
				if(cast_check(1))
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["я"]
					R.check_icon()
			if("ЭМИ")
				if(cast_check(1))
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["технологии"]
					R.check_icon()
			if("Слить кровь")
				if(cast_check(1))
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["я"]
					R.check_icon()
			if("Видеть невидимое")
				if(cast_check(1))
					R.word1=cultwords["видимость"]
					R.word2=cultwords["ад"]
					R.word3=cultwords["присоединение"]
					R.check_icon()
			if("Воскрешение")
				if(cast_check(1))
					R.word1=cultwords["кровь"]
					R.word2=cultwords["присоединение"]
					R.word3=cultwords["ад"]
					R.check_icon()
			if("Скрыть руны")
				if(cast_check(1))
					R.word1=cultwords["скрытность"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["кровь"]
					R.check_icon()
			if("Астральное путешествие")
				if(cast_check(1))
					R.word1=cultwords["ад"]
					R.word2=cultwords["путешествие"]
					R.word3=cultwords["я"]
					R.check_icon()
			if("Manifest a Ghost")
				if(cast_check(1))
					R.word1=cultwords["кровь"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["путешествие"]
					R.check_icon()
			if("Наполнить талисман")
				if(cast_check(1))
					R.word1=cultwords["ад"]
					R.word2=cultwords["технологии"]
					R.word3=cultwords["присоединение"]
					R.check_icon()
			if("Жертва")
				if(cast_check(1))
					R.word1=cultwords["ад"]
					R.word2=cultwords["кровь"]
					R.word3=cultwords["присоединение"]
					R.check_icon()
			if("Раскрыть руны")
				if(cast_check(1))
					R.word1=cultwords["кровь"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["скрытность"]
					R.check_icon()
			if("Стена")
				if(cast_check(1))
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["путешествие"]
					R.word3=cultwords["я"]
					R.check_icon()
			if("Освободить")
				if(cast_check(1))
					R.word1=cultwords["путешествие"]
					R.word2=cultwords["технологии"]
					R.word3=cultwords["другое"]
					R.check_icon()
			if("Призвать культиста")
				if(cast_check(1))
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["я"]
					R.check_icon()
			if("Оглушение")
				if(cast_check(1))
					R.word1=cultwords["скрытность"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["видимость"]
					R.check_icon()
			if("Ослепление")
				if(cast_check(1))
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["другое"]
					R.check_icon()
			if("Вскипание крови")
				if(cast_check(1))
					R.word1=cultwords["разрушение"]
					R.word2=cultwords["видимость"]
					R.word3=cultwords["кроаь"]
					R.check_icon()
			if("Связь")
				if(cast_check(1))
					R.word1=cultwords["я"]
					R.word2=cultwords["другое"]
					R.word3=cultwords["технологии"]
					R.check_icon()
			if("Стан")
				if(cast_check(1))
					R.word1=cultwords["присоединение"]
					R.word2=cultwords["скрытность"]
					R.word3=cultwords["технологии"]
					R.check_icon()
	else
		to_chat(user, "<span class='warning'> У вас недостаточно места, чтобы написать правильную руну.</span>")
	return
