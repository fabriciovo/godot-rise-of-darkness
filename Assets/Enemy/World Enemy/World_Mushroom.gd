extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var player = get_tree().current_scene.get_node("Player")
onready var agent = $NavigationAgent2D
var paths: Array = []
var navigation_path = null
var velocity := Vector2.ZERO
var chase_player = false
var direction = Vector2(rand_range(-5, 5),rand_range(-5, 5))

func _ready():
	ID = name
	battle_unit_xp = 3
	battle_unit_max_hp = 9
	battle_unit_damage = 2
	battle_unit_hp = battle_unit_max_hp
	const_speed = 4
	speed = const_speed
	yield(get_tree(), "idle_frame")
	navigation_path = get_parent().get_parent().get_node("Navigation")

func _physics_process(delta):
	if player and navigation_path and chase_player:
		generate_path()
		navigate()
	else: 
		velocity = direction * 2
	velocity = move_and_slide(velocity)

func generate_path():
		paths = navigation_path.get_simple_path(global_position, player.global_position,false)

func navigate():
	if paths.size() > 0:
		velocity = global_position.direction_to(paths[1]) * 10
		if global_position == paths[0]:
			paths.pop_front()


func _on_Chase_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		chase_player = true


func _on_Chase_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		chase_player = false
