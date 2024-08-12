extends Node2D

onready var entities = get_parent().get_node("Entities")

func _ready():
	add_to_group(Global.GROUPS.STATIC)

func _process(_delta):
	check_entities()

func check_entities():
	if entities:
		if entities.get_children().size() == 0:
			queue_free()
