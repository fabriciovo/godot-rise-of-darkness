extends Node2D

onready var sprs = [$Wall_1, $Wall_2]


var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	add_to_group(Global.GROUPS.STATIC)

func _process(_delta):
	if Global.dark_mages.dark_mage:
		queue_free()

func create_smoke():
	for spr in sprs:
		var _inst_smoke = smoke.instance()
		_inst_smoke.position = spr.position
		add_child(_inst_smoke)
