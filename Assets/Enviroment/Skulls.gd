extends Node2D

var ID = "Skulls"

func _on_Timer_timeout():
	var skull_object = preload("res://Assets/Enemy/World Enemy/World_Skull.tscn").instance()
	skull_object.global_position = global_position
	get_tree().get_current_scene().add_child(skull_object)
