extends KinematicBody2D

export(String, FILE, "*.tscn,*.scn") var target_scene
export(String) var door_name

func _ready():
	add_to_group(Global.GROUPS.DOOR)




