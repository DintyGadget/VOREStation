/obj/item/weapon/paper/talisman
	icon_state = "paper_talisman"
	var/imbue = null
	var/uses = 0
	info = "<center><img src='talisman.png'></center><br/><br/>"

	attack_self(mob/living/user as mob)
		if(iscultist(user))
			var/delete = 1
			// who the hell thought this was a good idea :(
			switch(imbue)
				if("новыйфолиант")
					call(/obj/effect/rune/proc/tomesummon)()
				if("броня")
					call(/obj/effect/rune/proc/armor)()
				if("эми")
					call(/obj/effect/rune/proc/emp)(usr.loc,3)
				if("скрыть")
					call(/obj/effect/rune/proc/obscure)(2)
				if("раскрытьруны")
					call(/obj/effect/rune/proc/revealrunes)(src)
				if("гнев","эго","нахлизет","определенность","правда","джатка","мгар","балак", "каразет", "гиери")
					call(/obj/effect/rune/proc/teleport)(imbue)
				if("связаться")
					//If the user cancels the talisman this var will be set to 0
					delete = call(/obj/effect/rune/proc/communicate)()
				if("оглушение")
					call(/obj/effect/rune/proc/deafen)()
				if("ослепление")
					call(/obj/effect/rune/proc/blind)()
				if("станруна")
					to_chat(user, "<span class='warning'>Чтобы использовать этот талисман, атакуйте свою цель напрямую.</span>")
					return
				if("снабжать")
					supply()
			user.take_organ_damage(5, 0)
			if(src && src.imbue!="снабжать" && src.imbue!="станруна")
				if(delete)
					qdel(src)
			return
		else
			to_chat(user, "Вы видите на бумаге странные символы. Они должны что-то значить?")
			return


	attack(mob/living/carbon/T as mob, mob/living/user as mob)
		if(iscultist(user))
			if(imbue == "станруна")
				user.take_organ_damage(5, 0)
				call(/obj/effect/rune/proc/runestun)(T)
				qdel(src)
			else
				..()   ///If its some other talisman, use the generic attack code, is this supposed to work this way?
		else
			..()


	proc/supply(var/key)
		if (!src.uses)
			qdel(src)
			return

		var/dat = "<meta charset=\"utf-8\"><B>На пергаменте [src.uses] кровавые руны.</B><BR>"
		dat += "Пожалуйста, выберите песнопение, которое будет проникнуто в ткань реальности.<BR>"
		dat += "<HR>"
		dat += "<A href='?src=\ref[src];rune=newtome'>N'ath reth sh'yro eth d'raggathnor!</A> - Allows you to summon a new arcane tome.<BR>"
		dat += "<A href='?src=\ref[src];rune=teleport'>Sas'so c'arta forbici!</A> - Allows you to move to a rune with the same last word.<BR>"
		dat += "<A href='?src=\ref[src];rune=emp'>Ta'gh fara'qha fel d'amar det!</A> - Allows you to destroy technology in a short range.<BR>"
		dat += "<A href='?src=\ref[src];rune=conceal'>Kla'atu barada nikt'o!</A> - Allows you to conceal the runes you placed on the floor.<BR>"
		dat += "<A href='?src=\ref[src];rune=communicate'>O bidai nabora se'sma!</A> - Allows you to coordinate with others of your cult.<BR>"
		dat += "<A href='?src=\ref[src];rune=runestun'>Fuu ma'jin</A> - Allows you to stun a person by attacking them with the talisman.<BR>"
		dat += "<A href='?src=\ref[src];rune=armor'>Sa tatha najin</A> - Allows you to summon armoured robes and an unholy blade<BR>"
		dat += "<A href='?src=\ref[src];rune=soulstone'>Kal om neth</A> - Summons a soul stone<BR>"
		dat += "<A href='?src=\ref[src];rune=construct'>Da A'ig Osk</A> - Summons a construct shell for use with captured souls. It is too large to carry on your person.<BR>"
		usr << browse(dat, "window=id_com;size=350x200")
		return


	Topic(href, href_list)
		if(!src)	return
		if (usr.stat || usr.restrained() || !in_range(src, usr))	return

		if (href_list["rune"])
			switch(href_list["rune"])
				if("newtome")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "новыйфолиант"
				if("teleport")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "[pick("гнев", "эго", "нахлизет", "определенность", "правда", "джатка", "балак", "мгар", "каразет", "гиери", "оркан", "аллак")]"
					T.info = "[T.imbue]"
				if("emp")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "эми"
				if("conceal")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "скрыть"
				if("communicate")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "связаться"
				if("runestun")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "станруна"
				if("armor")
					var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
					T.imbue = "броня"
				if("soulstone")
					new /obj/item/device/soulstone(get_turf(usr))
				if("construct")
					new /obj/structure/constructshell/cult(get_turf(usr))
			src.uses--
			supply()
		return


/obj/item/weapon/paper/talisman/supply
	imbue = "снабжать"
	uses = 5
