/mob/living/silicon/ai
	var/mob/living/silicon/robot/deployed_shell = null //For shell control

/mob/living/silicon/ai/Initialize()
	if(config.allow_ai_shells)
		verbs += /mob/living/silicon/ai/proc/deploy_to_shell_act
	return ..()

/mob/living/silicon/ai/proc/deploy_to_shell(var/mob/living/silicon/robot/target)
	if(!config.allow_ai_shells)
		to_chat(src, span("warning", "На этом сервере нельзя использовать оболочки AI. Из-за этого у вас не должно быть этого глагола, поэтому подумайте о том, чтобы написать отчет об ошибке."))
		return

	if(incapacitated())
		to_chat(src, span("warning", "Вы недееспособны!"))
		return

	if(lacks_power())
		to_chat(src, span("warning", "У вашего ядра не хватает мощности, беспроводная связь отключена."))
		return

	if(control_disabled)
		to_chat(src, span("warning", "Модуль беспроводной сети отключен."))
		return

	var/list/possible = list()

	for(var/borgie in GLOB.available_ai_shells)
		var/mob/living/silicon/robot/R = borgie
		if(R.shell && !R.deployed && (R.stat != DEAD) && (!R.connected_ai || (R.connected_ai == src) )  && !(using_map.ai_shell_restricted && !(R.z in using_map.ai_shell_allowed_levels)) )	//VOREStation Edit: shell restrictions
			possible += R

	if(!LAZYLEN(possible))
		to_chat(src, span("warning", "Не обнаружено пригодных для использования маяков оболочки ИИ."))

	if(!target || !(target in possible)) //If the AI is looking for a new shell, or its pre-selected shell is no longer valid
		target = input(src, "Какое тело контролировать?") as null|anything in possible

	if(!target || target.stat == DEAD || target.deployed || !(!target.connected_ai || (target.connected_ai == src) ) )
		if(target)
			to_chat(src, span("warning", "Развертывание на [target] больше невозможно."))
		else
			to_chat(src, span("notice", "Развертывание прервано."))
		return

	else if(mind)
		soul_link(/datum/soul_link/shared_body, src, target)
		deployed_shell = target
		target.deploy_init(src)
		mind.transfer_to(target)
		teleop = target // So the AI 'hears' messages near its core.
		target.post_deploy()

/mob/living/silicon/ai/proc/deploy_to_shell_act()
	set category = "AI Commands"
	set name = "Вселиться в оболочку"
	deploy_to_shell() // This is so the AI is not prompted with a list of all mobs when using the 'real' proc.

/mob/living/silicon/ai/proc/disconnect_shell(message = "Ваше удаленное соединение было сброшено!")
	if(deployed_shell) // Forcibly call back AI in event of things such as damage, EMP or power loss.
		message = span("danger", message)
		deployed_shell.undeploy(message)
