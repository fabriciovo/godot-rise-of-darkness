extends KinematicBody2D

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()

func Destroy() :
	$Sprite.visible = false
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.BOMB):
		Destroy()
