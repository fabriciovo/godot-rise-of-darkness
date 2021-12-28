extends KinematicBody2D


var speed = 10
onready var obj = get_parent().get_node("Player")

func _physics_process(delta):
	var dir = (obj.global_position - global_position).normalized()
	move_and_collide(dir * speed * delta)
