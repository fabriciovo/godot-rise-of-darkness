extends Node2D

var altar_node

func _ready():
	visible = false
	altar_node = get_parent().get_node("Altar")

func _process(_delta):
	if altar_node.hit:
		visible = true
