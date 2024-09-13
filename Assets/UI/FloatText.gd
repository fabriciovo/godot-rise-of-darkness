extends Label
var speed = 51
var pos = Vector2.ZERO


func _process(delta):
	set_position(pos)
	pos.y -= speed * delta


func _on_Change_Speed_timeout():
	speed = 0

func _on_Timer_timeout():
	queue_free()
