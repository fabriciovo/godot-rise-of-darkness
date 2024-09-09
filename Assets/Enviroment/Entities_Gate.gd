extends StaticBody2D

onready var sprite_list = $Sprites.get_children()
onready var entities = get_parent().get_node("Entities")

var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	add_to_group(Global.GROUPS.STATIC)
	spawn_gates()

func _process(_delta):
	check_entities()

func spawn_gates():
	for spr in sprite_list:
		var _temp_smoke = smoke.instance()
		spr.visible = true
		_temp_smoke.position = spr.position
		add_child(_temp_smoke)

func check_entities():
	if entities and entities.get_child_count() > 0:
		var only_souls = true
		for child in entities.get_children():
			if  child.is_in_group(Global.GROUPS.ENEMY):
				only_souls = false
				break
		if only_souls:
			queue_free()
	elif entities.get_child_count() == 0:
		queue_free()
