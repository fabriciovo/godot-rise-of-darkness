extends Area2D

onready var anim = $Animation
onready var timer = $Timer
onready var chase_player_timer = $Chase_Player_Timer 

var points = []
var speed = 50
var rng = RandomNumberGenerator.new()
var target = null
var target_distance = Vector2.ZERO
var direction = Vector2.ZERO
var attacking = false

var battle_unit_xp = 50
var battle_unit_max_hp = 20000
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp

func _ready():
	points = get_tree().current_scene.get_node("Sword_Points/Movement").get_children() || []
	anim.play("intro")
	yield(anim,"animation_finished")
	Global.stop = false
	Global.cutscene = false
	timer.start(3)
	chase_player_timer.start(6)

func _process(_delta):
	if anim.playback_speed <= 1:
		print(anim.playback_speed)
		anim.playback_speed += 0.01 * _delta
		yield(get_tree().create_timer(1.0), "timeout")
	if not attacking:
		move_to_another_point(_delta)
	else: 
		chase_player(_delta)

func find_new_position():
	rng.randomize()
	var _points = []
	_points = get_tree().current_scene.get_node("Sword_Points/Movement").get_children()
	var _value = rng.randi_range(0, _points.size()-1)
	target = _points[_value].position

func chase_player(_delta):
	rng.randomize()
	target = get_tree().current_scene.get_node("Player").position
	speed = rng.randi_range(50, 120)
	attacking = false

func move_to_another_point(_delta):
	if target:
		position = position.move_toward(target, _delta * speed)

func _on_Timer_timeout():
	timer.start(6)
	if not attacking:
		find_new_position()

func move_to_point(_delta):
	var target_position = target - direction
	position = position.move_toward(target_position, _delta * speed)

func intro_end():
	anim.playback_speed = 0
	anim.play("anim")


func _on_Chase_Player_Timer_timeout():
	attacking = true
	rng.randomize()
	chase_player_timer.start(rng.randi_range(6, 17))


func _on_World_Enemy_Sword_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		_body.damage(battle_unit_damage)
