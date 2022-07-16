extends Node2D



func _ready():
	if Global.key_gate:
		queue_free()


func _input(event):
	if event.is_action_pressed("action_3"):
		Global.key_gate = true
		queue_free()
