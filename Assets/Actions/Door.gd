extends KinematicBody2D

export(String, FILE, "*.tscn,*.scn") var target_scene


func _ready():
	add_to_group("Door")


func _on_Player_touchDoor():
	Global.doorName = name
	get_tree().change_scene(target_scene)

