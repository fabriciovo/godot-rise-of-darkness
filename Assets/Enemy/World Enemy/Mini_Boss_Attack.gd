extends KinematicBody2D

onready var obj = get_tree().current_scene.get_node("Player")
var speed = 1
var direction = Vector2.ZERO
var dir = Vector2.ZERO
func _ready():
	if obj != null:
		direction = obj.global_position
		dir = (direction - global_position).normalized()

func _process(delta):
	move_and_collide(dir * speed)

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
		body.damage(12)
	if body.is_in_group(Global.GROUPS.DOOR):
		queue_free()
