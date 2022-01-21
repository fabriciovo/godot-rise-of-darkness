extends StaticBody2D



func _ready():
	if Global.altar_hit:
		queue_free()




func _on_Altar_altar_hit():
	queue_free()
