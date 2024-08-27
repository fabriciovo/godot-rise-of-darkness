extends Node2D

var hit = false

func _on_Altar_Area_area_entered(_area):
	if _area.is_in_group(Global.GROUPS.ARROW):
		hit = true
		$Sprite.frame = 0
		_area.queue_free()
