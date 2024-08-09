extends Node2D

func _process(_delta):
	if Global.dark_mages.right_florest_dark_mage:
		queue_free()
