class_name Scrolling_End_Text extends Node2D

onready var parent = get_parent()

func _process(_delta):
	if(position.y <= -910):
		parent.speed = 0
		if (Input.is_action_just_released("start")):
			var _scene_instance = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
	else:
		position.y -= parent.speed * _delta
