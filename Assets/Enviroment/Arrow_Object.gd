class_name Arrow extends Area2D

var direction = Vector2.ZERO
var speed = 120
var frame = 0
var knockback_vector = Vector2.ZERO

func _ready():
	add_to_group(Global.GROUPS.ARROW)
	$Arrow_Sprite.frame = frame
	knockback_vector = direction

func _process(_delta):
	if Global.stop: return
	var velocity = direction * speed
	position += velocity * _delta

func _on_Arrow_Object_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.DOOR):
		queue_free()
	if _body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if _body.is_in_group(Global.GROUPS.BOX):
		queue_free()
	if _body.is_in_group(Global.GROUPS.MOVABLE):
		queue_free()
	if _body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()
	if _body.is_in_group(Global.GROUPS.ARROW):
		queue_free()

