extends Node2D

var explosion = preload("res://Assets/Enemy/World Enemy/Dark_Mage_Explosion.tscn")

func _process(_delta):
	rotation_degrees -= 0.3
	if Global.dark_mages.dark_mage:
		queue_free()


func _on_AnimationPlayer_animation_finished(_anim_name):
	if _anim_name == "dark_explosion":
		var _current_scene = get_tree().current_scene
		var _temp = explosion.instance()
		_temp.position = position
		_current_scene.add_child(_temp)
		_current_scene.start_shake(10, 0.5)
		queue_free()
