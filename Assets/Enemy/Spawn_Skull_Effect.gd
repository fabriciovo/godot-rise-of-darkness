extends Sprite

var skull = preload("res://Assets/Enemy/World Enemy/World_Skull.tscn")
var smoke = preload("res://Assets/Animations/smoke.tscn")
var rotation_speed = 0;

func _ready():
	randomize()
	rotation_speed= rand_range(-3, 3)

func _process(_delta):
	rotation_degrees += rotation_speed


func _on_AnimationPlayer_animation_finished(_anim_name):
	if(_anim_name == "anim"):
		var _skull_inst = skull.instance()
		var _smoke_inst = smoke.instance()
		_skull_inst.position = position
		_smoke_inst.position = position
		get_tree().current_scene.add_child(_skull_inst)
		get_tree().current_scene.add_child(_smoke_inst)
		queue_free()
