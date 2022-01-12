extends Area2D

export(int) var item
export(String) var ID

func _input(event):
	if event.is_action_pressed("action_1"):
		if get_overlapping_areas().size() > 0:
			get_item(item)



func get_item(item):
	$Sprite.frame = 0
	match item:
		0:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		1:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		2:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		3:
			PlayerControll.set_item(item)
			Global.dead_enemies.push_front(ID)
			print(item)
		4:
			PlayerControll.key += 1
			Global.dead_enemies.push_front(ID)
	print(PlayerControll.items)


