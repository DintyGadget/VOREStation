#define ORGANICS	1
#define SYNTHETICS	2

/datum/trait/speed_slow
	name = "Замедление"
	desc = "Принуждает двигаться медленнее, чем обычно."
	cost = -2
	var_changes = list("slowdown" = 0.5)

/datum/trait/speed_slow_plus
	name = "Значительное замедление"
	desc = "Принуждает двигаться гораздо медленнее, чем обычно."
	cost = -3
	var_changes = list("slowdown" = 1.0)

/datum/trait/weakling
	name = "Слабак"
	desc = "Сильно замедляет Вас при перемещении тяжелых объектов или оборудования."
	cost = -1
	var_changes = list("item_slowdown_mod" = 1.5)

/datum/trait/weakling_plus
	name = "Дохляк"
	desc = "Очень сильно замедляет Вас при перемещении тяжелых объектов или оборудования."
	cost = -2
	var_changes = list("item_slowdown_mod" = 2.0)

/datum/trait/endurance_low
	name = "Низкая выносливость"
	desc = "Уменьшает максимальное количество здоровья до 75."
	cost = -2
	var_changes = list("total_health" = 75)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/endurance_very_low
	name = "Чрезвычайно низкая выносливость"
	desc = "Уменьшает максимальное количество здоровья до 50."
	cost = -3 //Teshari HP. This makes the person a lot more suseptable to getting stunned, killed, etc.
	var_changes = list("total_health" = 50)

	apply(var/datum/species/S,var/mob/living/carbon/human/H)
		..(S,H)
		H.setMaxHealth(S.total_health)

/datum/trait/minor_brute_weak
	name = "Малая слабость к травмам"
	desc = "Увеличивает получаемый травмирующий урон на 15%"
	cost = -1
	var_changes = list("brute_mod" = 1.15)

/datum/trait/brute_weak
	name = "Слабость к травмам"
	desc = "Увеличивает получаемый травмирующий урон на 25%"
	cost = -2
	var_changes = list("brute_mod" = 1.25)

/datum/trait/brute_weak_plus
	name = "Серьезная слабость травмам"
	desc = "Увеличивает получаемый травмирующий урон на 50%"
	cost = -3
	var_changes = list("brute_mod" = 1.5)

/datum/trait/minor_burn_weak
	name = "Малая слабость к ожогам"
	desc = "Увеличивает получаемый обжигающий урон на 15%"
	cost = -1
	var_changes = list("burn_mod" = 1.15)

/datum/trait/burn_weak
	name = "Слабость к ожогам"
	desc = "Увеличивает получаемый обжигающий урон на 25%"
	cost = -2
	var_changes = list("burn_mod" = 1.25)

/datum/trait/burn_weak_plus
	name = "Серьезная слабость к ожогам"
	desc = "Увеличивает получаемый обжигающий урон на 50%"
	cost = -3
	var_changes = list("burn_mod" = 1.5)

/datum/trait/conductive
	name = "Проводник"
	desc = "Увеличивает Вашу восприимчивость к электрическим ударам на 50%"
	cost = -1
	var_changes = list("siemens_coefficient" = 1.5) //This makes you a lot weaker to tasers.

/datum/trait/conductive_plus
	name = "Сильный проводник"
	desc = "Увеличивает Вашу восприимчивость к электрическим ударам на 100%"
	cost = -2
	var_changes = list("siemens_coefficient" = 2.0) //This makes you extremely weak to tasers.

/datum/trait/haemophilia
	name = "Гемофилия (только органики)"
	desc = "Когда вы истекаете кровью, Вы теряете её гораздо в большем количестве. Эта черта характерна только для органиков, багует с синтетиками!"
	cost = -2
	var_changes = list("bloodloss_rate" = 2)
	can_take = ORGANICS

/datum/trait/hollow
	name = "Хрупкие кости / Алюминиевый сплав"
	desc = "Ваши кости или механические конечности гораздо легче сломать."
	cost = -2 //I feel like this should be higher, but let's see where it goes

/datum/trait/hollow/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	for(var/obj/item/organ/external/O in H.organs)
		O.min_broken_damage *= 0.5
		O.min_bruised_damage *= 0.5

/datum/trait/lightweight
	name = "Легкий"
	desc = "Ваш легкий вес и плохой баланс делают Вас очень восприимчивыми к столкновениям."
	cost = -2
	var_changes = list("lightweight" = 1)

/datum/trait/colorblind/mono
	name = "Дальтонизм (монохромность)"
	desc = "Вы просто не можете видеть цвета вообще, и точка. Вы на 100% дальтоник."
	cost = -1

/datum/trait/colorblind/mono/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_monochrome)

/datum/trait/colorblind/para_vulp
	name = "Дальтонизм (Вульпканин)"
	desc = "Зеленые цвета ставят Вас в ступор, и Вы не можете отличить их от красных цветов."
	cost = -1

/datum/trait/colorblind/para_vulp/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_vulp)

/datum/trait/colorblind/para_taj
	name = "Дальтонизм (Таджара)"
	desc = "Синие цвета ставят Вас в ступор, и Вы не можете отличить их от красных цветов."
	cost = -1

/datum/trait/colorblind/para_taj/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_taj)


/datum/trait/neural_hypersensitivity
	name = "Neural Hypersensitivity"
	desc = "Your nerves are particularly sensitive to physical changes, leading to experiencing twice the intensity of pain and pleasure alike. Doubles traumatic shock."
	cost = -1
	var_changes = list("trauma_mod" = 2)

