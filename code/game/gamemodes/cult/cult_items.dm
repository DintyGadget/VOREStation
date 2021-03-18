/obj/item/weapon/melee/cultblade
	name = "cult blade"
	desc = "Тайное оружие, которым владеют последователи Нар-Си."
	icon_state = "cultblade"
	origin_tech = list(TECH_COMBAT = 1, TECH_ARCANE = 1)
	w_class = ITEMSIZE_LARGE
	force = 30
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	drop_sound = 'sound/items/drop/sword.ogg'
	pickup_sound = 'sound/items/pickup/sword.ogg'
	attack_verb = list("атакует", "рубит", "режет", "нарезает", "разрывает", "разрывает", "нарезает", "режет")
	edge = 1
	sharp = 1

/obj/item/weapon/melee/cultblade/cultify()
	return

/obj/item/weapon/melee/cultblade/attack(mob/living/M, mob/living/user, var/target_zone)
	if(iscultist(user) && !istype(user, /mob/living/simple_mob/construct))
		return ..()

	var/zone = (user.hand ? "l_arm":"r_arm")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/external/affecting = H.get_organ(zone)
		to_chat(user, "<span class='danger'>Необъяснимая сила пронзает ваше [affecting.name], вырывая меч из ваших рук!</span>")
		//random amount of damage between half of the blade's force and the full force of the blade.
		user.apply_damage(rand(force/2, force), BRUTE, zone, 0, sharp=1, edge=1)
		user.Weaken(5)
	else if(!istype(user, /mob/living/simple_mob/construct))
		to_chat(user, "<span class='danger'>Необъяснимая сила пронзает вас, вырывая меч из твоих рук!</span>")
	else
		to_chat(user, "<span class='critical'>Лезвие шипит, вырываясь из ваших манипуляторов. [src] позволит смертным использовать его только против врагов, а не против соратников.</span>")

	user.drop_from_inventory(src, src.loc)
	throw_at(get_edge_target_turf(src, pick(alldirs)), rand(1,3), throw_speed)

	var/spooky = pick('sound/hallucinations/growl1.ogg', 'sound/hallucinations/growl2.ogg', 'sound/hallucinations/growl3.ogg', 'sound/hallucinations/wail.ogg')
	playsound(src, spooky, 50, 1)

	return 1

/obj/item/weapon/melee/cultblade/pickup(mob/living/user as mob)
	if(!iscultist(user) && !istype(user, /mob/living/simple_mob/construct))
		to_chat(user, "<span class='warning'>Когда вы поднимаете меч культиста, вас охватывает непреодолимое чувство страха. Было бы разумно быстро избавиться от этого клинка.</span>")
		user.make_dizzy(120)
	if(istype(user, /mob/living/simple_mob/construct))
		to_chat(user, "<span class='warning'>[src] шипит, потому что недоволен вашим приобретением. Было бы разумно поскорее вернуть его достойному смертному.</span>")

/obj/item/clothing/head/culthood
	name = "cult hood"
	icon_state = "culthood"
	desc = "Капюшон последователей Нар-Си."
	origin_tech = list(TECH_MATERIAL = 3, TECH_ARCANE = 1)
	flags_inv = HIDEFACE
	body_parts_covered = HEAD
	armor = list(melee = 50, bullet = 30, laser = 50, energy = 80, bomb = 25, bio = 10, rad = 0)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/head/culthood/cultify()
	return

/obj/item/clothing/head/culthood/magus
	name = "magus helm"
	icon_state = "magus"
	desc = "Шлем, который носят последователи Нар-Си."
	flags_inv = HIDEFACE | BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/head/culthood/alt
	icon_state = "cult_hoodalt"

/obj/item/clothing/suit/cultrobes
	name = "cult robes"
	desc = "Набор бронированных мантий, которые носили последователи Нар-Си."
	icon_state = "cultrobes"
	origin_tech = list(TECH_MATERIAL = 3, TECH_ARCANE = 1)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	allowed = list(/obj/item/weapon/book/tome,/obj/item/weapon/melee/cultblade)
	armor = list(melee = 50, bullet = 30, laser = 50, energy = 80, bomb = 25, bio = 10, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0

/obj/item/clothing/suit/cultrobes/cultify()
	return

/obj/item/clothing/suit/cultrobes/alt
	icon_state = "cultrobesalt"

/obj/item/clothing/suit/cultrobes/magusred
	name = "magus robes"
	desc = "Набор бронированных мантий, которые носили последователи Нар-Си."
	icon_state = "magusred"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/head/helmet/space/cult
	name = "cult helmet"
	desc = "Космический шлем, которым пользовались последователи Нар-Си."
	icon_state = "cult_helmet"
	origin_tech = list(TECH_MATERIAL = 3, TECH_ARCANE = 1)
	armor = list(melee = 60, bullet = 50, laser = 30, energy = 80, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0

/obj/item/clothing/head/helmet/space/cult/cultify()
	return

/obj/item/clothing/suit/space/cult
	name = "cult armour"
	icon_state = "cult_armour"
	origin_tech = list(TECH_MATERIAL = 3, TECH_ARCANE = 1)
	desc = "Громоздкий доспех, ощетинившийся шипами. Смотрится достойно."
	w_class = ITEMSIZE_NORMAL
	allowed = list(/obj/item/weapon/book/tome,/obj/item/weapon/melee/cultblade,/obj/item/weapon/tank/emergency/oxygen,/obj/item/device/suit_cooling_unit)
	slowdown = 1
	armor = list(melee = 60, bullet = 50, laser = 30, energy = 80, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL|HIDETIE|HIDEHOLSTER
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|HANDS

/obj/item/clothing/suit/space/cult/cultify()
	return
