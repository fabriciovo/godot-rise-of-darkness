extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

const battle_unit_damage = 8
const battle_unit_hp = 30
const battle_unit_type = "beholder"
var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)

func _ready():
	const_speed = 200
	speed = const_speed
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)

func _physics_process(delta):
	if hp <= 4:
		if !hit:
			var collision = move_and_collide(direction * delta)
			if collision:
					direction = direction.bounce(collision.normal)
		knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
		knockback = move_and_slide(knockback) 
	

func _on_Timer_timeout():
	hit = false
	timer.stop()
	$Enemy_Animation.play("Beholder_anim")

