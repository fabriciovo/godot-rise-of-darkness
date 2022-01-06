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

