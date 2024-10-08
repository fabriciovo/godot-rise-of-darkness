class_name Simple_Projectile extends Area2D


var speed = 40
var direction = Vector2.ZERO  
var damage = 5

func _ready():
	add_to_group(Global.GROUPS.ENEMY_PROJECTILES)
	if direction == Vector2.ZERO:
		direction = Vector2.RIGHT
	rotation = direction.angle()

func _physics_process(_delta):
	if Global.stop: return
	var velocity = direction * speed
	position += velocity * _delta
	if is_out_of_bounds():
		queue_free()

func _on_Simple_Projectile_body_entered(body):
	if body.is_in_group(Global.GROUPS.STATIC):
		queue_free()
	if body.is_in_group(Global.GROUPS.BOX):
		body.Destroy()
		queue_free()
	if body.is_in_group(Global.GROUPS.ARROW):
		body.queue_free()
		queue_free()

func is_out_of_bounds():
	var _screen_size = get_viewport().size
	return position.x < 0 or position.y < 0 or position.x > _screen_size.x or position.y > _screen_size.y


func _on_Simple_Projectile_area_entered(_area):
	if _area.is_in_group(Global.GROUPS.SHIELD):
		queue_free()

func _on_Timer_timeout():
	queue_free()
