extends Label

var pos = Vector2.ZERO


func _on_Timer_timeout():
	queue_free()

func _process(delta):
	set_position(pos)
	pos.y -= 51 * delta
