extends KinematicBody2D



var direction = Vector2.ZERO
var speed = 120
var frame = 0

func _ready():
	add_to_group("Arrow")
	$Arrow_Sprite.frame = frame

func _process(delta):
	move_and_slide(direction * speed)

func _physics_process(delta):
	var collider = get_slide_collision(0).collider
	if collider is Enviroment_Object:
		pass

func _on_Arrow_Area_body_entered(body):
	queue_free()
