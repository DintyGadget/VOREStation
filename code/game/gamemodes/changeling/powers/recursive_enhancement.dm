/datum/power/changeling/recursive_enhancement
	name = "Recursive Enhancement"
	desc = "Мы заставляем наши способности иметь усиленные или дополнительные эффекты."
	helptext = "Чтобы проверить эффекты каждой способности, проверьте синий текст под способностью в меню развития."
	ability_icon_state = "ling_recursive_enhancement"
	genomecost = 3
	verbpath = /mob/proc/changeling_recursive_enhancement

//Increases macimum chemical storage
/mob/proc/changeling_recursive_enhancement()
	set category = "Changeling"
	set name = "Рекурсивное улучшение"
	set desc = "Расширяет наши возможности."
	var/datum/changeling/changeling = changeling_power(0,0,100,UNCONSCIOUS)
	if(!changeling)
		return 0
	if(src.mind.changeling.recursive_enhancement)
		to_chat(src, "<span class='warning'>Мы больше не будем расширять наши возможности.</span>")
		src.mind.changeling.recursive_enhancement = 0
		return 0
	to_chat(src, "<span class='notice'>Мы расширяем возможности. Наши способности теперь будут очень мощными.</span>")
	src.mind.changeling.recursive_enhancement = 1
	feedback_add_details("changeling_powers","RE")
	return 1