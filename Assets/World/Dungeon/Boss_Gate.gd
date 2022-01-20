extends Node2D


func _ready():
	if Global.boss_gate:
		queue_free()


