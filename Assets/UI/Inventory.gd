extends Control

var sword_icon = preload("res://Sprites/Button/sword_btn_icon.png")
var staff_icon = preload("res://Sprites/Button/healstaff_btn_icon.png")
var bow_icon = preload("res://Sprites/Button/bow_btn_icon.png")
var bomb_icon = preload("res://Sprites/Button/bomb_btn_icon.png")
var shield_icon = preload("res://Sprites/Button/shield_btn_icon.png")

onready var weapons_list = $Weapons_Container.get_children()
onready var weapon_info = $Weapon_Info
onready var game_ui = get_node("/root/Ui/Game_UI")

func set_weapons():
	for _index in PlayerControll.inventory.size():
		if PlayerControll.inventory[_index] == Global.WEAPONS.SWORD: 
			weapons_list[0].icon = sword_icon
			weapons_list[0].text = "SWORD_NAME"
			weapons_list[0].disabled = false
			weapon_info.bbcode_text = tr("SWORD_DESCRIPTION")
		elif PlayerControll.inventory[_index] == Global.WEAPONS.BOW: 
			weapons_list[1].icon = bow_icon
			weapons_list[1].text = "BOW_NAME"
			weapons_list[1].disabled = false
		elif PlayerControll.inventory[_index] == Global.WEAPONS.BOMB: 
			weapons_list[2].icon = bomb_icon
			weapons_list[2].text = "BOMB_NAME"
			weapons_list[2].disabled = false
		elif PlayerControll.inventory[_index] == Global.WEAPONS.HEAL: 
			weapons_list[3].icon = staff_icon
			weapons_list[3].text = "HEAL_STAFF_NAME"
			weapons_list[3].disabled = false
		elif PlayerControll.inventory[_index] == Global.WEAPONS.SHIELD: 
			weapons_list[4].icon = shield_icon
			weapons_list[4].text = "SHIELD_NAME"
			weapons_list[4].disabled = false
	weapons_list[0].grab_focus()

func _on_Sword_focus_entered():
	if weapons_list[0].text == "SWORD_NAME":
		weapon_info.bbcode_text = tr("SWORD_DESCRIPTION")
	else:
		weapon_info.bbcode_text = "????"

func _on_Bow_focus_entered():
	if weapons_list[1].text == "BOW_NAME":
		weapon_info.bbcode_text = tr("BOW_DESCRIPTION")
	else:
		weapon_info.bbcode_text = "????"

func _on_Bomb_focus_entered():
	if weapons_list[2].text == "BOMB_NAME":
		weapon_info.bbcode_text = tr("BOMB_DESCRIPTION")
	else:
		weapon_info.bbcode_text = "????"

func _on_Heal_focus_entered():
	if weapons_list[3].text == "HEAL_STAFF_NAME":
		weapon_info.bbcode_text = tr("HEAL_STAFF_DESCRIPTION")
	else:
		weapon_info.bbcode_text = "????"

func _on_Shield_focus_entered():
	if weapons_list[4].text == "SHIELD_NAME":
		weapon_info.bbcode_text = tr("SHIELD_DESCRIPTION")
	else:
		weapon_info.bbcode_text = "????"

func _on_Sword_pressed():
	PlayerControll.update_weapon_slot(0,game_ui.weapon_slot_index)

func _on_Bow_pressed():
	PlayerControll.update_weapon_slot(1,game_ui.weapon_slot_index)

func _on_Bomb_pressed():
	PlayerControll.update_weapon_slot(2,game_ui.weapon_slot_index)

func _on_Staff_pressed():
	PlayerControll.update_weapon_slot(3,game_ui.weapon_slot_index)

func _on_Shield_pressed():
	PlayerControll.update_weapon_slot(5,game_ui.weapon_slot_index)
