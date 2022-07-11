class_name Static_Box
extends StaticBody2D
var ID = ""
func _ready():
	ID = name
	add_to_group(Global.GROUPS.BOX)

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

func Destroy() :
	$Sprite.visible = false
	$Static_Shape.disabled = true
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()


