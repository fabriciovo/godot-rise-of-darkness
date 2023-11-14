extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 120
var frame = 0
var knockback_vector = Vector2.ZERO
func _ready():
	add_to_group(Global.GROUPS.ARROW)
	$Arrow_Sprite.frame = frame
	knockback_vector = direction

func _physics_process(delta):
	var collision = move_and_collide(direction.normalized() * speed * delta) 
	if collision:
		queue_free()

func _on_Arrow_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if body.is_in_group(Global.GROUPS.BOX):
		queue_free()
	if body.is_in_group(Global.GROUPS.MOVABLE):
		queue_free()
	if body.is_in_group(Global.GROUPS.ENEMY):
		queue_free()
	if body.is_in_group(Global.GROUPS.TILEMAP):
		queue_free()
	if body.is_in_group(Global.GROUPS.ARROW):
		queue_free()

