extends Node2D

func _process(delta):
	if Global.altar_hit:
		visible = true
