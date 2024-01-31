extends Control
signal on_set_to_weapon_list(weapon_type, index)

onready var weapons_list = $Weapons_Container.get_children()
onready var weapon_info = $Weapon_Info

func set_weapons():
	weapons_list[0].grab_focus()
	for weapon in PlayerControll.inventory:
		match weapon:
			Global.WEAPONS.SWORD:
				weapons_list[0].text = "Sword"
				weapons_list[0].disabled = false
				weapon_info.bbcode_text = "Sword Text"
			Global.WEAPONS.BOW:
				weapons_list[1].text = "Bow"
				weapons_list[1].disabled = false
			Global.WEAPONS.BOMB:
				weapons_list[2].text = "Bomb"
				weapons_list[2].disabled = false
			Global.WEAPONS.HEAL:
				weapons_list[3].text = "Staff"
				weapons_list[3].disabled = false
			Global.WEAPONS.SHIELD:
				weapons_list[4].text = "Shield"
				weapons_list[4].disabled = false

func set_weapon(_weapon):
	pass

func _on_Sword_focus_entered():
	if weapons_list[0].text == "Sword":
		weapon_info.bbcode_text = "Sword Text"
	else:
		weapon_info.bbcode_text = "????"

func _on_Bow_focus_entered():
	if weapons_list[1].text == "Bow":
		weapon_info.bbcode_text = "Bow Text"
	else:
		weapon_info.bbcode_text = "????"

func _on_Bomb_focus_entered():
	if weapons_list[2].text == "Bomb":
		weapon_info.bbcode_text = "Bomb Text"
	else:
		weapon_info.bbcode_text = "????"

func _on_Heal_focus_entered():
	if weapons_list[3].text == "Staff":
		weapon_info.bbcode_text = "Staff Text"
	else:
		weapon_info.bbcode_text = "????"

func _on_Shield_focus_entered():
	if weapons_list[4].text == "Shield":
		weapon_info.bbcode_text = "Shield Text"
	else:
		weapon_info.bbcode_text = "????"

func _on_Sword_pressed():
	emit_signal("on_set_to_weapon_list", 0, 3)

func _on_Bow_pressed():
	emit_signal("on_set_to_weapon_list", 0, 3)

func _on_Bomb_pressed():
	emit_signal("on_set_to_weapon_list", 0, 3)

func _on_Staff_pressed():
	print("pressed")

func _on_Shield_pressed():
	print("pressed")
