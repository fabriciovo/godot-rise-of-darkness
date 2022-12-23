extends KinematicBody2D

onready var obj = get_parent().get_node("Player")
var speed = 100
var direction = Vector2.ZERO
func _ready():
	if obj != null:
		direction = obj.global_position

func _physics_process(delta):
	var dir = (direction - global_position).normalized()
	move_and_collide(dir * speed * delta)
	
	if global_position == dir:
		queue_free()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()
	if body.is_in_group(Global.GROUPS.PLAYER):
		queue_free()
	if body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if body.is_in_group(Global.GROUPS.ARROW):
		queue_free()
		body.queue_free()
	if body.is_in_group(Global.GROUPS.PLAYER):
		queue_free()
		body.damage()
