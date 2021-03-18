var/datum/antagonist/stowaway/stowaways

/datum/antagonist/STOWAWAY
	id = MODE_STOWAWAY
	role_type = BE_RENEGADE
	role_text = "Stowaway"
	role_text_plural = "Stowaways"
	bantype = "renegade"
	avoid_silicons = TRUE // This was previously allowing cyborgs to be stowaways, but given that they would just connect to the AI, it didn't make much sense
	welcome_text = "Люди, как известно, бегут от многих вещей или ко многим вещам по многим различным причинам. Так уж случилось, что вы один из этих людей."
	antag_text = "Вы <b>второстепенный</b> антагонист! В рамках правил сервера делайте то, для чего вы пришли на станцию. \
		Шпионаж, воровство или просто бегство от закона - все это примеры. \
		Постарайтесь, чтобы другие игроки тоже <i>развлекались от вашей игры</i>! Если вы запутались или растерялись, всегда обращайтесь за помощью к администратору, \
		а прежде чем предпринимать крайние меры, попробуйте также связаться с администрацией! \
		Продумайте свои действия и сделайте ролевую игру захватывающей! <b>Пожалуйста, помните, что все правила, \
		кроме некоторых, без явных исключений, применяются к антагонистам.</b>"
	flags = ANTAG_SUSPICIOUS | ANTAG_IMPLANT_IMMUNE | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	can_speak_aooc = FALSE
