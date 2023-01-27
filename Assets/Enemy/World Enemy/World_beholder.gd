extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var obj = get_tree().current_scene.get_node("Player")

var ray = RayCast2D.new()

var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir_frame = 9
var telepor_dir = Vector2.ZERO
func _ready():
	$Enemy_Animation.stop(true)
	self.add_child(ray)
	ID = name
	battle_unit_xp = 20
	const_speed = 1
	speed = const_speed
	battle_unit_damage = 8
	battle_unit_max_hp = 30
	battle_unit_hp = battle_unit_max_hp
	battle_unit_type = "beholder"
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)

func _process(delta):
	if obj != null:
		ray_cast()

func _physics_process(delta):
	#TODO create hits mechanics
	$Sprite.frame = dir_frame
	if !hit:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
				direction = direction.bounce(collision.normal)
	knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
	knockback = move_and_slide(knockback) 

func init_ray_cast():
	 ray.connect("body_entered", self, "_on_ray_collision")

func ray_cast():
	ray.cast_to = obj.get_global_position()

func _on_Timer_timeout():
	hit = false
	timer.stop()

func change_sprite_dir():
	pass

func action():
	pass

func _on_Shoot_Timer_timeout():
	action()

func _on_ray_collision(body):
	# Handle the collision here
	print("Collision with body:", body)
