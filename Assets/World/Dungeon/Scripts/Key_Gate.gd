extends Node2D



func _ready():
	if Global.key_gate:
		queue_free()

func _on_Key_Gate_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		if(body.key > 0):
			body.key -= 1
			Global.key_gate = true

