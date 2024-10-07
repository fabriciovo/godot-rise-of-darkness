extends Node2D

onready var text_box = $Text_Box_Layer/Text_Box
onready var phase_one_timer = $Phase_One
onready var thunder = $Thunder


var phase_one_wait_time = 60
var sword_spawn_points
var sword_boss = preload("res://Assets/Enemy/Boss/World_Enemy_Sword.tscn")
var flying_dragon = preload("res://Assets/Enviroment/Flying_Dragon.tscn")
var smoke = preload("res://Assets/Animations/smoke.tscn")

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
	SoundController.play_music(SoundController.MUSIC.cursed_voices)
	text_box.dialog_name = "dark_lord_intro.json"
	text_box.start_dialog()
	dark_lord.get_node("Animation_Dark_Mage").play("dark_mage_intro")

func _on_Text_Box_on_end_dialog():
	match phase:
		0:
			SoundController.play_music(SoundController.MUSIC.boss_phase_1)
			var _world_swords = get_tree().current_scene.get_node("World_Swords")
			for sword_pos in sword_spawn_points:
				var _sword_inst = sword_boss.instance()
				_sword_inst.position = sword_pos.position
				_world_swords.add_child(_sword_inst)
				phase_one_timer.start(phase_one_wait_time)
				hide_dark_lord()
		1:
			SoundController.play_music(SoundController.MUSIC.boss_phase_2)
			var _flying_dragon_inst = flying_dragon.instance()
			get_tree().current_scene.get_node("Canvas_Layer").add_child(_flying_dragon_inst)
			hide_dark_lord()
			Global.stop = false
			Global.cutscene = false
		2:
			SoundController.play_music(SoundController.MUSIC.boss_phase_3)
			dark_lord.start()
			Global.stop = false
			Global.cutscene = false
		3:
			Global.stop = false
			Global.cutscene = false
			queue_free_entities()
			dark_lord.Destroy()
			
			yield(get_tree().create_timer(3.0), "timeout")
			SoundController.play_music(SoundController.MUSIC.ending)
			var _scene_instance = get_tree().change_scene("res://Assets/EndGame/End_1.tscn")

func hide_dark_lord():
	dark_lord.get_node("Animation_Dark_Mage").play("hide")
	yield(dark_lord.get_node("Animation_Dark_Mage"), "animation_finished")
	dark_lord.visible = false

func _on_Phase_One_timeout():
	var world_swords = get_parent().find_node("World_Swords")
	world_swords.queue_free()
	Global.stop = true
	Global.cutscene = true
	phase += 1
	dark_lord.get_node("Animation_Dark_Mage").play_backwards("hide")
	dark_lord.visible = true
	yield(dark_lord.get_node("Animation_Dark_Mage"), "animation_finished")
	dark_lord.get_node("Animation_Dark_Mage").play("dark_mage_intro")
	text_box.dialog_name = "dark_lord_phase_one.json"
	text_box.start_dialog()

func dragon_death():
	yield(get_tree().create_timer(2), "timeout")
	dark_lord.visible = true
	dark_lord.get_node("Animation_Dark_Mage").play_backwards("hide")
	yield(dark_lord.get_node("Animation_Dark_Mage"), "animation_finished")
	dark_lord.get_node("Animation_Dark_Mage").play("dark_lord_angry")
	phase += 1
	text_box.dialog_name = "dark_lord_dragon_death.json"
	text_box.start_dialog()

func create_smoke():
	var _gate = get_parent().get_node("gate")
	var _smoke_1 = smoke.instance()
	var _smoke_2 = smoke.instance()
	_smoke_1.global_position = _gate.get_node("Sprite").global_position
	_smoke_2.global_position = _gate.get_node("Sprite2").global_position
	add_child(_smoke_1)
	add_child(_smoke_2)

func _on_Dark_Lord_start_ending():
	Global.stop = true
	Global.cutscene = true
	phase += 1
	thunder.play_dark_lord_death_anim()
	yield(thunder.animation, "animation_finished")
	text_box.dialog_name = "dark_lord_ending.json"
	text_box.start_dialog()

func queue_free_entities():
	var _nodes = get_tree().current_scene.get_children()
	for _node in _nodes:
		if "projectile" in _node.name:
			_node.queue_free()  
		if "Fire_Spirit" in _node.name:
			_node.Destroy() 
