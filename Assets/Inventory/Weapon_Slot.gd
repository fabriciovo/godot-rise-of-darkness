class_name Weapon_Slot extends Button

var sword_icon = preload("res://Sprites/Button/sword_btn_icon.png")
var heal_icon = preload("res://Sprites/Button/healstaff_btn_icon.png")
var bow_icon = preload("res://Sprites/Button/bow_btn_icon.png")
var bomb_icon = preload("res://Sprites/Button/bomb_btn_icon.png")
var shield_icon = preload("res://Sprites/Button/shield_btn_icon.png")
var weapon_type = -1

func _ready():
	var game_ui_node = Ui.get_node("Game_UI")
	if game_ui_node:
		game_ui_node.connect("on_equip_weapon", self, "_on_equip_weapon")

func set_weapon_type(_weapon_type):
	if _weapon_type == -1: return
	weapon_type = _weapon_type
	match weapon_type:
		Global.WEAPONS.SWORD:
			icon = sword_icon
		Global.WEAPONS.HEAL:
			icon = heal_icon
		Global.WEAPONS.BOW:
			icon = bow_icon
		Global.WEAPONS.BOMB:
			icon = bomb_icon
		Global.WEAPONS.SHIELD:
			icon = shield_icon

func set_focus(value):
	if value:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(2,2,2,2)

func _on_equip_weapon(_weapon_type, _slot):
	PlayerControll.set_equiped_item(_weapon_type, _slot)
