extends Node2D

export(int) var item

signal get_item(item)

func _input(event):
	if event.is_action_pressed("action_1"):
		playerGetItem()


func playerGetItem():
	emit_signal("get_item", item)
	queue_free()
