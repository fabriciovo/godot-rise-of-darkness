class_name World_Skeleton extends World_Enemy

onready var enemy_anim = $Enemy_Animation
onready var skeleton_enemy_anim = $Skeleton_Animation

const CHANGE_DIRECTION_INTERVAL = 1.0

var random_direction_timer = 0.0
var direction = Vector2.RIGHT
var dir = 0

func _ready():
	skeleton_enemy_anim.playback_speed = 0.4
	configure_battle_unit()
	initialize_movement_control()
	randomize()

func configure_battle_unit():
	ID = name
	battle_unit_xp = 10
	battle_unit_max_hp = 5
	battle_unit_damage = 3
	battle_unit_hp = battle_unit_max_hp
	const_speed = 200
	speed = const_speed

func initialize_movement_control():
	pick_random_direction()

func _physics_process(_delta):
	if battle_unit_hp <= 0: return
	update_random_direction_timer(_delta)
	move_enemy(_delta)

func update_random_direction_timer(_delta):
	random_direction_timer += _delta
	if random_direction_timer >= CHANGE_DIRECTION_INTERVAL:
		random_direction_timer = 0.0
		pick_random_direction()

func pick_random_direction():
	match randi() % 4:
		0:
			direction = Vector2.UP
			skeleton_enemy_anim.play("up")
			dir = 2
		1:
			direction = Vector2.DOWN
			skeleton_enemy_anim.play("down")
			dir = 0
		2:
			direction = Vector2.LEFT
			skeleton_enemy_anim.play("left")
			$Sprite.flip_h = true
			dir = 3
		3:
			direction = Vector2.RIGHT
			skeleton_enemy_anim.play("left")
			$Sprite.flip_h = false
			dir = 1

func move_enemy(_delta):
	var _dir = move_and_slide(direction * speed * _delta)
	if hit:
		knockback = knockback.move_toward(Vector2.ZERO, speed * _delta)
		knockback = move_and_slide(knockback / 1.1)


#func _on_Area_area_entered(area):
#	print("Area")
#	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
#		knockback = area.knockback_vector * 120
#		damage(knockback, 1)
#
#func _on_Area_body_entered(body):
#	pass
#
#func _on_Shield_Area_area_entered(area):
#	print("SDhield Area")
#	if area.is_in_group(Global.GROUPS.SWORD) and not hit:
#		knockback = area.knockback_vector * 120
#		damage(knockback,  0)
#	if area.is_in_group(Global.GROUPS.SHIELD) and not hit:
#		knockback = area.knockback_vector * 120
#		damage(knockback, 0)
