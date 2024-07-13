extends Node2D

onready var entities = get_parent().get_node("Entities").get_children()

func _process(_delta):
	if get_parent().get_node("Entities").get_children().size() >= 1:
		$Stair.visible = false
		$Stair/CollisionShape2D.disabled = true
	else:
		$Stair.visible = true
		$Stair/CollisionShape2D.disabled = false

