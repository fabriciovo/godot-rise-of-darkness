extends Control

func start_dialog():
	$Text_Box.dialog_name = "tutorial_0.json"
	$Text_Box.start_dialog()

func _on_Text_Box_on_end_dialog():
	$AnimationPlayer.play("tutorial_1_anim")

func reset_global_state():
	Global.stop = false
