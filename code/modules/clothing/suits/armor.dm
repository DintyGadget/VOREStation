/obj/item/clothing/suit/armor
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/maglight,/obj/item/clothing/head/helmet)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/mob_can_equip(var/mob/living/carbon/human/H, slot, disable_warning = FALSE)
	if(..()) //This will only run if no other problems occured when equiping.
		for(var/obj/item/clothing/I in list(H.gloves, H.shoes))
			if(I && (src.body_parts_covered & ARMS && I.body_parts_covered & ARMS) )
				to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(src, "acase")] поверх [ru_getcase(I, "gcase")].</span>")
				return 0
			if(I && (src.body_parts_covered & LEGS && I.body_parts_covered & LEGS) )
				to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(src, "acase")] поверх [ru_getcase(I, "gcase")].</span>")
				return 0
		return 1

/obj/item/clothing/suit/armor/vest
	name = "Бронежилет"
	desc = "Бронированный жилет, предоставляющий защиту от некоторых повреждений."
	icon_state = "armor"
	blood_overlay_type = "armor"
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/vest/alt
	name = "Бронежилет службы безопасности"
	desc = "Бронированный жилет, предоставляющий защиту от некоторых повреждений. На нём лого NanoTrasen."
	icon_state = "armoralt"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")

/obj/item/clothing/suit/armor/vest/security
	name = "Бронежилет службы безопасности"
	desc = "Бронированный жилет, предоставляющий защиту от некоторых повреждений. На нём лого NanoTrasen."
	icon_state = "armorsec"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")

/obj/item/clothing/suit/armor/riot
	name = "Милицейский бронежилет"
	desc = "Бронированный жилет с плотной подкладкой для защиты от атак ближнего боя."
	icon_state = "riot"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.5

/obj/item/clothing/suit/armor/riot/alt
	icon_state = "riot_new"
	item_state_slots = list(slot_r_hand_str = "riot_new", slot_l_hand_str = "riot_new")

/obj/item/clothing/suit/armor/bulletproof
	name = "Пуленепробиваемый бронежилет"
	desc = "Бронированный жилет, защищающий носителя от высокоскоростных баллистических снарядов."
	icon_state = "bulletproof"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/bulletproof/alt
	icon_state = "bulletproof_new"
	item_state_slots = list(slot_r_hand_str = "bulletproof_new", slot_l_hand_str = "bulletproof_new")
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/laserproof
	name = "Абляционный бронежилет"
	desc = "Бронированный жилет, защищающий носителя от энергетических снарядов."
	icon_state = "armor_reflec"
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.1

/obj/item/clothing/suit/armor/laserproof/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(istype(damage_source, /obj/item/projectile/energy) || istype(damage_source, /obj/item/projectile/beam))
		var/obj/item/projectile/P = damage_source

		if(P.reflected) // Can't reflect twice
			return ..()

		var/reflectchance = 40 - round(damage/3)
		if(!(def_zone in list(BP_TORSO, BP_GROIN)))
			reflectchance /= 2
		if(P.starting && prob(reflectchance))
			visible_message("<span class='danger'>[capitalize(ru_getcase(src, "ncase"))] [user] отражает [attack_text]!</span>")

			// Find a turf near or on the original location to bounce to
			var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/turf/curloc = get_turf(user)

			// redirect the projectile
			P.redirect(new_x, new_y, curloc, user)
			P.reflected = 1

			return PROJECTILE_CONTINUE // complete projectile permutation

/obj/item/clothing/suit/armor/combat
	name = "Боевой бронежилет"
	desc = "Бронированный жилет, защищающий носителя от некоторых распространненых видов оружия."
	icon_state = "combat"
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 30, bomb = 30, bio = 0, rad = 0)
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/tactical
	name = "Тактическая броня"
	desc = "Бронированный костюм, используемый отрядами специального назначения. Включает в себя пластинчатый жилет с карманами, а также наплечники и наколенники."
	icon_state = "swatarmor"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv = HIDETIE|HIDEHOLSTER
	slowdown = 1
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/swat
	name = "Броня СОБР"
	desc = "Бронированный костюм, защищающий носителя от повреждений средней тяжести. Используется в операциях специального назначения."
	icon_state = "deathsquad"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	item_flags = THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	slowdown = 1
	w_class = ITEMSIZE_HUGE
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 100)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	min_pressure_protection = 0 * ONE_ATMOSPHERE
	max_pressure_protection = 20* ONE_ATMOSPHERE
	siemens_coefficient = 0.6


/obj/item/clothing/suit/armor/swat/officer
	name = "Пиджак офицера"
	desc = "Бронированный пиджак, используемый в операциях специального назначения."
	icon_state = "detective"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")
	blood_overlay_type = "coat"
	flags_inv = 0
	body_parts_covered = UPPER_TORSO|ARMS


/obj/item/clothing/suit/armor/det_suit
	name = "Бронежилет детектива"
	desc = "Бронированный жилет с бейджиком детектива."
	icon_state = "detective-armor"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)


//Reactive armor
//When the wearer gets hit, this armor will teleport the user a short distance away (to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive
	name = "Reactive Teleport Armor"
	desc = "Someone separated our Research Director from their own head!"
	var/active = 0.0
	icon_state = "reactiveoff"
	item_state_slots = list(slot_r_hand_str = "armor_reflec_old", slot_l_hand_str = "armor_reflec_old")
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/reactive/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(prob(50))
		user.visible_message("<span class='danger'>The reactive teleport system flings [user] clear of the attack!</span>")
		var/list/turfs = new/list()
		for(var/turf/T in orange(6, user))
			if(istype(T,/turf/space)) continue
			if(T.density) continue
			if(T.x>world.maxx-6 || T.x<6)	continue
			if(T.y>world.maxy-6 || T.y<6)	continue
			turfs += T
		if(!turfs.len) turfs += pick(/turf in orange(6))
		var/turf/picked = pick(turfs)
		if(!isturf(picked)) return

		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(src, "sparks", 50, 1)

		user.loc = picked
		return PROJECTILE_FORCE_MISS
	return 0

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user as mob)
	active = !( active )
	if (active)
		to_chat(user, "<font color='blue'>The reactive armor is now active.</font>")
		icon_state = "reactive"
	else
		to_chat(user, "<font color='blue'>The reactive armor is now inactive.</font>")
		icon_state = "reactiveoff"
		add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	active = 0
	icon_state = "reactiveoff"
	..()

// Alien armor has a chance to completely block attacks.
/obj/item/clothing/suit/armor/alien
	name = "Инопланетный усиливающий жилет"
	desc = "Очень странный элемент брони, похожий на жилет. На вид весьма лёгкий и удобный. Что удивительно, подходит человеку по форме."
	description_info = "Имеет 20%-ный шанс полностью заблокировать входящую атаку и делает носителя слегка быстрее."
	icon_state = "alien_speed"
	blood_overlay_type = "armor"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	slowdown = -1
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 0, rad = 40)
	siemens_coefficient = 0.4
	var/block_chance = 20

/obj/item/clothing/suit/armor/alien/tank
	name = "Инопланетный защитный костюм"
	desc = "Очень устойчивый, пускай и легковесный, костюм -- вероятно, броня. Что удивительно, подходит человеку по форме."
	description_info = "Имеет 40%-ный шанс полностью заблокировать входящую атаку."
	icon_state = "alien_tank"
	slowdown = 0
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 70, bullet = 70, laser = 70, energy = 70, bomb = 70, bio = 0, rad = 40)
	block_chance = 40

/obj/item/clothing/suit/armor/alien/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(prob(block_chance))
		user.visible_message("<span class='danger'>[capitalize(ru_getcase(src, "ncase"))] полностью поглощает [attack_text]!</span>")
		return TRUE
	return FALSE

//Non-hardsuit ERT armor.
/obj/item/clothing/suit/armor/vest/ert
	name = "emergency response team armor"
	desc = "A set of armor worn by members of the Emergency Response Team."
	icon_state = "ertarmor_cmd"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 20, bio = 0, rad = 0)

//Commander
/obj/item/clothing/suit/armor/vest/ert/command
	name = "emergency response team commander armor"
	desc = "A set of armor worn by the commander of an Emergency Response Team. Has blue highlights."

//Security
/obj/item/clothing/suit/armor/vest/ert/security
	name = "emergency response team security armor"
	desc = "A set of armor worn by security members of the Emergency Response Team. Has red highlights."
	icon_state = "ertarmor_sec"

//Engineer
/obj/item/clothing/suit/armor/vest/ert/engineer
	name = "emergency response team engineer armor"
	desc = "A set of armor worn by engineering members of the Emergency Response Team. Has orange highlights."
	icon_state = "ertarmor_eng"

//Medical
/obj/item/clothing/suit/armor/vest/ert/medical
	name = "emergency response team medical armor"
	desc = "A set of armor worn by medical members of the Emergency Response Team. Has blue and white highlights."
	icon_state = "ertarmor_med"

//New Vests
/obj/item/clothing/suit/storage/vest
	name = "Бронежилет"
	desc = "Обыкновенный кевларовый разгрузочный жилет."
	icon_state = "kvest"
	blood_overlay_type = "armor"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/maglight,/obj/item/clothing/head/helmet)

	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/storage/vest/officer
	name = "Бронежилет офицера"
	desc = "Обыкновенный кевларовый разгрузочный жилет. У этого жилета к груди прикреплён голобейдж."
	icon_state = "officervest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "officervest_badge"
	icon_nobadge = "officervest_nobadge"

/obj/item/clothing/suit/storage/vest/warden
	name = "Бронежилет надзирателя"
	desc = "Обыкновенный кевларовый разгрузочный жилет. У этого жилета к груди прикреплён серебряный бейдж."
	icon_state = "wardenvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "wardenvest_badge"
	icon_nobadge = "wardenvest_nobadge"

/obj/item/clothing/suit/storage/vest/wardencoat
	name = "Пиджак надзирателя"
	desc = "Бронированный пиджак с серебряными нашивками."
	icon_state = "warden_jacket"
	blood_overlay_type = "suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags_inv = HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/wardencoat/alt
	name = "Пиджак надзирателя"
	desc = "Бронированный пиджак с серебряными нашивками."
	icon_state = "warden_alt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/storage/vest/hos
	name = "Бронежилет Главы службы безопасности"
	desc = "Обыкновенный кевларовый разгрузочный жилет. У этого жилета к груди прикреплен золотой бейдж."
	icon_state = "hosvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "hosvest_badge"
	icon_nobadge = "hosvest_nobadge"

/obj/item/clothing/suit/storage/vest/hoscoat
	name = "Бронированная шинель"
	desc = "Шинель, укреплённая особым сплавом и предоставляющая как защиту, так и стильный внешний вид."
	icon_state = "hos"
	blood_overlay_type = "suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags_inv = HIDETIE|HIDEHOLSTER

//Jensen cosplay gear
/obj/item/clothing/suit/storage/vest/hoscoat/jensen
	name = "Бронированный тренчкот"
	desc = "Тренчкот, укреплённый особым сплавом и предоставляющий как защиту, так и стильный внешний вид."
	icon_state = "hostrench"
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/pcrc
	name = "Бронежилет PCRC"
	desc = "Обыкновенный кевларовый разгрузочный жилет, принадлежащий Proxima Centauri Risk Control. К груди прикреплена эмблема PCRC."
	icon_state = "pcrcvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "pcrcvest_badge"
	icon_nobadge = "pcrcvest_nobadge"

/obj/item/clothing/suit/storage/vest/solgov/hedberg
	name = "Hedberg-Hammarstrom armor vest"
	desc = "A simple kevlar plate carrier belonging to Hedberg-Hammarstrom. The company logo is clearly visible."
	icon_state = "secwebvest"

/obj/item/clothing/suit/storage/vest/solgov
	name = "\improper Solar Confederate Government armored vest"
	desc = "A synthetic armor vest. This one is marked with the crest of the Solar Confederate Government."
	icon_state = "solvest"
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/solgov/heavy
	name = "\improper Solar Confederate Government heavy armored vest"
	desc = "A synthetic armor vest with Solar Confederate Government printed in distinctive blue lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "solwebvest"

/obj/item/clothing/suit/storage/vest/solgov/command
	name = "command heavy armored vest"
	desc = "A synthetic armor vest with Solar Confederate Government printed in detailed gold lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "comwebvest"

/obj/item/clothing/suit/storage/vest/tactical //crack at a more balanced mid-range armor, minor improvements over standard vests, with the idea "modern" combat armor would focus on energy weapon protection.
	name = "tactical armored vest"
	desc = "A heavy armored vest in a fetching tan. It is surprisingly flexible and light, even with the extra webbing and advanced ceramic plates."
	icon_state = "tacwebvest"
	item_state = "tacwebvest"
	armor = list(melee = 40, bullet = 40, laser = 60, energy = 35, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/heavy/flexitac //a reskin of the above to have a matching armor set
	name = "Тактический легковесный жилет"
	desc = "Бронированный жилет, изготовленный из гибких керамических пластин. Не самый красивый, однако очень удобный в ношении."
	icon_state = "flexitac"
	item_state = "flexitac"
	armor = list(melee = 40, bullet = 40, laser = 60, energy = 35, bomb = 30, bio = 0, rad = 0)
	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = T0C - 20
	slowdown = 0.3

/obj/item/clothing/suit/storage/vest/detective
	name = "Бронежилет детектива"
	desc = "Обыкновенный кевларовый разгрузочный жилет винтажного коричневого цвета. На груди закреплён бейдж, на котором написано 'Частный Сыщик'."
	icon_state = "detectivevest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "detectivevest_badge"
	icon_nobadge = "detectivevest_nobadge"

/obj/item/clothing/suit/storage/vest/press
	name = "Бронежилет прессы"
	icon_state = "pvest"
	desc = "Обыкновенный кевларовый разгрузочный жилет. На спине и груди вышивки с надписью 'Пресса'."
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	allowed = list(/obj/item/device/flashlight,/obj/item/device/taperecorder,/obj/item/weapon/pen,/obj/item/device/camera_film,/obj/item/device/camera,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/vest/heavy
	name = "Тяжёлый бронежилет"
	desc = "Тяжелый кевларовый разгрузочный жилет с прикреплёнными к нему лямками."
	icon_state = "webvest"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 50, bullet = 40, laser = 40, energy = 25, bomb = 25, bio = 0, rad = 0)
	slowdown = 0.5

/obj/item/clothing/suit/storage/vest/heavy/officer
	name = "Тяжёлый бронежилет офицера"
	desc = "Тяжелый кевларовый разгрузочный жилет с прикреплёнными к нему лямками. На груди закреплён голобейдж."
	icon_state = "officerwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "officerwebvest_badge"
	icon_nobadge = "officerwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/warden
	name = "Тяжёлый бронежилет надзирателя"
	desc = "Тяжелый кевларовый разгрузочный жилет с прикреплёнными к нему лямками. На груди закреплён серебряный бейдж."
	icon_state = "wardenwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "wardenwebvest_badge"
	icon_nobadge = "wardenwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/hos
	name = "Тяжёлый бронежилет Главы службы безопасности"
	desc = "Тяжелый кевларовый разгрузочный жилет с прикреплёнными к нему лямками. На груди закреплён золотой бейдж."
	icon_state = "hoswebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "hoswebvest_badge"
	icon_nobadge = "hoswebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/pcrc
	name = "Тяжёлый бронежилет PCRC"
	desc = "Тяжелый кевларовый разгрузочный жилет, принадлежащий Proxima Centauri Risk Control с прикреплёнными к нему лямками. На груди закреплена эмблема PCRC."
	icon_state = "pcrcwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "pcrcwebvest_badge"
	icon_nobadge = "pcrcwebvest_nobadge"

//Provides the protection of a merc voidsuit, but only covers the chest/groin, and also takes up a suit slot. In exchange it has no slowdown and provides storage.
/obj/item/clothing/suit/storage/vest/heavy/merc
	name = "Тяжёлый бронежилет"
	desc = "Тяжелый кевларовый разгрузочный жилет высокого качества. На удивление гибкий -- вероятно, изготовлен из отличного материала."
	icon_state = "mercwebvest"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 0

//All of the armor below is mostly unused

/obj/item/clothing/suit/armor/centcomm
	name = "CentCom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	w_class = ITEMSIZE_LARGE//bulky item
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/heavy
	name = "Тяжёлая броня"
	desc = "Бронированный костюм старого военного стандарта. Крайне устойчив против прямого урона! Однако предоставляет малую защиту против энергетических снарядов, что вкупе с его размерами делает этот костюм крайне устаревшим."
	icon_state = "heavy"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 90, bullet = 80, laser = 10, energy = 10, bomb = 80, bio = 0, rad = 0)
	w_class = ITEMSIZE_HUGE // Very bulky, very heavy.
	gas_transfer_coefficient = 0.90
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	slowdown = 5 // If you're a tank you're gonna move like a tank.
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/tdome/red
	name = "Красный костюм Громарены"
	desc = "Красноватая броня."
	icon_state = "tdred"
	siemens_coefficient = 1

/obj/item/clothing/suit/armor/tdome/green
	name = "Зелёный костюм Громарены"
	desc = "Броня блевотного цвета."
	icon_state = "tdgreen"
	siemens_coefficient = 1

//Modular plate carriers
/obj/item/clothing/suit/armor/pcarrier
	name = "Разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет чёрного цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon = 'icons/obj/clothing/modular_armor.dmi'
	item_icons = list(slot_wear_suit_str = 'icons/mob/modular_armor.dmi')
	icon_state = "pcarrier"
	valid_accessory_slots = (\
		ACCESSORY_SLOT_INSIGNIA\
		|ACCESSORY_SLOT_ARMOR_C\
		|ACCESSORY_SLOT_ARMOR_A\
		|ACCESSORY_SLOT_ARMOR_L\
		|ACCESSORY_SLOT_ARMOR_S\
		|ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = (\
		ACCESSORY_SLOT_INSIGNIA\
		|ACCESSORY_SLOT_ARMOR_C\
		|ACCESSORY_SLOT_ARMOR_A\
		|ACCESSORY_SLOT_ARMOR_L\
		|ACCESSORY_SLOT_ARMOR_S\
		|ACCESSORY_SLOT_ARMOR_M)
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/pcarrier/mob_can_equip(var/mob/living/carbon/human/H, slot, disable_warning = FALSE)
	if(..()) //This will only run if no other problems occured when equiping.
		if(H.gloves)
			if(H.gloves.body_parts_covered & ARMS)
				for(var/obj/item/clothing/accessory/A in src)
					if(A.body_parts_covered & ARMS)
						to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(A, "acase")] поверх [ru_getcase(H.gloves, "gcase")], нужно сперва их снять.</span>")
						return 0
		if(H.shoes)
			if(H.shoes.body_parts_covered & LEGS)
				for(var/obj/item/clothing/accessory/A in src)
					if(A.body_parts_covered & LEGS)
						to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(A, "acase")] поверх [ru_getcase(H.shoes, "gcase")], нужно сперва их снять.</span>")
						return 0
		return 1

/obj/item/clothing/suit/armor/pcarrier/explorer
	name = "explorer suit"
	desc = "A lightweight explorer plate carrier. It can be equipped with armor plates, but only protects from the cold on it's own."
	icon_state = "explorer"
	flags = THICKMATERIAL
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/suit/armor/pcarrier/light
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate)

/obj/item/clothing/suit/armor/pcarrier/light/sol
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/light/nt
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate, /obj/item/clothing/accessory/armor/tag/nt)

/obj/item/clothing/suit/armor/pcarrier/medium
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches)

/obj/item/clothing/suit/armor/pcarrier/medium/sol
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/medium/security
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/sec)

/obj/item/clothing/suit/armor/pcarrier/medium/command
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/com)

/obj/item/clothing/suit/armor/pcarrier/medium/nt
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/nt)

/obj/item/clothing/suit/armor/pcarrier/blue
	name = "Синий разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет синий цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon_state = "pcarrier_blue"

/obj/item/clothing/suit/armor/pcarrier/press
	name = "Голубой разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет голубого цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon_state = "pcarrier_press"

/obj/item/clothing/suit/armor/pcarrier/blue/sol
	name = "Разгрузочный жилет миротворца"
	desc = "Легковесный разгрузочный жилет в цветах миротворца ЦПС. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/medium, /obj/item/clothing/accessory/storage/pouches/blue, /obj/item/clothing/accessory/armor/armguards/blue, /obj/item/clothing/accessory/armor/tag)

/obj/item/clothing/suit/armor/pcarrier/green
	name = "Зелёный разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет зелёного цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon_state = "pcarrier_green"

/obj/item/clothing/suit/armor/pcarrier/navy
	name = "Тёмно-синий разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет тёмно-синего цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon_state = "pcarrier_navy"

/obj/item/clothing/suit/armor/pcarrier/tan
	name = "Бежевый разгрузочный жилет"
	desc = "Легковесный разгрузочный жилет бежевого цвета. Сам по себе не предоставляет защиты, однако может быть совмещён с пластинами брони."
	icon_state = "pcarrier_tan"

/obj/item/clothing/suit/armor/pcarrier/laserproof
	name = "ablative plate carrier"
	desc = "A specialist laser resistant plate carrier. It can be equipped with armour plates, but provides very little protection of its own."
	icon_state = "ablative"
	armor = list(melee = 0, bullet = 0, laser = 5, energy = 5, bomb = 0, bio = 0, rad = 0)
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/laserproof)

/obj/item/clothing/suit/armor/pcarrier/bulletproof
	name = "ballistic plate carrier"
	desc = "A specialist bullet resistant plate carrier. It can be equipped with armour plates, but provides very little protection of its own."
	icon_state = "ballistic"
	armor = list(melee = 0, bullet = 5, laser = 0, energy = 0, bomb = 5, bio = 0, rad = 0)
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/bulletproof)

/obj/item/clothing/suit/armor/pcarrier/riot
	name = "riot plate carrier"
	desc = "A specialist melee resistant plate carrier. It can be equipped with armour plates, but provides very little protection of its own."
	icon_state = "riot"
	armor = list(melee = 5, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/riot)

/obj/item/clothing/suit/armor/pcarrier/explorer/light
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/explorer, /obj/item/clothing/accessory/armor/armguards/explorer, /obj/item/clothing/accessory/armor/legguards/explorer, /obj/item/clothing/accessory/storage/pouches/green)

/obj/item/clothing/suit/armor/pcarrier/tan/tactical
	name = "Тактический разгрузочный жилет"
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/tactical, /obj/item/clothing/accessory/storage/pouches/large/tan)

/obj/item/clothing/suit/armor/pcarrier/merc
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/merc, /obj/item/clothing/accessory/armor/armguards/merc, /obj/item/clothing/accessory/armor/legguards/merc, /obj/item/clothing/accessory/storage/pouches/large)

/obj/item/clothing/suit/armor/pcarrier/laserproof/full
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/laserproof, /obj/item/clothing/accessory/armor/armguards/laserproof, /obj/item/clothing/accessory/armor/legguards/laserproof, /obj/item/clothing/accessory/storage/pouches/blue)

/obj/item/clothing/suit/armor/pcarrier/bulletproof/full
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/bulletproof, /obj/item/clothing/accessory/armor/armguards/bulletproof, /obj/item/clothing/accessory/armor/legguards/bulletproof, /obj/item/clothing/accessory/storage/pouches)

/obj/item/clothing/suit/armor/pcarrier/riot/full
	starting_accessories = list(/obj/item/clothing/accessory/armor/armorplate/riot, /obj/item/clothing/accessory/armor/armguards/riot, /obj/item/clothing/accessory/armor/legguards/riot, /obj/item/clothing/accessory/storage/pouches)