#define ORGANICS	1
#define SYNTHETICS	2

/datum/trait/positive
	category = 1

/datum/trait/positive/speed_fast
	name = "Спешка"
	desc = "Позволяет двигаться быстрее, чем обычно."
	cost = 4
	var_changes = list("slowdown" = -0.5)

/datum/trait/positive/hardy
	name = "Силач"
	desc = "Позволяет переносить тяжелое оборудование с меньшим замедлением."
	cost = 1
	var_changes = list("item_slowdown_mod" = 0.5)

/datum/trait/positive/hardy_plus
	name = "Атлет"
	desc = "Позволяет переносить тяжелую технику практически без замедления."
	cost = 2
	var_changes = list("item_slowdown_mod" = 0.25)

/datum/trait/positive/endurance_high
	name = "Высокая выносливость"
	desc = "Увеличивает максимальное количество здоровья до 125"
	cost = 4
	var_changes = list("total_health" = 125)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/positive/nonconductive
	name = "Каучуковая кожа"
	desc = "Снижает вашу восприимчивость к поражению электрическим током на 10%."
	cost = 1 //This effects tasers!
	var_changes = list("siemens_coefficient" = 0.9)

/datum/trait/positive/nonconductive_plus
	name = "Отражатель тока"
	desc = "Снижает вашу восприимчивость к поражению электрическим током на 25%."
	cost = 2 //Let us not forget this effects tasers!
	var_changes = list("siemens_coefficient" = 0.75)

/datum/trait/positive/darksight
	name = "Ночное зрение"
	desc = "Позволяет видеть на небольшом расстоянии в темноте."
	cost = 1
	var_changes = list("darksight" = 5, "flash_mod" = 1.1)

/datum/trait/positive/darksight_plus
	name = "Ночное зрение (Улучш.)"
	desc = "Позволяет видеть в темноте на весь экран."
	cost = 2
	var_changes = list("darksight" = 8, "flash_mod" = 1.2)

/datum/trait/positive/melee_attack
	name = "Резкие атаки"
	desc = "Обеспечивает резкие атаки ближнего боя, которые наносят немного больше урона."
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp))

/datum/trait/positive/melee_attack_fangs
	name = "Резкие атаки и парализующие клыки"
	desc = "Обеспечивает резкие рукопашные атаки, которые наносят немного больший урон, а также клыки, из-за которых цель не сможет чувствовать свое тело или боль."
	cost = 2
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp, /datum/unarmed_attack/bite/sharp/numbing))

/datum/trait/positive/fangs
	name = "Отравленные клыки"
	desc = "Дарует Вам клыки, которые оказывают на жертву обезбаливающий эффект, из-за чего она не способна чувствовать боль или своё тело в целом."
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/sharp/numbing))

/datum/trait/positive/minor_brute_resist
	name = "Устойчивость к травмам"
	desc = "Добавляет 15% сопротивления источникам травмирующего урона."
	cost = 2
	var_changes = list("brute_mod" = 0.85)

/datum/trait/positive/brute_resist
	name = "Повышенная устойчивость к травмам"
	desc = "Добавляет 25% сопротивления источникам травмирующего урона."
	cost = 3
	var_changes = list("brute_mod" = 0.75)
	excludes = list(/datum/trait/positive/minor_burn_resist,/datum/trait/positive/burn_resist)

/datum/trait/positive/minor_burn_resist
	name = "Устойчивость к огню"
	desc = "Добавляет 15% сопротивления источникам обжигающего урона."
	cost = 2
	var_changes = list("burn_mod" = 0.85)

/datum/trait/positive/burn_resist
	name = "Повышенная устойчивость к огню"
	desc = "Добавляет 25% сопротивления источникам обжигающего урона."
	cost = 3
	var_changes = list("burn_mod" = 0.75)
	excludes = list(/datum/trait/positive/minor_brute_resist,/datum/trait/positive/brute_resist)

/datum/trait/positive/photoresistant
	name = "Светоустойчивый"
	desc = "Уменьшает длительность оглушения от вспышек и других оглушений и отключений, связанных с использованием света, на 50%"
	cost = 1
	var_changes = list("flash_mod" = 0.8)

/datum/trait/positive/winged_flight
	name = "Крылатый полет"
	desc = "Позволяет летать с помощью крыльев. Не забудьте их прикрепить!"
	cost = 0

/datum/trait/positive/winged_flight/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/flying_toggle
	H.verbs |= /mob/living/proc/start_wings_hovering

/datum/trait/positive/hardfeet
	name = "Твердые ступни"
	desc = "Делает ваши красивые когтистые, чешуйчатые, копытные, бронированные или иначе просто ужасно мозолистые ноги невосприимчивыми к осколкам стекла."
	cost = 0
	var_changes = list("flags" = NO_MINOR_CUT) //Checked the flag is only used by shard stepping.

/datum/trait/positive/antiseptic_saliva
	name = "Антисептическая слюна"
	desc = "Ваша слюна обладает особенно сильными антисептическими свойствами, которые можно использовать для заживления небольших ран."
	cost = 1

/datum/trait/positive/antiseptic_saliva/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/lick_wounds

/datum/trait/positive/traceur
	name = "Ловкач"
	desc = "Вы способны к паркуру и можете делать сальто над небольшими предметами (чаще всего)."
	cost = 2
	var_changes = list("agility" = 90)

/datum/trait/positive/snowwalker
	name = "Снегоход"
	desc = "Вы можете беспрепятственно передвигаться по снегу."
	cost = 1
	var_changes = list("snow_movement" = -2)

/datum/trait/positive/weaver
	name = "Weaver"
	desc = "You can produce silk and create various articles of clothing and objects."
	cost = 2
	var_changes = list("is_weaver" = 1)

/datum/trait/positive/weaver/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/check_silk_amount
	H.verbs |= /mob/living/carbon/human/proc/toggle_silk_production
	H.verbs |= /mob/living/carbon/human/proc/weave_structure
	H.verbs |= /mob/living/carbon/human/proc/weave_item
	H.verbs |= /mob/living/carbon/human/proc/set_silk_color
