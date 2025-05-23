class_name Boss_Bat extends Area2D
onready var invincible_timer = $Invincible_Timer
onready var player = get_tree().current_scene.get_node("Player")
onready var positions = get_tree().current_scene.get_node("Bat_Positions").get_children()
var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")
var soul = preload("res://Assets/Enviroment/Soul.tscn")

var ID = name

var direction = Vector2.ZERO
var speed = 28
var attack = false
var player_target = null
var idle = false
var target = null
var battle_unit_xp = 100
var battle_unit_max_hp = 100
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var has_soul = true
var hit = false

func _ready():
	ID = name
	add_to_group(Global.GROUPS.ENEMY)
	find_new_position()
	$Idle_Timer.start(3)

func _process(_delta):
	if not player or not positions: return
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
		$Change_Pos_Timer.start(3)


func move_to_another_point(_delta):
	var target_position = target - direction
	position = position.move_toward(target_position, _delta * speed)

func find_new_position():
	randomize()
	var value = randi() % positions.size()
	target = positions[value].position

func _on_Attack_Timer_timeout():
	set_attack_values()

func _on_Idle_Timer_timeout():
	idle = true
	$Attack_Timer.start(3)

func set_attack_values():
	if not player: return
	idle = false
	player_target = player.position
	direction = (player_target - position).normalized()
	attack = true

func Destroy():
	speed = 0
	var _inst = smoke.instance()
	_inst.position = position
	get_tree().current_scene.add_child(_inst)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	queue_free()

func _on_Area2D_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		_body.damage(battle_unit_damage)
	if _body.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
		_body.queue_free()
	if _body.is_in_group(Global.GROUPS.BOMB):
		damage(PlayerControll.atk+5)


func _on_Area2D_area_entered(_area):
	if _area.is_in_group(Global.GROUPS.SWORD):
		damage(PlayerControll.atk)
	if _area.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
		_area.queue_free()

func damage(damageValue):
	if hit: return
	hit = true
	invincible_timer.start(1);
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

func create_soul():
	var temp_soul = soul.instance()
	temp_soul.ID = ID
	temp_soul.global_position = global_position
	get_parent().add_child(temp_soul)


func _on_Invincible_Timer_timeout():
	$Sprite.modulate = Color(1,1,1,1)
	hit = false


func _on_Change_Pos_Timer_timeout():
	idle = false
	find_new_position()
	$Idle_Timer.start(3)
