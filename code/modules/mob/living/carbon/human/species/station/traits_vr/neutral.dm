#define ORGANICS	1
#define SYNTHETICS	2

/datum/trait/neutral

/datum/trait/neutral/metabolism_up
	name = "Быстрый метаболизм"
	desc = "Вы быстрее перевариваете проглоченные и введенные реагенты, и в Вас быстрее просыпается голод (скорость Тешари)."
	cost = 0
	var_changes = list("metabolic_rate" = 1.2, "hunger_factor" = 0.2, "metabolism" = 0.06) // +20% rate and 4x hunger (Teshari level)
	excludes = list(/datum/trait/neutral/metabolism_down, /datum/trait/neutral/metabolism_apex)

/datum/trait/neutral/metabolism_down
	name = "Медленный метаболизм"
	desc = "Вы обрабатываете проглоченные и введенные реагенты медленнее, и менее часто хотите есть."
	cost = 0
	var_changes = list("metabolic_rate" = 0.8, "hunger_factor" = 0.04, "metabolism" = 0.0012) // -20% of default.
	excludes = list(/datum/trait/neutral/metabolism_up, /datum/trait/neutral/metabolism_apex)

/datum/trait/neutral/metabolism_apex
	name = "Пиковый метаболизм"
	desc = "Наконец-то достойное оправдание вашим хищническим действиям. По сути, удваивает метаболизм. Подходит для персонажей с большим аппетитом."
	cost = 0
	var_changes = list("metabolic_rate" = 1.4, "hunger_factor" = 0.4, "metabolism" = 0.012) // +40% rate and 8x hunger (Double Teshari)
	excludes = list(/datum/trait/neutral/metabolism_up, /datum/trait/neutral/metabolism_down)

/datum/trait/neutral/coldadapt
	name = "Хладнокровный"
	desc = "Вы способны выдерживать гораздо более низкие температуры, чем другие расы, и даже можете чувствовать себя комфортно в очень холодных условиях. Вы также более уязвимы к жаркой окружающей среде и имеете более низкую температуру тела в результате такой адаптации."
	cost = 0
	var_changes = list("cold_level_1" = 200,  "cold_level_2" = 150, "cold_level_3" = 90, "breath_cold_level_1" = 180, "breath_cold_level_2" = 100, "breath_cold_level_3" = 60, "cold_discomfort_level" = 210, "heat_level_1" = 330, "heat_level_2" = 380, "heat_level_3" = 700, "breath_heat_level_1" = 360, "breath_heat_level_2" = 400, "breath_heat_level_3" = 850, "heat_discomfort_level" = 295, "body_temperature" = 290)
	excludes = list(/datum/trait/neutral/hotadapt)

/datum/trait/neutral/hotadapt
	name = "Теплокровный"
	desc = "Вы способны выдерживать гораздо более высокие температуры, чем другие расы, и даже можете чувствовать себя комфортно в очень жаркой среде. Вы также более уязвимы к холоду, и вследствие этих адаптаций имеете повышенную температура тела."
	cost = 0
	var_changes = list("heat_level_1" = 420, "heat_level_2" = 460, "heat_level_3" = 1100, "breath_heat_level_1" = 440, "breath_heat_level_2" = 510, "breath_heat_level_3" = 1500, "heat_discomfort_level" = 390, "cold_level_1" = 280, "cold_level_2" = 220, "cold_level_3" = 140, "breath_cold_level_1" = 260, "breath_cold_level_2" = 240, "breath_cold_level_3" = 120, "cold_discomfort_level" = 280, "body_temperature" = 330)
	excludes = list(/datum/trait/neutral/coldadapt)

/datum/trait/neutral/autohiss_unathi
	name = "Шипение (Унати)"
	desc = "Теперь вы шипите"
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"с" = list("сс", "ссс", "сссс")
		),
	autohiss_extra_map = list(
			"кс" = list("кс", "ксс", "кссс")
		),
	autohiss_exempt = list("Sinta'unathi"))

	excludes = list(/datum/trait/neutral/autohiss_tajaran)

/datum/trait/neutral/autohiss_tajaran
	name = "Шипение (Таджара)"
	desc = "Теперь вы мурчите."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"р" = list("рр", "ррр", "рррр")
		),
	autohiss_exempt = list("Siik"))
	excludes = list(/datum/trait/neutral/autohiss_unathi)

/datum/trait/neutral/bloodsucker
	name = "Кровосос"
	desc = "Позволяет получать питательные вещества только за счет чужой крови. В качестве компенсации Вы получаете клыки, которые можно использовать для получения крови с добычи."
	cost = 0
	custom_only = FALSE
	var_changes = list("organic_food_coeff" = 0) //The verb is given in human.dm

/datum/trait/neutral/bloodsucker/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/bloodsuck

/datum/trait/neutral/succubus_drain
	name = "Истощение суккуба"
	desc = "Делает вас способным получать питание от истощения добычи в ваших руках."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/succubus_drain/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain_finalize
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain_lethal

/datum/trait/neutral/feeder
	name = "Съедобный"
	desc = "Позволяет Вам кормить свою добычу, используя ваше собственное тело."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/feeder/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/slime_feed

/datum/trait/neutral/hard_vore
	name = "Жестокий хищник"
	desc = "Позволяет отрывать конечности и вырывать внутренние органы."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/hard_vore/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/shred_limb

/datum/trait/neutral/trashcan
	name = "Мусорка"
	desc = "Позволяет переваривать мусор самостоятельно вместо того, чтобы искать мусорное ведро или мусорить, как животное."
	cost = 0
	custom_only = FALSE
	var_changes = list("trashcan" = 1)

/datum/trait/neutral/trashcan/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/eat_trash

/datum/trait/neutral/gem_eater
	name = "Рудоед"
	desc = "Вы получаете питание только из сырой руды и очищенных минералов. Нет ничего, что удовлетворяет аппетит лучше, чем драгоценные камни, экзотические или редкие минералы, и у Вас чертовски хороший вкус. Все остальное ниже Вашего достоинства."
	cost = 0
	custom_only = FALSE
	var_changes = list("organic_food_coeff" = 0, "eat_minerals" = 1)

/datum/trait/neutral/gem_eater/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/eat_minerals

/datum/trait/neutral/synth_chemfurnace
	name = "Биотопливный процессор"
	desc = "Вы можете получать энергию, потребляя и обрабатывая обычную пищу. Наилучшие результаты принесут высококалорийные продукты, такие как протеиновые батончики и продукты для выживания."
	cost = 0
	custom_only = FALSE
	can_take = SYNTHETICS
	var_changes = list("organic_food_coeff" = 0, "synthetic_food_coeff" = 0.25)

/datum/trait/neutral/glowing_eyes
	name = "Светящиеся глаза"
	desc = "Ваши глаза светятся в темноте. Жутко! И немного показушно."
	cost = 0
	custom_only = FALSE
	var_changes = list("has_glowing_eyes" = 1)

/datum/trait/neutral/glowing_body
	name = "Светящееся тело"
	desc = "Ваше тело светится примерно так же, как фонарик ПДА! Настраиваемый цвет и переключение на вкладке способностей в игре."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/glowing_body/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/glow_toggle
	H.verbs |= /mob/living/proc/glow_color


//Allergen traits! Not available to any species with a base allergens var.
/datum/trait/neutral/allergy
	name = "Allergy: Gluten"
	desc = "You're highly allergic to gluten proteins, which are found in most common grains."
	cost = 0
	custom_only = FALSE
	var/allergen = GRAINS

/datum/trait/neutral/allergy/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	S.allergens |= allergen
	..(S,H)

/datum/trait/neutral/allergy/meat
	name = "Allergy: Meat"
	desc = "You're highly allergic to just about any form of meat. You're probably better off just sticking to vegetables. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = MEAT

/datum/trait/neutral/allergy/fish
	name = "Allergy: Fish"
	desc = "You're highly allergic to fish. It's probably best to avoid seafood in general. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = FISH

/datum/trait/neutral/allergy/fruit
	name = "Allergy: Fruit"
	desc = "You're highly allergic to fruit. Vegetables are fine, but you should probably read up on how to tell the difference. Remember, tomatoes are a fruit. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = FRUIT

/datum/trait/neutral/allergy/vegetable
	name = "Allergy: Vegetable"
	desc = "You're highly allergic to vegetables. Fruit are fine, but you should probably read up on how to tell the difference. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = VEGETABLE

/datum/trait/neutral/allergy/nuts
	name = "Allergy: Nuts"
	desc = "You're highly allergic to hard-shell seeds, such as peanuts. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = SEEDS

/datum/trait/neutral/allergy/soy
	name = "Allergy: Soy"
	desc = "You're highly allergic to soybeans, and some other kinds of bean. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = BEANS

/datum/trait/neutral/allergy/dairy
	name = "Allergy: Lactose"
	desc = "You're highly allergic to lactose, and consequently, just about all forms of dairy. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = DAIRY

/datum/trait/neutral/allergy/fungi
	name = "Allergy: Fungi"
	desc = "You're highly allergic to fungi such as mushrooms. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = FUNGI

/datum/trait/neutral/allergy/coffee
	name = "Allergy: Coffee"
	desc = "You're highly allergic to coffee in specific. NB: By taking this trait, you acknowledge there is a risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	custom_only = FALSE
	allergen = COFFEE

/datum/trait/neutral/allergen_reduced_effect
	name = "Reduced Allergen Reaction"
	desc = "This trait halves the lethality of allergen reactions. If you don't have any allergens set, it does nothing. It does not apply to nonlethal reactions or special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	custom_only = FALSE
	var_changes = list("allergen_damage_severity" = 0.6)

// Spicy Food Traits, from negative to positive.
/datum/trait/neutral/spice_intolerance_extreme
	name = "Крайняя непереносимость специй"
	desc = "Острый (и чили) перец в три раза крепче. (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 3) // 300% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/spice_intolerance_basic
	name = "Сильная непереносимость специй"
	desc = "Пряный (и чили) перец в два раза крепче. (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 2) // 200% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/spice_intolerance_slight
	name = "Легкая непереносимость специй"
	desc = "У вас есть небольшая борьба с острой пищей. Острые (и холодные) перцы в полтора раза сильнее. (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 1.5) // 150% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/spice_tolerance_basic
	name = "Толерантность к специям"
	desc = "Острый (и чили) перец крепче всего на три четверти. (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 0.75) // 75% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/spice_tolerance_advanced
	name = "Сильная толерантность к специям"
	desc = "Острый (и чили) перец вдвое слабее. (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 0.5) // 50% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/spice_immunity
	name = "Экстримальная толерантность к специям"
	desc = "Острый (и чили) перец в принципе неэффективен! (Это не влияет на перцовый баллончик.)"
	cost = 0
	custom_only = FALSE
	var_changes = list("spice_mod" = 0.25) // 25% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!

// Alcohol Traits Start Here, from negative to positive.
/datum/trait/neutral/alcohol_intolerance_advanced
	name = "Воздушная печень"
	desc = "Если бухать, так только если держать бухло в своих руках, да и даже так его лучше сильно не вдыхать. Напитки в три раза крепче."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 3) // 300% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_intolerance_basic
	name = "Слабая печень"
	desc = "Вам тяжело употреблять алкоголь. Может быть, Вы просто никогда не принимали его, а может, он Вам не нравится ... в любом случае, напитки в два раза крепче."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 2) // 200% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_intolerance_slight
	name = "Трезвенник"
	desc = "Вы не очень хорошо ладите с алкоголем. Напитки в полтора раза крепче."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 1.5) // 150% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_tolerance_basic
	name = "Железная печень"
	desc = "Вы можете пить гораздо больше, чем остальные любители сока! Арр! Напитки только на три четверти крепче."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 0.75) // 75% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_tolerance_advanced
	name = "Стальная печень"
	desc = "Напитки трепещут перед Вашей мощью! Вы можете пить алкоголь в два раза больше, чем все эти худобрюхие! Напитки в два раза менее крепкие."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 0.5) // 50% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_immunity
	name = "Дюрасталевая печень"
	desc = "Вы так много пили, что большинство спиртных напитков даже не опьяняют вас. Вам понадобится аж какой-нибудь Пан-Галактический или пинта Смертозвона, чтобы Вас хотя бы слегка торкнуло."
	cost = 0
	custom_only = FALSE
	var_changes = list("alcohol_mod" = 0.25) // 25% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!
// Alcohol Traits End Here.

/datum/trait/neutral/colorblind/mono
	name = "Colorblindness (Monochromancy)"
	desc = "You simply can't see colors at all, period. You are 100% colorblind."
	cost = 0

/datum/trait/neutral/colorblind/mono/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_monochrome)

/datum/trait/neutral/colorblind/para_vulp
	name = "Colorblindness (Para Vulp)"
	desc = "You have a severe issue with green colors and have difficulty recognizing them from red colors."
	cost = 0

/datum/trait/neutral/colorblind/para_vulp/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_vulp)

/datum/trait/neutral/colorblind/para_taj
	name = "Colorblindness (Para Taj)"
	desc = "You have a minor issue with blue colors and have difficulty recognizing them from red colors."
	cost = 0

/datum/trait/neutral/colorblind/para_taj/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_taj)

// Body shape traits
/datum/trait/neutral/taller
	name = "Tall"
	desc = "Your body is taller than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_y" = 1.09)
	excludes = list(/datum/trait/neutral/tall, /datum/trait/neutral/short, /datum/trait/neutral/shorter)

/datum/trait/neutral/taller/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/tall
	name = "Slightly Tall"
	desc = "Your body is a bit taller than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_y" = 1.05)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/short, /datum/trait/neutral/shorter)

/datum/trait/neutral/tall/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/short
	name = "Slightly Short"
	desc = "Your body is a bit shorter than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_y" = 0.95)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/tall, /datum/trait/neutral/shorter)

/datum/trait/neutral/short/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/shorter
	name = "Short"
	desc = "Your body is shorter than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_y" = 0.915)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/tall, /datum/trait/neutral/short)

/datum/trait/neutral/shorter/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/obese
	name = "Very Bulky"
	desc = "Your body is much wider than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_x" = 1.095)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/thin, /datum/trait/neutral/thinner)

/datum/trait/neutral/obese/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/fat
	name = "Bulky"
	desc = "Your body is wider than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_x" = 1.054)
	excludes = list(/datum/trait/neutral/obese, /datum/trait/neutral/thin, /datum/trait/neutral/thinner)

/datum/trait/neutral/fat/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/thin
	name = "Thin"
	desc = "Your body is thinner than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_x" = 0.945)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/obese, /datum/trait/neutral/thinner)

/datum/trait/neutral/thin/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/thinner
	name = "Very Thin"
	desc = "Your body is much thinner than average."
	cost = 0
	custom_only = FALSE
	var_changes = list("icon_scale_x" = 0.905)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/obese, /datum/trait/neutral/thin)

/datum/trait/neutral/thinner/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()
