class_name World_Mushroom extends World_Enemy

onready var agent = $NavigationAgent2D
onready var mushroom_player = $Mushroom_Animation
onready var enemy_player = $Enemy_Animation

var player = null
var navigation_path = null

var paths: Array = []
var dead = false
var velocity := Vector2.ZERO
var chase_player = false
var direction = Vector2(rand_range(-5, 5),rand_range(-5, 5))
var chase_speed = 43
var has_to_stop = false
var current_anim_pos

func _ready():
	if get_tree().current_scene.has_node("Player"):
		player = get_tree().current_scene.get_node("Player")
	if get_tree().current_scene.has_node("Navigation"):
		navigation_path = get_tree().current_scene.get_node("Navigation")
	ID = name
	battle_unit_xp = 2
	battle_unit_max_hp = 4
	battle_unit_damage = 2
	battle_unit_hp = battle_unit_max_hp
	const_speed = 4
	speed = const_speed

func _process(_delta):
	if  player == null or navigation_path == null: return
	if Global.stop: 
		if not mushroom_player.is_playing(): return
		current_anim_pos = mushroom_player.current_animation_position
		mushroom_player.stop()
		if chase_player:
			has_to_stop = true
		return
	if dead:
		speed = 0
		if hits > 1:
			PlayerControll.set_xp(battle_unit_xp)
		yield(enemy_player, "animation_finished")
		var temp_smoke = smoke.instance()
		temp_smoke.global_position = global_position
		get_tree().get_current_scene().add_child(temp_smoke)
		SoundController.play_effect(SoundController.EFFECTS.enemy_die)
		queue_free()
	if has_to_stop and chase_player:
		has_to_stop = false
		mushroom_player.play("mushroom_start_explosion",-1,1,current_anim_pos)

func _physics_process(_delta):
	if Global.stop: return
	if player == null or navigation_path == null: return
	if dead: return
	if battle_unit_hp <= 0:
		dead = true
	if hit:
		explosion()
	if not dead and not hit:
		if player and navigation_path and chase_player:
			generate_path()
			navigate()
		else: 
			var collision = move_and_collide(direction * speed * _delta)
			if collision:
				direction = direction.bounce(collision.normal)
				velocity = direction
		velocity = move_and_slide(velocity)
		explosion_after_anim()

func explosion_after_anim():
	if mushroom_player.get_current_animation() == "mushroom_start_explosion":
		yield(mushroom_player, "animation_finished")
		explosion()

func generate_path():
	paths = navigation_path.get_simple_path(global_position, player.global_position,false)

func navigate():
	if paths.size() > 0:
		velocity = global_position.direction_to(paths[1]) * chase_speed
		if global_position == paths[0]:
			paths.pop_front()

func _on_Chase_Area_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		mushroom_player.play("mushroom_start_explosion")
		chase_player = true

func _on_Chase_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		speed = const_speed
		chase_player = false
		mushroom_player.play("mushroom_idle")
		velocity = Vector2.ZERO
		direction = Vector2(rand_range(-5, 5),rand_range(-5, 5))

func explosion():
	dead = true
	if hits > 1:
		PlayerControll.set_xp(battle_unit_xp)

func _on_Explosion_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		explosion()
