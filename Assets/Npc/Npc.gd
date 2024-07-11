extends Node2D

var nearPlayer = false

func _input(_event):
	if not nearPlayer: return
	if (_event.is_action_pressed("action_3") or _event.is_action_pressed("action_1") or _event.is_action_pressed("action_2")) and nearPlayer and not Global.stop:
		trigger_dialog_box()

func _on_Input_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		nearPlayer = true


func _on_Input_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		nearPlayer = false

func trigger_dialog_box():
	Global.stop = true
	$Text_Box_Layer/Text_Box.dialog_name = "you_need_a_weapon.json"
	$Text_Box_Layer/Text_Box.start_dialog()


func _on_Text_Box_on_end_dialog():
	Global.stop = false
