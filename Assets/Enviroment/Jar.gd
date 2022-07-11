extends KinematicBody2D

var ID = ""

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

func _ready():
	ID = name
	add_to_group(Global.GROUPS.STATIC)

func Destroy() :
	$Sprite.visible = false
	$Body_Shape.visible = true
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.BOMB):
		Destroy()

