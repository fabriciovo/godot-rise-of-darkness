extends Node2D


func _ready():

	if Global.doorName:
		var door_node = find_node(Global.doorName)
		if door_node:
			$Player.global_position = door_node.global_position
	for m in get_node("Entities").get_children():
		for id in Global.dead_enemies.size():
			if m.ID == Global.dead_enemies[id]:
				m.queue_free()
				
		for id in Global.open_chests.size():
			if m.ID == Global.open_chests[id]:
				m.disable = true
				m.get_node("Sprite").frame = 0
				
		for id in Global.dead_objects.size():
			if m.ID == Global.dead_objects[id]:
				m.queue_free()

