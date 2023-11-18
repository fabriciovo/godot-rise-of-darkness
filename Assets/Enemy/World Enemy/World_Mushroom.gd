extends "res://Assets/Enemy/World Enemy/World_Enemy.gd"

onready var player = get_tree().current_scene.get_node("Player")
onready var navigation_path = get_tree().current_scene.get_node("Navigation")
onready var agent = $NavigationAgent2D
var paths: Array = []
var dead = false
var velocity := Vector2.ZERO
var chase_player = false
var direction = Vector2(rand_range(-5, 5),rand_range(-5, 5))
var chase_speed = 43
func _ready():
	ID = name
	battle_unit_xp = 3
	battle_unit_max_hp = 9
	battle_unit_damage = 2
	battle_unit_hp = battle_unit_max_hp
	const_speed = 4
	speed = const_speed
	

func _physics_process(delta):
	if not dead:
		if player and navigation_path and chase_player:
			generate_path()
			navigate()
		else: 
			var collision = move_and_collide(direction * speed * delta)
			if collision:
				direction = direction.bounce(collision.normal)
				velocity = direction
		velocity = move_and_slide(velocity)
		explosion()

func explosion():
	if $Enemy_Animation.get_current_animation() == "mushroom_start_explosion":
		yield($Enemy_Animation, "animation_finished")
		dead = true
		Disable()
		var temp_smoke = smoke.instance()
		add_child(temp_smoke)
		SoundController.play_effect(SoundController.EFFECTS.enemy_die)
		yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
		queue_free()


func generate_path():
		paths = navigation_path.get_simple_path(global_position, player.global_position,false)

func navigate():
	if paths.size() > 0:
		velocity = global_position.direction_to(paths[1]) * chase_speed
		if global_position == paths[0]:
			paths.pop_front()


func _on_Chase_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		$Enemy_Animation.play("mushroom_start_explosion")
		chase_player = true


func _on_Chase_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		chase_player = false
		direction = Vector2(rand_range(-5, 5),rand_range(-5, 5))
