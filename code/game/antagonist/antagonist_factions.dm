/mob/living/proc/convert_to_rev(mob/M as mob in oview(src))
	set name = "Convert Bourgeoise"
	set category = "Abilities"
	if(!M.mind)
		return
	convert_to_faction(M.mind, revs)

/mob/living/proc/convert_to_faction(var/datum/mind/player, var/datum/antagonist/faction)

	if(!player || !faction || !player.current)
		return

	if(!faction.faction_verb || !faction.faction_descriptor || !faction.faction_verb)
		return

	if(faction.is_antagonist(player))
		to_chat(src, "<span class='warning'>[player.current] уже служит [faction.faction_descriptor].</span>")
		return

	if(player_is_antag(player))
		to_chat(src, "<span class='warning'>Лояльность [player.current] кажется находится в другой точке итнереса...</span>")
		return

	if(!faction.can_become_antag(player))
		to_chat(src, "<span class='warning'>[player.current] не может стать [faction.faction_role_text]!</span>")
		return

	if(world.time < player.rev_cooldown)
		to_chat(src, "<span class='danger'>Вы должны подождать пять секунд между попытками.</span>")
		return

	to_chat(src, "<span class='danger'>Вы пытаетесь обратить [player.current]...</span>")
	log_admin("[src]([src.ckey]) attempted to convert [player.current].")
	message_admins("<span class='danger'>[src]([src.ckey]) attempted to convert [player.current].</span>")

	player.rev_cooldown = world.time+100
	var/choice = alert(player.current,"Спрашивает [src]: Хотите присоединиться к [faction.faction_descriptor]?","Присоединиться к [faction.faction_descriptor]?","Нет!","Да!")
	if(choice == "Да!" && faction.add_antagonist_mind(player, 0, faction.faction_role_text, faction.faction_welcome))
		to_chat(src, "<span class='notice'>[player.current] присоединяется к [faction.faction_descriptor]!</span>")
		return
	if(choice == "Нет!")
		to_chat(player, "<span class='danger'>Вы отвергаете это предательское дело!</span>")
	to_chat(src, "<span class='danger'>[player.current] не хочет поддерживать [faction.faction_descriptor]!</span>")

/mob/living/proc/convert_to_loyalist(mob/M as mob in oview(src))
	set name = "Convert Recidivist"
	set category = "Abilities"
	if(!M.mind)
		return
	convert_to_faction(M.mind, loyalists)