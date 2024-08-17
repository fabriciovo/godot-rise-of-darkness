extends Node2D

onready var text_box = $Text_Box_Layer/Text_Box
var sword_spawn_points
var sword_boss = preload("res://Assets/Enemy/Boss/World_Enemy_Sword.tscn")

var phase = 0
func _ready():
	Global.stop = true
	Global.cutscene = true
	sword_spawn_points = get_tree().current_scene.get_node("Sowrd_Points/Spawn_Points").get_children()

func start():
	Global.stop = false
	Global.cutscene = false

func intro_dialog():
	text_box.dialog_name = "you_need_a_weapon.json"
	text_box.start_dialog()

func _on_Text_Box_on_end_dialog():
	match phase:
		0:
			var _current_scene = get_tree().current_scene
			for sword_pos in sword_spawn_points:
				var _sword_inst = sword_boss.instance()
				_sword_inst.position = sword_pos.position
				_current_scene.add_child(_sword_inst)
		1:
			pass
		2:
			pass
		3:
			pass
