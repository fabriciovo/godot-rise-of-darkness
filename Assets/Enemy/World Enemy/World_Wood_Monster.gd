class_name World_Wood_Monster extends World_Enemy

const CHANGE_DIRECTION_INTERVAL = 1.0
const PROJECTILE_PATH = "res://Assets/Enemy/World Enemy/Simple_Projectile.tscn"

var random_direction_timer = 0.0
var direction = Vector2.RIGHT
var last_direction = Vector2.ZERO
var attacking = false
var dir = 0

var projectile_scene = preload(PROJECTILE_PATH)

func _ready():
	configure_battle_unit()
	initialize_movement_control()
	randomize()

func configure_battle_unit():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 10
	speed = const_speed

func initialize_movement_control():
	$Shoot_Timer.start(rand_range(3.0, 10.0))
	pick_random_direction()

func _physics_process(_delta):
	if battle_unit_hp <= 0: return
	update_random_direction_timer(_delta)
	move_enemy()

func update_random_direction_timer(_delta):
	random_direction_timer += _delta
	if random_direction_timer >= CHANGE_DIRECTION_INTERVAL:
		random_direction_timer = 0.0
		pick_random_direction()

func pick_random_direction():
	if attacking or hit: return
	match randi() % 4:
		0:
			direction = Vector2.UP
			$Enemy_Animation.play("wood_up")
			dir = 2
		1:
			direction = Vector2.DOWN
			$Enemy_Animation.play("wood_down")
			dir = 0
		2:
			direction = Vector2.LEFT
			$Enemy_Animation.play("wood_left")
			$Sprite.flip_h = true
			dir = 3
		3:
			direction = Vector2.RIGHT
			$Enemy_Animation.play("wood_left")
			$Sprite.flip_h = false
			dir = 1
			
		_:
			attacking = true

func move_enemy():
	var _dir = move_and_slide(direction * speed)


func _on_Shoot_Timer_timeout():
	$Shoot_Timer.start(rand_range(3.0, 10.0))
	if Global.stop: return
	$Enemy_Animation.stop()
	$Sprite.frame = dir
	var projectile = projectile_scene.instance()
	
	last_direction = direction
	direction = Vector2.ZERO
	
	projectile.direction = last_direction
	projectile.position = position
	projectile.damage = battle_unit_damage + 1
	
	get_parent().add_child(projectile)
	attacking = false
