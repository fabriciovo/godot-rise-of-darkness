extends Node2D



func _ready():
	$AnimationPlayer.play("smoke_anim")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
