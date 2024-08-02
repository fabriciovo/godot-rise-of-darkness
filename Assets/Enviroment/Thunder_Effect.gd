extends CanvasLayer

signal on_start
signal on_end


var dark_florest_mage = preload("res://Assets/Enemy/World Enemy/World_Dark_Mage.tscn")
onready var animation = $AnimationPlayer

func florest_dark_mage():
	emit_signal("on_start")
	animation.play("thunder_mage_dark_florest")
	
func spawn_dark_mage():
	var _temp = dark_florest_mage.instance()
	var _current_scene = get_tree().current_scene
	var _entities_node = _current_scene.get_node("Entities")
	var _start_point = _current_scene.get_node("Points").get_node("start_point")
	_temp.global_position = _start_point.position
	_entities_node.add_child(_temp)
