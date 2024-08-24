extends Node2D

onready var text_box = $Text_Box_Layer/Text_Box
onready var phase_one_timer = $Phase_One
onready var thunder = $Thunder

var sword_spawn_points
var sword_boss = preload("res://Assets/Enemy/Boss/World_Enemy_Sword.tscn")
var flying_dragon = preload("res://Assets/Enviroment/Flying_Dragon.tscn")

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
				phase_one_timer.start(20)
				hide_dark_lord()
		1:
			var _flying_dragon_inst = flying_dragon.instance()
			get_tree().current_scene.add_child(_flying_dragon_inst)
			hide_dark_lord()
		2:
			dark_lord.get_node("Animation_Dark_Mage").play_backwards("hide")
			dark_lord.start()
			Global.stop = false
			Global.cutscene = false
		3:
			dark_lord.Destroy()
			var _scene_instance = get_tree().change_scene("res://Assets/EndGame/End_Game.tscn")

func hide_dark_lord():
	dark_lord.get_node("Animation_Dark_Mage").play("hide")

func _on_Phase_One_timeout():
	var world_swords = get_parent().find_node("World_Swords")
	world_swords.queue_free()
	Global.stop = true
	Global.cutscene = true
	phase += 1
	dark_lord.get_node("Animation_Dark_Mage").play_backwards("hide")
	text_box.dialog_name = "you_need_a_weapon.json"
	text_box.start_dialog()

func dragon_death():
	phase += 1
	text_box.dialog_name = "you_need_a_weapon.json"
	text_box.start_dialog()

func create_smoke():
	var _smoke_2 = get_parent().get_node("Smoke2")
	var _smoke_3 = get_parent().get_node("Smoke3")
	_smoke_2.start_animation()
	_smoke_3.start_animation()

func _on_Dark_Lord_start_ending():
	queue_free_entities()
	Global.stop = true
	Global.cutscene = true
	phase += 1
	thunder.play_dark_lord_death_anim()
	yield(thunder.animation, "animation_finished")
	text_box.dialog_name = "dark_mage_florest.json"
	text_box.start_dialog()

func queue_free_entities():
	var _nodes = get_tree().current_scene.get_children()
	for _node in _nodes:
		if "projectile" in _node.name:
			_node.queue_free()  
		if "Fire_Spirit" in _node.name:
			_node.queue_free() 
