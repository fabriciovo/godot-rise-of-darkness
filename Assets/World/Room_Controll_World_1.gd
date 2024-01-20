extends Room_Controll

onready var animation_player = $AnimationPlayer

func _process(_delta):
	if Global.trigger_tutorial_animation:
		Global.stop = true
		animation_player.play("tutorial_animation_start")
		yield(animation_player, "animation_finished")
		#dialog stuff
		animation_player.play("tutorial_animation_end")
		yield(animation_player, "animation_finished")
		Global.stop = false
		Global.trigger_tutorial_animation = false
