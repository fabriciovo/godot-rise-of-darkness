extends Node2D


func _ready():
	var _global_dark_mages = Global.dark_mages
	if _global_dark_mages.fire_mage and _global_dark_mages.dark_mage and _global_dark_mages.necromancer:
		queue_free()


