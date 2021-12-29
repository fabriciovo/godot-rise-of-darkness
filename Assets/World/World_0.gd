extends Node2D


func _ready():
	if Global.doorName:
		print(Global.doorName)
		var door = find_node(Global.doorName)
		if door:
			$Player.global_position = door.global_position
