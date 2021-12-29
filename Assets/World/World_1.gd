extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	if Global.doorName:
		print(Global.doorName)
		var door = find_node(Global.doorName)
		if door:
			$Player.global_position = door.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
