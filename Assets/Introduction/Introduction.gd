extends Control

onready var container = $Text_Container
var speed = 8

func _process(_delta):
	container.position.y -= speed * _delta

func _input(_event):
	if  _event.is_action_pressed("action_1"):
		speed = 20
	if _event.is_action_pressed("action_2"):
		speed = 8
	if _event.is_action_pressed("action_3"):
		speed = 0
	if _event.is_action_pressed("open_panel"):
		get_tree().change_scene("res://Assets/World/World_0.tscn")
