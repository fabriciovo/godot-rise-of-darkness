extends Area2D

export(int) var item

signal get_item

func _input(event):
	if event.is_action_pressed("action_1"):
		if get_overlapping_bodies().size() > 0:
			emit_signal("get_item")
			queue_free()



