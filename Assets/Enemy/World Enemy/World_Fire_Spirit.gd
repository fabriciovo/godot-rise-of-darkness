extends World_Enemy

const PROJECTILE_PATH = "res://Assets/Enemy/World Enemy/Simple_Projectile.tscn"
var direction = Vector3.ZERO

func _ready():
	configure_battle_unit()
	randomize()

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
	var projectile_scene = preload(PROJECTILE_PATH)
	for i in range(3):
		var projectile = projectile_scene.instance()
		
		projectile.direction = last_direction
		projectile.position = position
		projectile.damage = battle_unit_damage + 1
		
		get_parent().add_child(projectile)
		attacking = false
