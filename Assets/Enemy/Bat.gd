extends KinematicBody2D

export (String) var ID

onready var obj = get_parent().get_parent().get_node("Player")
onready var timer = $Timer
var speed = 10
var knockback = Vector2.ZERO
var direction = Vector2(-20, 20)
var velocity=Vector2(20,20)
var hp = 1
var hit = false



func _ready():
	$Bat_Animation.play("Bat_anim")
	add_to_group("Enemy")
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)


func _physics_process(delta):
	
	
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback) 
	
#	var collision = move_and_collide(direction * delta)
#	if collision:
#		direction = direction.bounce(collision.normal)
		
	if obj and not hit:
		var dir = (obj.global_position - global_position).normalized()
		move_and_collide(dir * speed * delta)
		



func _on_Body_area_entered(area):
	if area.name == "ActionArea":
		knockback = area.knockback_vector * 90
		hit = true
		timer.start(1)
		



func _on_Timer_timeout():
	timer.stop()
	hp+=1
	speed = speed * hp
	hit = false

