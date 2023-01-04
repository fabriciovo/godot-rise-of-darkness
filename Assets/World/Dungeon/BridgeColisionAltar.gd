extends CollisionShape2D


func _process(delta):
	if Global.altar_hit:
		queue_free()
