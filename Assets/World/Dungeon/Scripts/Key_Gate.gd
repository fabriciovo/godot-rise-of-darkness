class_name Key_Gate extends Node2D

var ID = name
var player_in_gate = false

func _ready():
	ID = name

func _input(event):
	if event.is_action_pressed("action_3") and player_in_gate and !Global.stop:
		if (PlayerControll.key == 0):
			trigger_dialog_box()
		elif(PlayerControll.key > 0):
			PlayerControll.set_key(1)
			Global.key_gate.push_front(ID)
			queue_free()

func _on_Key_Gate_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player_in_gate = true


func _on_Key_Gate_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player_in_gate = false

func trigger_dialog_box():
	Global.stop = true
	$CanvasLayer/Control/Text_Box.dialog_name = "you_need_a_key.json"
	$CanvasLayer/Control/Text_Box.start_dialog()


func _on_Text_Box_on_end_dialog():
	Global.stop = false
