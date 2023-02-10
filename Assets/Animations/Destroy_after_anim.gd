extends Node2D


func _ready():
	if Global.stop == true:
		$Sprite.visible = false
		$AnimationPlayer.stop()

func start_animation():
	$Sprite.visible = true
	$AnimationPlayer.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
