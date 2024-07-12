extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var obj = get_tree().current_scene.get_node("Player")

var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var eye = false
var can_take_damage = false
var frame_open_eye = 9
var frame_closed_eye = 14
func _ready():
	$Enemy_Animation.stop(true)
	ID = name
	battle_unit_xp = 20
	const_speed = 3
	speed = const_speed
	battle_unit_damage = 8
	battle_unit_max_hp = 30
	battle_unit_hp = battle_unit_max_hp
	randomize()
	direction.x = rand_range(-5, 5)
	direction.y = rand_range(-5, 5)

func _physics_process(delta):
	eye_sprite()
	if !hit:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			direction = direction.bounce(collision.normal)
	knockback = knockback.move_toward(Vector2.ZERO, speed  * delta)
	knockback = move_and_slide(knockback / 1.1) 

func damage(knockbackValue, damageValue):
	if !eye:
		damageValue = 0
	knockback = knockbackValue
	var text = damage_text.instance()
	text.set_text(str(damageValue))
	add_child(text)
	hit = true
	battle_unit_hp -= damageValue
	hits+=1
	$Enemy_Animation.play("damage_anim")
	yield($Enemy_Animation, "animation_finished")
	if battle_unit_hp <= 0:
		Destroy()
	else:
		timer.start(1)

func _on_Timer_timeout():
	hit = false
	timer.stop()

func _on_Shoot_Timer_timeout():
	action()

func eye_sprite():
	if not eye:
		$Sprite.frame = frame_closed_eye
	else:
		$Sprite.frame = frame_open_eye

func action():
	var attack = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn").instance()
	attack.damage = 5
	attack.global_position = global_position
	attack.speed = 0.4
	get_tree().get_current_scene().add_child(attack)
	$Shoot_Timer.stop()
	$Eye_Timer.start(3)

func _on_Player_Detect_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		speed = 0
		eye = true
		$Shoot_Timer.start(1)

func _on_Player_Detect_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		speed = const_speed
		eye = false
		$Shoot_Timer.stop()
		$Eye_Timer.stop()

func _on_Eye_Timer_timeout():
	eye = false
