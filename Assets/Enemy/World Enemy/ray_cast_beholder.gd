extends RayCast2D

onready var obj = get_tree().current_scene.get_node("Player")

func _physics_process(delta):
	if is_colliding():
		obj = get_collider()
