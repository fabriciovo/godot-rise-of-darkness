extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var obj = get_tree().current_scene.get_node("Player")

var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir_frame_open_eye = [9,10,11,12]
var dir_frame_closed_eye = [14,15,16,17,9]
var dir_frame = 0
var eye = false
var can_take_damage = false

func _ready():
	$Enemy_Animation.stop(true)
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
	if eye:
		$Area.set_process(false)
	else:
		$Area.set_process(true)

func _physics_process(delta):
	#TODO create hits mechanics
	sprite_dir()
	if !hit:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
				direction = direction.bounce(collision.normal)
	knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
	knockback = move_and_slide(knockback) 

func _on_Timer_timeout():
	hit = false
	timer.stop()

func _on_Shoot_Timer_timeout():
	action()

func action():
	var attack = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn").instance()
	attack.damage = 5
	attack.global_position = global_position
	attack.speed = 0.4
	get_tree().get_current_scene().add_child(attack)
	$Shoot_Timer.stop()
	$Eye_Timer.start(3)

func sprite_dir():
	if not eye:
		if speed > 0:
			dir_frame = 0
		elif speed < 0:
			dir_frame = 1
		$Sprite.frame = dir_frame_closed_eye[dir_frame]
	else:
		$Sprite.frame = dir_frame_open_eye[dir_frame]
	


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
