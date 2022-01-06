extends Button

signal input(value)

func _ready():
	disabled = true

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == 0 and event.pressed:
			Check_input()

func Check_input():
	if Input.is_action_just_pressed('action_1'):
		emit_signal("input", 0)
	if Input.is_action_just_pressed('action_2'):
		emit_signal("input", 1)
