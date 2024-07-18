extends CollisionShape2D

onready var entities = get_tree().current_scene.get_node("Entities")

func _process(_delta):
	if entities.get_children().size() == 0:
		queue_free()
