extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

const battle_unit_damage = 3
const battle_unit_hp = 10
onready var obj = get_parent().get_node("Player")

func _ready():
	const_speed = 10
	speed = const_speed



func _physics_process(delta):
	if obj != null:
		if hp <= 4:
			if not hit:
				var dir = (obj.global_position - global_position).normalized()
				move_and_collide(dir * speed * delta)
			knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
			knockback = move_and_slide(knockback)


func _on_Timer_timeout():
	timer.stop()
	hit = false
	speed = const_speed * hp
	$Enemy_Animation.play("Bat_anim")




