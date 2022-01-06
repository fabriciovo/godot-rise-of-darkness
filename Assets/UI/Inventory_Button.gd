extends Button

export (int) var item

func _ready():
	disabled = true

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(get_local_mouse_position()):
			print(item)
			PlayerControll.set_equiped_item(item, 0)
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
		if get_rect().has_point(get_local_mouse_position()):
			PlayerControll.set_equiped_item(item, 1)
			print(item)
