extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"



onready var obj = get_tree().current_scene.get_node("Player")
var radius = 33.0
var angle = 0.0

func _ready():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 10
	speed = const_speed
	quest_key = "BAT"


func _physics_process(delta):
	if obj == null: return
	chase_state(delta)
	knockback_state(delta)


func _on_Timer_timeout():
	timer.stop()
	hit = false
	speed = const_speed * hits
	$Enemy_Animation.play("Bat_anim")


func rotation_state():
	angle += 0.1 / 4
	var x = obj.position.x  + radius * cos(angle)
	var y = obj.position.y  + radius * sin(angle)
	position = Vector2(x, y)


func chase_state(_delta):
	if not hit:
		var dir = (obj.global_position - global_position).normalized()
		dir = move_and_collide(dir * speed * _delta)

func knockback_state(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, speed * _delta)
	knockback = move_and_slide(knockback / 1.1)
