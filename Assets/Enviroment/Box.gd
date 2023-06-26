class_name Static_Box
extends StaticBody2D
var ID = ""
func _ready():
	ID = name
	add_to_group(Global.GROUPS.BOX)

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

func Destroy() :
	set_physics_process(false)
	$Sprite.visible = false
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()


