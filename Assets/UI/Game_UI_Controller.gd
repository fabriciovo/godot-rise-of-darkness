extends Control

signal on_equip_weapon(weapon_type, slot)

onready var weapons_list = $Items/Weapons/Inventory_List/Weapons_Center_Container/Weapons_List.get_children()

var grab = false
var index = -1
func add_weapons():
	if PlayerControll.weapons.size() > 0:
		for i in range(min(weapons_list.size(), PlayerControll.weapons.size())):
			if weapons_list[i].weapon_type == -1:
				if weapons_list[i].weapon_type == PlayerControll.weapons[i]:
					i+=1
				weapons_list[i].set_weapon_type(PlayerControll.weapons[i])

func _process(_delta):
	focus_controller()
	add_weapons()

func _input(_event):
	if _event.is_action_pressed("weapons_right") and visible and not Global.stop:
		index += 1
		if index > weapons_list.size()-1:
			index = weapons_list.size()-1
		grab = true
		print(index)
	if _event.is_action_pressed("weapons_left") and visible and not Global.stop:
		index -= 1
		if index < 0:
			index = 0
		grab = true
	if _event.is_action_pressed("equip_weapon_1") and grab:
		emit_signal("on_equip_weapon", weapons_list[index].weapon_type, 0)
	if _event.is_action_pressed("equip_weapon_2") and grab:
		emit_signal("on_equip_weapon", weapons_list[index].weapon_type, 1)

func focus_controller():
	for i in weapons_list.size():
		if i == index:
			weapons_list[i].set_focus(true)
		else:
			weapons_list[i].set_focus(false)
