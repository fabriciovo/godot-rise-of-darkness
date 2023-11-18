extends Node2D

var ID = name

func _input(event):
	if event.is_action_pressed("action_3"):
		if(PlayerControll.key > 0):
			PlayerControll.set_key(0)
			Global.key_gate.push_front(ID)

