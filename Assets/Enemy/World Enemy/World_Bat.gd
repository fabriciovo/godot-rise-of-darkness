extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"



onready var obj = get_tree().current_scene.get_node("Player")

func _ready():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_type = "bat"
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 10
	speed = const_speed

func _physics_process(delta):
	if obj == null: return
	if not hit:
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
	knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
	knockback = move_and_slide(knockback / 1.1)



func _on_Timer_timeout():
	timer.stop()
	hit = false
	speed = const_speed * hits
	$Enemy_Animation.play("Bat_anim")




