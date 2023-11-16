extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var agent = $NavigationAgent2D
onready var player = get_tree().current_scene.get_node("Player")

var velocity := Vector2.ZERO

func _ready():
	ID = name
	battle_unit_xp = 3
	battle_unit_max_hp = 9
	battle_unit_damage = 2
	battle_unit_hp = battle_unit_max_hp
	const_speed = 4
	speed = const_speed

func _physics_process(delta):
	if player:
		print(player.global_position)
		agent.set_target_location(player.global_position)
		var direction := global_position.direction_to(agent.get_next_location())
		var desired_velocity := direction * 10.0
		var steering = (desired_velocity - velocity) * delta * 4.0
		velocity += steering
		velocity = move_and_slide(velocity)
