extends Node2D

onready var anim = $Necromancer_Animation
onready var text_box = $Layer/Text_Box

var entities_gate = preload("res://Assets/Enviroment/Entities_Gate.tscn")
var necromancer = preload("res://Assets/Enemy/World Enemy/World_Necromancer.tscn")
var skull_spawn = preload("res://Assets/Enviroment/Skulls.tscn")

var points = null
var start = false

func _ready():
	if Global.dark_mages.necromancer:
		queue_free()
	points = get_tree().current_scene.get_node_or_null("Points")

func _on_Start_Necromancer_Fight_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER) and not start:
		start = true
		Global.stop = true
		Global.cutscene = true
		anim.play("start_fight")

func spawn():
	var _inst_gate = entities_gate.instance()
	var _inst_necro = necromancer.instance()
	var _inst_skull_1 = skull_spawn.instance()
	var _inst_skull_2 = skull_spawn.instance()
	var _current_scene = get_tree().current_scene
	_inst_gate.position = points.get_node("Gate_Position").position
	_inst_necro.position = points.get_node("Necromancer_Position").position
	_inst_skull_1.position = points.get_node("Skull_Position_1").position
	_inst_skull_2.position = points.get_node("Skull_Position_2").position
	_current_scene.get_node("Entities").add_child(_inst_necro)
	_current_scene.add_child(_inst_skull_1)
	_current_scene.add_child(_inst_skull_2)
	_current_scene.add_child(_inst_gate)

func start_text_box():
	text_box.dialog_name = "necromancer.json"
	text_box.start_dialog()

func _on_Text_Box_on_end_dialog():
	Global.stop = false
	Global.cutscene = false
