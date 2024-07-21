extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)

func _ready():
	battle_unit_xp = 1
	battle_unit_max_hp = 15
	battle_unit_hp = battle_unit_max_hp
	battle_unit_damage = 3
	const_speed = 200
	speed = const_speed
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)

func _physics_process(_delta):
	if !hit:
		var collision = move_and_collide(direction * _delta)
		if collision:
				direction = direction.bounce(collision.normal)
	knockback = knockback.move_toward(Vector2.ZERO, speed * _delta)
	knockback = move_and_slide(knockback) 
	
func _on_Timer_timeout():
	hit = false
	timer.stop()
	$Enemy_Animation.play("Skull_anim")

