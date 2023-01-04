extends Node2D

func _process(delta):
	var boss = get_tree().current_scene.get_node("Entities/World_Mini_Boss")
	if not boss:
		visible = true
