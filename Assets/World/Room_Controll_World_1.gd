extends Room_Controll

onready var animation_player = $AnimationPlayer

func _process(_delta):
	if Global.trigger_tutorial_animation:
		Global.trigger_tutorial_animation = false
		animation_player.play("tutorial_animation_start")
		yield(animation_player, "animation_finished")
		Ui.start_dialog("tutorial_0.json")
		Ui.get_dialog_yield()
#		animation_player.play("tutorial_animation_end")
#		yield(animation_player, "animation_finished")
#		Global.stop = false


func set_global_stop(value):
	Global.stop = true

func first_dialog():
	animation_player.stop(true)

	animation_player.play()
