extends Node2D

var ID = name
var player_in_gate = false

func _process(_delta):
	print(player_in_gate)

func _input(event):
	if event.is_action_pressed("action_3") and player_in_gate:
		if(PlayerControll.key > 0):
			PlayerControll.set_key(1)
			Global.key_gate.push_front(ID)
			queue_free()

func _on_Key_Gate_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player_in_gate = true


func _on_Key_Gate_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player_in_gate = false

