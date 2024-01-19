extends StaticBody2D

func _ready():
	if Global.altar_hit:
		queue_free()
