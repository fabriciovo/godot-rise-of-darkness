extends Node



func _ready():
	for m in get_node("Monsters").get_children():
		for id in Global.dead_enemies.size():
			if m.ID == Global.dead_enemies[id]:
				m.queue_free()
			
	if Global.doorName:
		var door_node = find_node(Global.doorName)
		print(door_node)
		if door_node:
			$Player.global_position = door_node.global_position

