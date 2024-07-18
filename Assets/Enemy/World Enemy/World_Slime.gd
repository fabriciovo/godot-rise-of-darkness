class_name World_Enemy_Slime extends World_Enemy

onready var player = get_tree().current_scene.get_node("Player")
var is_wake_up = false
var direction = Vector2(-20, 20)
var velocity = Vector2(20,20)
var dir = Vector2.ZERO
var jump = false

func _ready():
	ID = name
	$Body_Shape.disabled = true
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
	if not is_wake_up:
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
	if body.is_in_group(Global.GROUPS.PLAYER) and not is_wake_up:
		wake_up()

func wake_up():
	$Sprite.visible = true
	$Enemy_Animation.play("slime_wakeup_anim")
	yield($Enemy_Animation,"animation_finished")
	is_wake_up = true
	$Body_Shape.set_deferred("disabled", false)
	$Enemy_Animation.play("slime_anim")
	$Jump_Timer.start(0.1)
	

func _on_Jump_Timer_timeout():
	if not player: return
	dir = (player.global_position - global_position).normalized()
	jump = !jump
	$Jump_Timer.start(2)


func _on_Enable_Timer_timeout():
	$Area/Area_Shape.disabled = true
	Enable()
