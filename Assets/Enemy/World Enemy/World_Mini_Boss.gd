extends World_Enemy

var direction = Vector2.ZERO
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
func _ready():
	battle_unit_max_hp = 100
	battle_unit_damage = 0
	battle_unit_hp = battle_unit_max_hp 
	add_to_group(Global.GROUPS.ENEMY)
	const_speed = 50
	direction.x = const_speed
	$Attack_Timer.start(1)


func _physics_process(delta):
	var collision = move_and_collide(direction * delta)
	if collision:
		direction = direction.bounce(collision.normal)
	direction.y = 0
func _on_Timer_timeout():
	hit = false
	timer.stop()

func _on_Attack_Timer_timeout():
	$Attack_Timer.start(4)
	var attack = projectile.instance()
	attack.global_position = global_position
	get_tree().get_current_scene().add_child(attack)

func _on_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		damage(1, PlayerControll.atk+1)
		body.queue_free()

