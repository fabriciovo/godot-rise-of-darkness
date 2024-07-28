class_name World_Bear extends World_Enemy

const CHANGE_DIRECTION_INTERVAL = 1.0
onready var raycast = $Detect_Player
onready var bear_anim = $Bear_Animation
onready var enemy_anim = $Enemy_Animation

var random_direction_timer = 0.0
var direction = Vector2.RIGHT
var direction_offset = Vector2.ZERO
var attacking = false
var wall_hit = false

func _ready():
	configure_battle_unit()
	initialize_movement_control()
	randomize()

func configure_battle_unit():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 30
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 300
	speed = const_speed

func initialize_movement_control():
	pick_random_direction()

func _physics_process(_delta):
	if wall_hit: return
	if battle_unit_hp <= 0: return
	update_random_direction_timer(_delta)
	move_enemy(_delta)

func update_random_direction_timer(_delta):
	random_direction_timer += _delta
	if random_direction_timer >= CHANGE_DIRECTION_INTERVAL:
		random_direction_timer = 0.0
		pick_random_direction()

	check_raycast_collision()

func pick_random_direction():
	if attacking or wall_hit: return
	match randi() % 4:
		0:
			bear_anim.play("bear_up")
			direction = Vector2.UP
			direction_offset = Vector2.DOWN
			$Area/Area_Shape.rotation_degrees = 90
		1:
			bear_anim.play("bear_down")
			direction = Vector2.DOWN
			direction_offset = Vector2.UP
			$Area/Area_Shape.rotation_degrees = 90
		2:
			bear_anim.play("bear_left")
			direction = Vector2.LEFT
			direction_offset = Vector2.RIGHT
			spr.flip_h = true
			$Area/Area_Shape.rotation_degrees = 0
		3:
			bear_anim.play("bear_left")
			direction = Vector2.RIGHT
			direction_offset = Vector2.LEFT
			spr.flip_h = false
			$Area/Area_Shape.rotation_degrees = 0
	if not raycast.enabled:
		raycast.enabled = true

func move_enemy(_delta):
	raycast.cast_to = direction * 67
	var _dir = move_and_slide(direction * speed * _delta)

func check_raycast_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group(Global.GROUPS.PLAYER) and not attacking: 
			on_player_detected()

func on_player_detected():
	attacking = true
	speed = 0
	bear_anim.playback_speed = 3
	$Rush_Timer.start(2)

func _on_Rush_Timer_timeout():
	speed = const_speed * 30

func on_wall_hit():
	raycast.enabled = false
	bear_anim.play("bear_wall_hit")
	bear_anim.playback_speed = 0.4
	wall_hit = true
	var offset
	if knockback == Vector2.ZERO:
		offset = direction_offset * 20
	else:
		offset = knockback * 1
	var remaining_time = 1
	while remaining_time > 0:
		var delta = get_process_delta_time()
		remaining_time -= delta
		var _dir = move_and_slide(offset)
		yield(get_tree().create_timer(delta), "timeout")
	yield(bear_anim, "animation_finished")
	wall_hit = false
	attacking = false
	speed = const_speed

func _on_Area_body_entered(_body):
	if attacking and not wall_hit:
		on_wall_hit()

func _on_Area_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
		damage(knockback,  PlayerControll.atk)
	if area.is_in_group(Global.GROUPS.SHIELD) and not hit and not wall_hit and attacking:
		knockback = area.knockback_vector * 10
		on_wall_hit()
