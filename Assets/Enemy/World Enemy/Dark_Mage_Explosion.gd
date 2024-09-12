extends Area2D

func _on_Dark_Mage_Explosion_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		_body.damage(15)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explosion":
		queue_free()
