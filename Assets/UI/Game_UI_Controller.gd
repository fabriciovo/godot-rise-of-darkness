extends Control

onready var weapons_list = $Items/Weapons/Inventory_List/Weapons_Center_Container/Weapons_List.get_children()
var grab = false

func add_weapons():
	if PlayerControll.weapons.size() > 0:
		for i in range(min(PlayerControll.weapons.size(), weapons_list.size())):
			weapons_list[i].set_weapon_type(PlayerControll.weapons[i])

func _process(_delta):
	add_weapons()

func _input(_event):
	if _event.is_action_pressed("ui_select_weapons") and visible and not Global.stop:
		weapons_list[0].grab_focus()
		grab = true
		if _event.is_action_pressed("action_1"):
			pass
		if _event.is_action_pressed("action_2"):
			pass

func _unhandled_input(_event):
	if _event.is_action_pressed("action_1") and grab:
		release_current_focus()
	if _event.is_action_pressed("action_2") and grab :
		release_current_focus()

func release_current_focus():
	var current_focus_control = get_focus_owner()
	if current_focus_control:
		current_focus_control.release_focus()
		grab = false
