extends Node2D

var altar_node

func _ready():
	altar_node = get_parent().get_node("Altar")
	if Global.dark_mages.necromancer:
		altar_node.hit = true
	else:
		visible = false

func _process(_delta):
	if altar_node.hit:
		visible = true
