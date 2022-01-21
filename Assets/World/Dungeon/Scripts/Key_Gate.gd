extends Node2D



func _ready():
	if Global.key_gate:
		queue_free()
