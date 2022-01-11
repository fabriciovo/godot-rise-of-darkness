extends KinematicBody2D

func _ready():
	add_to_group("Bomb")

func on_explosion():
	$Explosion_area.disabled = false

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
