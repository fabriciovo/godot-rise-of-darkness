extends Node2D

var skull_effect = preload("res://Assets/Enemy/Spawn_Skull_Effect.tscn")

func _ready():
	if Global.dark_mages.necromancer:
		queue_free()

func _process(_delta):
	if Global.dark_mages.necromancer:
		queue_free()

func _on_Timer_timeout():
	var time = rand_range(2,6)
	$Timer.start(time)
	if Global.stop or Global.cutscene: return
	var _skull_inst = skull_effect.instance()
	_skull_inst.position = position
	get_tree().get_current_scene().add_child(_skull_inst)
