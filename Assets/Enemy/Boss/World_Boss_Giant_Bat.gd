extends Node2D

onready var player = get_tree().current_scene.get_node("Player")
onready var positions = $Positions.get_children()
var direction = Vector2.ZERO
var speed = 38
var attack = false
var player_target = null
var idle = false
var target = null
var rng = RandomNumberGenerator.new()

func _ready():
	find_new_position()

func _process(_delta):
	if not player: return
	if idle: return
	elif attack:
		attack_player(_delta)
	else: 
		move_to_another_point(_delta)

func attack_player(_delta):
	var target_position = player_target - direction
	position = position.move_toward(target_position, _delta * speed * 8)
	if position == target_position:
		idle = true
		attack = false
		$Idle_Timer.start(2)

func move_to_another_point(_delta):
	var target_position = target - direction
	position = position.move_toward(target_position, _delta * speed)

func find_new_position():
	rng.randomize()
	var value = rng.randi_range(0, 2)
	target = positions[value].position

func _on_Attack_Timer_timeout():
	set_attack_values()

func _on_Idle_Timer_timeout():
	find_new_position()
	idle = false
	var aggressive = rand_range(0,100)
	if aggressive >= 50:
		$Attack_Timer.wait_time = 1
	else:
		$Attack_Timer.wait_time = 6

func set_attack_values():
	if not player: return
	player_target = player.position
	direction = (player_target - position).normalized()
	attack = true
