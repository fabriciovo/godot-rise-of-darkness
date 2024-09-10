extends World_Wood_Monster

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func _process(_delta):
	var screen_size = get_viewport().size
	return position.x < 0 or position.y < 0 or position.x > screen_size.x or position.y > screen_size.y

func configure_battle_unit():
	ID = name
	battle_unit_xp = 0
	battle_unit_max_hp = 5
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 500
	speed = const_speed
	has_soul = false

func _on_Shoot_Timer_timeout():
	$Shoot_Timer.start(rand_range(3.0, 10.0))
	direction = Vector2.ZERO
	if Global.stop: return

	for i in range(4):
		var projectile = projectile_scene.instance()
		
		projectile.direction = directions[i]
		projectile.position = position
		projectile.damage = battle_unit_damage + 1
		
		get_tree().current_scene.add_child(projectile)
		attacking = false
