extends Node2D

func _ready():
	if Global.stop:
		$Sprite.visible = false
		$AnimationPlayer.stop()

func start_animation():
	$Sprite.visible = true
	$AnimationPlayer.play()
	yield($AnimationPlayer, "animation_finished")

func _on_AnimationPlayer_animation_finished(_anim_name):
	visible = false
	queue_free()
