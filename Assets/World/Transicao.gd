extends Node2D


func _on_Player_change_scene(target_scene, door_name):
	Global.doorName = door_name
	get_tree().change_scene(target_scene)
