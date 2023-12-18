extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var obj = get_tree().current_scene.get_node("Player")
onready var body_shape = $Body_Shape
var wakeup = false
var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir = Vector2.ZERO
var jump = false
func _ready():
	ID = name
	body_shape.disabled = true
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_hp = battle_unit_max_hp
	battle_unit_damage = 5
	const_speed = 90
	speed = const_speed
	randomize()
	direction.x = rand_range(-20, 20)
	direction.y = rand_range(-20, 20)
	$Sprite.visible = false


func _physics_process(delta):
	if not wakeup:
		$Area/Area_Shape.disabled = true
		set_physics_process(false)
	else: 
		set_physics_process(true)
		$Area/Area_Shape.disabled = false
		if not hit and jump:
			direction = move_and_collide(dir * speed * delta)
		knockback = knockback.move_toward(Vector2.ZERO, speed * delta)
		knockback = move_and_slide(knockback / 1.1)


func _on_Timer_timeout():
	hit = false
	timer.stop()
	$Enemy_Animation.play("slime_anim")

func _on_DetectArea_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not wakeup:
		body_shape.set_deferred("disabled", false)
		print(body_shape.disabled)
		$Sprite.visible = true
		$Enemy_Animation.play("slime_wakeup_anim")
		yield($Enemy_Animation,"animation_finished")
		wakeup = true
		$Enemy_Animation.play("slime_anim")
		$Jump_Timer.start(2)


func _on_Jump_Timer_timeout():
	dir = (obj.global_position - global_position).normalized()
	jump = !jump
	$Jump_Timer.start(2)
