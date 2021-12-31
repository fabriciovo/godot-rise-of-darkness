extends Node2D


func _ready():
	print(Global.doorName)
	if Global.doorName:
		var door_node = find_node(Global.doorName)
		print(door_node)
		if door_node:
			$Player.global_position = door_node.global_position
