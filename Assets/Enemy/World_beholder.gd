extends KinematicBody2D

export (String) var ID
onready var timer = $Timer
const frame = 9

const battle_unit_damage = 8
const battle_unit_hp = 50
var speed = 10
var knockback = Vector2.ZERO
var direction = Vector2(-20, 20)
var velocity=Vector2(20,20)
var hp = 1
var hit = false



func _ready():
	$Beholder_Animation.play("Beholder_anim")
	add_to_group("Enemy")
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback) 
	var collision = move_and_collide(direction * delta)
	if collision:
		direction = direction.bounce(collision.normal)
	

func _on_Body_area_entered(area):
	if area.name == "ActionArea":
		knockback = area.knockback_vector * 120
		hit = true
		$Beholder_Animation.play("damage_anim")
		if hp > 3:
			Global.dead_enemies.push_front(ID)
			queue_free()
		else:
			timer.start(1)
		

func _on_Timer_timeout():
	timer.stop()
	hp+=1
	speed = speed * hp
	hit = false
	$Beholder_Animation.play("Beholder_anim")

