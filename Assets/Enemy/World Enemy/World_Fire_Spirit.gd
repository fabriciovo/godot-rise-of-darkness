extends World_Wood_Monster

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func configure_battle_unit():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 10
	speed = const_speed

func _on_Shoot_Timer_timeout():
	$Shoot_Timer.start(rand_range(3.0, 10.0))
	direction = Vector2.ZERO
	if Global.stop: return

	for i in range(4):
		var projectile = projectile_scene.instance()
		
		projectile.direction = directions[i]
		projectile.position = position
		projectile.damage = battle_unit_damage + 1
		
		get_parent().add_child(projectile)
		attacking = false
