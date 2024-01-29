extends Control

onready var weapons_list = $Weapons_Container.get_children()


func set_weapons():
	weapons_list[0].grab_focus()
	for weapon in PlayerControll.inventory:
		match weapon:
			Global.WEAPONS.SWORD:
				weapons_list[0].text = "Sword"
			Global.WEAPONS.BOW:
				weapons_list[1].text = "Bow"
			Global.WEAPONS.BOMB:
				weapons_list[2].text = "Bomb"
			Global.WEAPONS.HEAL:
				weapons_list[3].text = "Staff"
			Global.WEAPONS.SHIELD:
				weapons_list[4].text = "Shield"

func set_weapon(_weapon):
	pass

func _on_Sword_focus_entered():
	if weapons_list[0].text == "Sword":
		$Weapon_Info.bbcode_text = "Bow Text"
	else:
		$Weapon_Info.bbcode_text = "????"

func _on_Bow_focus_entered():
	if weapons_list[1].text == "Bow":
		$Weapon_Info.bbcode_text = "Bow Text"
	else:
		$Weapon_Info.bbcode_text = "????"


func _on_Bomb_focus_entered():
	if weapons_list[2].text == "Bomb":
		$Weapon_Info.bbcode_text = "Bomb Text"
	else:
		$Weapon_Info.bbcode_text = "????"

func _on_Heal_focus_entered():
	if weapons_list[3].text == "Staff":
		$Weapon_Info.bbcode_text = "Staff Text"
	else:
		$Weapon_Info.bbcode_text = "????"


func _on_Shield_focus_entered():
	if weapons_list[4].text == "Shield":
		$Weapon_Info.bbcode_text = "Shield Text"
	else:
		$Weapon_Info.bbcode_text = "????"

