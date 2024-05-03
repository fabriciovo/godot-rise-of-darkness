extends Control

onready var container = $Text_Container
var speed = 8

func _input(_event):
	if  _event.is_action_pressed("action_1"):
		speed = 100
	if _event.is_action_pressed("action_2"):
		speed = 8
	if _event.is_action_pressed("action_3"):
		speed = 0
	if _event.is_action_pressed("start"):
		go_to_world()

func go_to_world():
	var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	if scene_instance == OK:
		Ui.game_start()
