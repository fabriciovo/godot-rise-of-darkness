extends CollisionShape2D


func _process(_delta):
	if Global.altar_hit:
		queue_free()
