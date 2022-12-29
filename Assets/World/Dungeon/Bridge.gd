extends Node2D

onready var boss = get_tree().current_scene.get_node("Entities/World_Mini_Boss")
func _process(delta):
	if not boss:
		visible = true
