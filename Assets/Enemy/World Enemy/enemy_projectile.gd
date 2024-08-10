extends KinematicBody2D

var damage = 12
var obj = null
var speed = 50
var direction = Vector2.ZERO
var dir = Vector2.ZERO

func _ready():
	if get_tree().current_scene.has_node("Player"):
		obj = get_tree().current_scene.get_node("Player")
	if obj == null: return
	add_to_group(Global.GROUPS.ENEMY_PROJECTILES)
	direction = obj.global_position
	dir = (direction - global_position).normalized()

func _process(_delta):
	if Global.stop: return
	var _dir = move_and_collide(dir * speed * _delta)

func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()
	if body.is_in_group(Global.GROUPS.PLAYER):
		queue_free()
	if body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if body.is_in_group(Global.GROUPS.BOX):
		body.Destroy()
		queue_free()
	if body.is_in_group(Global.GROUPS.ARROW):
		queue_free()
		body.queue_free()
	if body.is_in_group(Global.GROUPS.PLAYER):
		queue_free()
		body.damage(damage)
	if body.is_in_group(Global.GROUPS.DOOR):
		queue_free()
	if body.is_in_group(Global.GROUPS.SHIELD):
		queue_free()
