extends Sprite


func _on_AnimationPlayer_animation_finished(_anim_name):
	$AnimationPlayer.stop()
	visible = false
