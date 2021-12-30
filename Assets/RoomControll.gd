extends Node

func _ready():
	print(PlayerControll.hp)
	if Global.doorName:
		print(Global.doorName)
		var door = find_node(Global.doorName)
		if door:
			$Player.global_position = door.global_position
