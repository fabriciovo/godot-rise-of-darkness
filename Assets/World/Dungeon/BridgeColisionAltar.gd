extends StaticBody2D

var bridge

func _ready():
	bridge = get_parent()

func _process(_delta):
	if bridge.altar_node.hit:
		queue_free()
