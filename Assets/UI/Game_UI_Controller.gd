extends Control

signal on_equip_weapon(weapon_type, slot)

onready var weapons_list = $Items/Weapons/Inventory_List/Weapons_Center_Container/Weapons_List.get_children()

var weapon_slot_index = -1
var grab = false
func add_weapon(_weapon):
	for weapon_slot in weapons_list:
		if weapon_slot.weapon_type == -1:
			weapon_slot.set_weapon_type(_weapon)
			return

func update_weapon_slot(_weapon):
	if weapon_slot_index != -1:
		for weapon in weapons_list:
			if weapon.weapon_type == _weapon:
				weapon.set_weapon_type(-1)
		weapons_list[weapon_slot_index].set_weapon_type(_weapon)

func _process(_delta):
	focus_controller()

func _input(_event):
	if _event.is_action_pressed("weapons_left") and visible:
		grab = false
		weapon_slot_index = -1
	if _event.is_action_pressed("weapons_right") and visible:
		grab = true
		weapon_slot_index += 1
		if weapon_slot_index > weapons_list.size()-1:
			weapon_slot_index = 0
	if _event.is_action_pressed("action_1") and grab and weapons_list[weapon_slot_index].weapon_type != -1:
		emit_signal("on_equip_weapon", weapons_list[weapon_slot_index].weapon_type, 0)
		grab= false
		PlayerControll.just_equipped = true
		weapons_list[weapon_slot_index].set_focus(false)
		weapon_slot_index =  -1
	if _event.is_action_pressed("action_2") and grab and weapons_list[weapon_slot_index].weapon_type != -1:
		emit_signal("on_equip_weapon", weapons_list[weapon_slot_index].weapon_type, 1)
		grab = false
		PlayerControll.just_equipped = true
		weapon_slot_index =  -1


func focus_controller():
	for i in weapons_list.size():
		if i == weapon_slot_index and grab:
			weapons_list[i].set_focus(true)
		else:
			weapons_list[i].set_focus(false)
