extends Node2D

func _ready():
	add_to_group(Global.GROUPS.STATIC)

func _process(_delta):
	if Global.dark_mages.dark_mage:
		queue_free()
