extends Node2D

func _ready():
	if Global.altar_hit:
		$Sprite.frame = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		Global.altar_hit = true
		$Sprite.frame = 0
		body.queue_free()
