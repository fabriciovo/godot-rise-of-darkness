extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"


var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir_frame = 9

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

func _physics_process(delta):
	#TODO create hits mechanics
	$Sprite.frame = dir_frame
	if !hit:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
				direction = direction.bounce(collision.normal)
	knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
	knockback = move_and_slide(knockback) 


func _on_Timer_timeout():
	hit = false
	timer.stop()
	#$Enemy_Animation.play("Beholder_anim")



func _on_Area_Left_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		speed = 0
		dir_frame = 10


func _on_Area_Left_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		dir_frame = 9
		speed = 0

