extends Sprite

func _ready():
	$AnimationPlayer.play("teleport")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
