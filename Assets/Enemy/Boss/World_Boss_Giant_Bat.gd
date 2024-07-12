extends Node2D
onready var player = get_tree().current_scene.get_node("Player")
onready var positions = $Positions.get_children()

var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")

var ID = name

var direction = Vector2.ZERO
var speed = 28
var attack = false
var player_target = null
var idle = false
var target = null
var rng = RandomNumberGenerator.new()
var battle_unit_xp = 100
var battle_unit_max_hp = 50
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var has_soul = false

func _init():
	if Global.player_movements <= 5:
		queue_free()

func _ready():
	add_to_group(Global.GROUPS.ENEMY)
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
	var value = rng.randi_range(0, positions.size()-1)
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

func Destroy():
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
		body.queue_free()
	if body.is_in_group(Global.GROUPS.BOMB):
		damage(PlayerControll.atk+5)


func _on_Area2D_area_entered(area):
	if area.is_in_group(Global.GROUPS.SWORD):
		damage(PlayerControll.atk)


func damage(damageValue):
		SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
		var text = damage_text.instance()
		text.set_text(str(damageValue))
		add_child(text)
		battle_unit_hp -= damageValue
		$Animation_Player.play("damage_anim")
		yield($Animation_Player, "animation_finished")
		$Animation_Player.play("Boss_Giant_Bat_Normal")
		if battle_unit_hp <= 0:
			Destroy()
