extends Control

signal on_equip_weapon(weapon_type, slot)

onready var weapons_list = $Items/Weapons/Inventory_List/Weapons_Center_Container/Weapons_List.get_children()

var grab = false
var index = -1
func add_weapons():
	if PlayerControll.weapons.size() > 0:
		for i in range(min(PlayerControll.weapons.size(), weapons_list.size())):
			if weapons_list[i].weapon_type == -1:
				print(i)
				print(PlayerControll.weapons[i])
				weapons_list[i].set_weapon_type(PlayerControll.weapons[i])
			

func _process(_delta):
	add_weapons()

func _input(_event):
	if _event.is_action_pressed("ui_select_weapons") and visible and not Global.stop:
		index += 1
		if index > weapons_list.size()-1:
			index = 0
		weapons_list[index].grab_focus()
		grab = true
	if _event.is_action_pressed("action_1") and grab:
		emit_signal("on_equip_weapon", weapons_list[index].weapon_type, 0)
	if _event.is_action_pressed("action_2") and grab:
		emit_signal("on_equip_weapon", weapons_list[index].weapon_type, 1)

