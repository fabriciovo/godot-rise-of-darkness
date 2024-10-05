class_name Enemy_Projectile extends Area2D

var damage = 12
var obj = null
var speed = 50
var direction = Vector2.ZERO
var dir = Vector2.ZERO

func _ready():
	add_to_group(Global.GROUPS.ENEMY_PROJECTILES)
	if get_tree().current_scene.has_node("Player"):
		obj = get_tree().current_scene.get_node("Player")
	if obj == null: return
	direction = obj.global_position
	dir = (direction - global_position).normalized()

func _process(_delta):
	if Global.stop: return
	var velocity = dir * speed
	position += velocity * _delta

func _on_Enemy_Projectile_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()
	if _body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if _body.is_in_group(Global.GROUPS.BOX):
		_body.Destroy()
		queue_free()
	if _body.is_in_group(Global.GROUPS.ARROW):
		queue_free()
		_body.queue_free()
	if _body.is_in_group(Global.GROUPS.DOOR):
		queue_free()
