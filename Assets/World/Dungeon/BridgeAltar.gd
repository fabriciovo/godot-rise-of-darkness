extends Node2D

func _process(_delta):
	if Global.altar_hit:
		visible = true
