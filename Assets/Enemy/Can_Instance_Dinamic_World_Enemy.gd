extends Area2D

var smoke = preload("res://Assets/Animations/smoke.tscn")
var can_spawn = true
var inst

##TODO maybe a overlap here

func _process(_delta):
	if can_spawn:
		spawn_enemy()

func _on_Can_Instance_Dinamic_World_Enemy_body_entered(_body):
	if _body.is_in_group()
	queue_free()

func spawn_enemy():
	var _inst_smoke = smoke.instance()
	_inst_smoke.position = position
	inst.position = position
	get_tree().current_scene.add_child(_inst_smoke)
	get_tree().current_scene.add_child(inst)
	queue_free()
