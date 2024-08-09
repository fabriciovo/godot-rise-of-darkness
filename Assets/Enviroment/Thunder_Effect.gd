extends CanvasLayer

signal on_start
signal on_end

onready var animation = $AnimationPlayer

var dark_florest_mage = preload("res://Assets/Enemy/World Enemy/World_Dark_Mage.tscn")

func start_left_florest_dark_mage():
	emit_signal("on_start")
	animation.play("thunder_mage_dark_florest")
	yield(animation,"animation_finished")
	SoundController.play_music(SoundController.MUSIC.cursed_voices)
	
func left_spawn_dark_mage():
	var _temp = dark_florest_mage.instance()
	var _current_scene = get_tree().current_scene
	var _entities_node = _current_scene.get_node("Entities")
	var _start_point = _current_scene.get_node("Points").get_node("start_point")
	_temp.global_position = _start_point.position
	_entities_node.add_child(_temp)

func play_thunder_effect():
	SoundController.play_effect(SoundController.EFFECTS.thunder)
