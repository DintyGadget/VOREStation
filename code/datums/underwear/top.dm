/datum/category_item/underwear/top/none
	name = "Нет"
	always_last = TRUE

/datum/category_item/underwear/top/none/is_default(var/gender)
	return gender != FEMALE

/datum/category_item/underwear/top/bra
	is_default = TRUE
	name = "Бюстгальтер"
	icon_state = "bra"
	has_color = TRUE

/datum/category_item/underwear/top/bra/is_default(var/gender)
	return gender == FEMALE

/datum/category_item/underwear/top/sports_bra
	name = "Спортивный бюстгальтер"
	icon_state = "sports_bra"
	has_color = TRUE

/datum/category_item/underwear/top/sports_bra_alt
	name = "Спортивный бюстгальтер, альт"
	icon_state = "sports_bra_alt"
	has_color = TRUE

/datum/category_item/underwear/top/lacy_bra
	name = "Бюстгальтер на лямке"
	icon_state = "lacy_bra"

/datum/category_item/underwear/top/lacy_bra_alt
	name = "Бюстгальтер на лямке, альт"
	icon_state = "lacy_bra_alt"
	has_color = TRUE

/datum/category_item/underwear/top/lacy_bra_alt_stripe
	name = "Бюстгальтер на лямке, альт, полосатый"
	icon_state = "lacy_bra_alt_stripe"

/datum/category_item/underwear/top/halterneck_bra
	name = "Халтер"
	icon_state = "halterneck_bra"
	has_color = TRUE

/datum/category_item/underwear/top/tubetop
	name = "Топик без лямок, окрашиваемый"
	icon_state = "tubetop"
	has_color = TRUE

/datum/category_item/underwear/top/fishnet_base
	name = "Топик в сеточку"
	icon_state = "fishnet_body"

/datum/category_item/underwear/top/fishnet_sleeves
	name = "Топик в сеточку с рукавами"
	icon_state = "fishnet_sleeves"

/datum/category_item/underwear/top/fishnet_gloves
	name = "Топик в сеточку с перчатками"
	icon_state = "fishnet_gloves"

/datum/category_item/underwear/top/striped_bra
	name = "Бюстгальтер полосатый"
	icon_state = "striped_bra"
	has_color = TRUE

/datum/category_item/underwear/top/binder
	name = "Топик"
	icon_state = "binder_s"

/datum/category_item/underwear/top/straplessbinder
	name = "Топик без лямок"
	icon_state = "straplessbinder_s"