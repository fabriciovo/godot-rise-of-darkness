class_name Scrolling_Intro_Text extends Node2D

onready var parent = get_parent()

func _process(_delta):
	position.y -= parent.speed * _delta
	if(position.y <= -1200):
		var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
		if scene_instance == OK:
			Ui.game_start()
