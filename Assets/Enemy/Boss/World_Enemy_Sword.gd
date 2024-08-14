extends KinematicBody2D

var points_top = null
var points_bottom = null
var speed = 50

func _ready():
	var _current = get_tree().current_scene
	points_top = _current.get_node_or_null("Points/Top")
	points_bottom = _current.get_node_or_null("Points/Bottom")

func _find_new_position():
	pass

func _on_Timer_timeout():
	pass
