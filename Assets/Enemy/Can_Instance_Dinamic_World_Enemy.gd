extends Area2D

var smoke = preload("res://Assets/Animations/smoke.tscn")
var inst
var can_spawn = false

func _ready():
	var _overlapping_bodies = get_overlapping_bodies()
	if _overlapping_bodies.size() > 0:
		print("if bodies")
		print(_overlapping_bodies.size())
		can_spawn = false
		queue_free()
	else:
		print("else bodies")
		print(_overlapping_bodies.size())
		can_spawn = true
		queue_free()

func spawn_enemy():
	var _inst_smoke = smoke.instance()
	_inst_smoke.position = position
	inst.position = position
	get_tree().current_scene.add_child(_inst_smoke)
	get_tree().current_scene.add_child(inst)
	queue_free()


func _on_Can_Instance_Dinamic_World_Enemy_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()

func _exit_tree():
	print("can_spawn")
	print(can_spawn)
	spawn_enemy()
