extends Node2D

onready var text_box = $Text_Box_Layer/Text_Box
onready var phase_one_timer = $Phase_One
var sword_spawn_points
var sword_boss = preload("res://Assets/Enemy/Boss/World_Enemy_Sword.tscn")
var dark_lord
var phase = 0
func _ready():
	Global.stop = true
	Global.cutscene = true
	sword_spawn_points = get_tree().current_scene.get_node("Sword_Points/Spawn_Points").get_children()
	dark_lord = get_tree().current_scene.get_node("Entities/Dark_Lord")

func start():
	Global.stop = false
	Global.cutscene = false

func intro_dialog():
	text_box.dialog_name = "you_need_a_weapon.json"
	text_box.start_dialog()

func _on_Text_Box_on_end_dialog():
	match phase:
		0:
			var _world_swords = get_tree().current_scene.get_node("World_Swords")
			for sword_pos in sword_spawn_points:
				var _sword_inst = sword_boss.instance()
				_sword_inst.position = sword_pos.position
				_world_swords.add_child(_sword_inst)
				phase_one_timer.start(60)
				hide_dark_lord()
		1:
			pass
		2:
			pass
		3:
			pass


func hide_dark_lord():
	dark_lord.get_node("Animation_Player").play("hide")
	
func _on_Phase_One_timeout():
	Global.stop = true
	Global.cutscene = true
	get_tree().current_scene.get_node("World_Swords").queue_free()	
	phase += 1
	dark_lord.get_node("Animation_Player").play_backwards("hide")
	text_box.dialog_name = "you_need_a_weapon.json"
	text_box.start_dialog()
