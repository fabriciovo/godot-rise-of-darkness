extends Node2D

var smoke = preload("res://Assets/Animations/smoke.tscn")
var skull = preload("res://Assets/Enemy/World Enemy/World_Skull.tscn")

func _ready():
	if Global.dark_mages.necromancer:
		queue_free()

func _on_Timer_timeout():
	var time = rand_range(2,6)
	$Timer.start(time)
	if Global.stop or Global.cutscene: return
	if Global.dark_mages.necromancer:
		queue_free()
	var _skull_inst = skull.instance()
	var _smoke_inst = smoke.instance()
	_skull_inst.position = position
	_smoke_inst.position = position
	get_tree().get_current_scene().add_child(_smoke_inst)
	get_tree().get_current_scene().add_child(_skull_inst)
