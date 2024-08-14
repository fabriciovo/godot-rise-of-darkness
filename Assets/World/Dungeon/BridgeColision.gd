extends CollisionShape2D

onready var entities = get_tree().current_scene.get_node("Entities")

func _process(_delta):
	if Global.dark_mages.necromancer:
		queue_free()
