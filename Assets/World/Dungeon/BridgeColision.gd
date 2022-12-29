extends CollisionShape2D

onready var water = get_tree().current_scene.get_node("Enviroment/Water")
onready var boss = get_tree().current_scene.get_node("Entities/World_Mini_Boss")

func _process(delta):
	if not boss:
		water.get_node("BridgeColision").queue_free()
