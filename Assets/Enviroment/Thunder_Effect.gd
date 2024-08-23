extends CanvasLayer

onready var animation = $AnimationPlayer

var dark_florest_mage = preload("res://Assets/Enemy/World Enemy/World_Dark_Mage.tscn")
var fire_mage  = preload("res://Assets/Enemy/World Enemy/World_Fire_Mage.tscn")
var mage_name = ""

func start_florest_dark_mage():
	animation.play("thunder_mage_dark_florest")
	yield(animation,"animation_finished")
	SoundController.play_music(SoundController.MUSIC.cursed_voices)



func spawn_dark_mage():
	match mage_name:
		"left_dark_mage":
			spawn_left_dark_mage()
		"right_dark_mage": 
			spawn_right_dark_mage()
		_:
			return
		

func spawn_right_dark_mage():
	var _temp = dark_florest_mage.instance()
	var _current_scene = get_tree().current_scene
	var _entities_node = _current_scene.get_node("Entities")
	var _start_point = _current_scene.get_node("Points").get_node("start_point")
	_temp.global_position = _start_point.position
	_entities_node.add_child(_temp)

func spawn_left_dark_mage():
	var _temp = fire_mage.instance()
	var _current_scene = get_tree().current_scene
	var _entities_node = _current_scene.get_node("Entities")
	var _start_point = _current_scene.get_node("Start_Point")
	_temp.global_position = _start_point.position
	_entities_node.add_child(_temp)

func play_thunder_effect():
	SoundController.play_effect(SoundController.EFFECTS.thunder)

func play_dark_lord_death_anim():
	SoundController.stop_music()
	animation.play("dark_lord_death")
	
