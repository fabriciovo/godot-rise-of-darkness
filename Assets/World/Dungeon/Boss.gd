extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir_frame_open_eye = [9,10,11,12]
var dir_frame_closed_eye = [14,15,16,17,9]
var dir_frame = 0
var can_take_damage = false
var collision

func _ready():
	ID = name
	battle_unit_max_hp = 300
	battle_unit_xp = 1000
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 0.4
	speed = const_speed
	add_to_group(Global.GROUPS.ENEMY)

func _physics_process(delta):
	#TODO create hits mechanics
	if !hit:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			direction = direction.bounce(collision.normal)
		move_and_collide(direction * speed * delta)
	knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
	knockback = move_and_slide(knockback / 1.1) 

func show_shields():
	get_node("Boss_Shield").visible = true
	get_node("Boss_Shield2").visible = true

func action():
	var attack = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn").instance()
	attack.damage = 5
	attack.global_position = global_position
	attack.speed = 0.4
	get_tree().get_current_scene().add_child(attack)
	$Shoot_Timer.start(1.3)


func _on_Shoot_Timer_timeout():
	action()

func start_shooter():
	$Shoot_Timer.start(1.3)
