extends Node2D

var ID = "Skulls"
var smoke = preload("res://Assets/Animations/smoke.tscn")
var skull = preload("res://Assets/Enemy/World Enemy/World_Skull.tscn")

func _on_Timer_timeout():
	var _skull_inst = skull.instance()
	var _smoke_inst = smoke.instance()
	var time = rand_range(1,5)
	_skull_inst.position = position
	_smoke_inst.position = position
	get_tree().get_current_scene().add_child(_smoke_inst)
	get_tree().get_current_scene().add_child(_skull_inst)
	$Timer.start(time)
