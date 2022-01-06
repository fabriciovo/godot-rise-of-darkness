extends Area2D

export(String) var item
export(String) var ID

func _input(event):
	if event.is_action_pressed("action_1"):
		if get_overlapping_areas().size() > 0:
			get_item(item)
			queue_free()


func get_item(item):
	match item:
		"sword":
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		"heal":
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		"bow":
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		"bomb":
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
	
