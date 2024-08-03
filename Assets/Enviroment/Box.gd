class_name Static_Box extends StaticBody2D

var ID = ""
var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	ID = name
	add_to_group(Global.GROUPS.BOX)

func Destroy() :
	set_physics_process(false)
	$Sprite.visible = false
	var _temp_smoke = smoke.instance()
	_temp_smoke.global_position = global_position
	get_tree().current_scene.add_child(_temp_smoke)
	queue_free()


