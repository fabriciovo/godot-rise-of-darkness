extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var player = get_tree().current_scene.get_node("Player")
onready var agent = $NavigationAgent2D
var paths = []
var navigation_path = null
var velocity := Vector2.ZERO

func _ready():
	ID = name
	battle_unit_xp = 3
	battle_unit_max_hp = 9
	battle_unit_damage = 2
	battle_unit_hp = battle_unit_max_hp
	const_speed = 4
	speed = const_speed
	yield(get_tree(), "idle_frame")
	navigation_path = get_parent().get_node("Navigation_Path")

func _physics_process(delta):
	if player and navigation_path:
#		agent.set_target_location(player.global_position)
#		var direction := global_position.direction_to(agent.get_next_location())
#		var desired_velocity := direction * 10.0
#		var steering = (desired_velocity - velocity) * delta * 4.0
#		velocity += steering
		generate_path()
		navigate()
		velocity = move_and_slide(velocity)

func generate_path():
	paths = navigation_path.get_simple_path(global_position, player.global_position,false)
	print(paths)

func navigate():
	if paths.size() > 0:
		velocity = global_position.direction_to(paths[1]) * 4
		if global_position == paths[0]:
			paths.pop_front()
