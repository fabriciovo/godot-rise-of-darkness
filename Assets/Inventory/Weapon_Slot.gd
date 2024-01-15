class_name Weapon_Slot extends Button

var sword_icon = preload("res://Sprites/Button/sword_btn_icon.png")
var heal_icon = preload("res://Sprites/Button/healstaff_btn_icon.png")
var bow_icon = preload("res://Sprites/Button/bow_btn_icon.png")
var bomb_icon = preload("res://Sprites/Button/bomb_btn_icon.png")
var shield_icon = preload("res://Sprites/Button/shield_btn_icon.png")
var weapon_type = 0

func set_weapon_type(_weapon_type):
	if weapon_type == -1: return
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
