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
	battle_unit_damage = 5
	battle_unit_hp = 300
	speed = 0.8
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
