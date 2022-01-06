extends StaticBody2D

var smoke = preload("res://Assets/Animations/smoke.tscn").instance()


func _ready():
	add_to_group("Stone")

func Destroy() :
	$Sprite.visible = false
	add_child(smoke)
	yield(smoke.get_node("AnimationPlayer"),"animation_finished")
	queue_free()


