extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

const battle_unit_damage = 8
const battle_unit_hp = 30

var direction = Vector2.ZERO

func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	const_speed = 120
	speed = const_speed
	randomize()
	direction.x = rand_range(-speed, speed)
	$Attack_Timer.start(1)


func _physics_process(delta):
	if hp <= 4:
		var collision = move_and_collide(direction * delta)
		if collision:
			direction = direction.bounce(collision.normal)
	direction.y = 0
func _on_Timer_timeout():
	hit = false
	timer.stop()

func _on_Attack_Timer_timeout():
	$Attack_Timer.start(4)
	var attack = preload("res://Assets/Enemy/World Enemy/Mini_Boss_Attack.tscn").instance()
	attack.global_position = global_position
	get_tree().get_current_scene().add_child(attack)


func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		Knockback()

