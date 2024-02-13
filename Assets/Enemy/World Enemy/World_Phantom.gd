extends Node2D

export(NodePath) onready var points = get_node(points) as Node2D

var smoke = preload("res://Assets/Animations/smoke.tscn")
var damageText = preload("res://Assets/UI/FloatText.tscn")
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")

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


func _ready():
	add_to_group(Global.GROUPS.ENEMY)

func Destroy():
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	Global.dead_enemies.push_front(ID)
	queue_free()

func damage(damageValue):
	SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
	var text = damageText.instance()
	text.set_text(str(damageValue))
	add_child(text)
	battle_unit_hp -= damageValue
	$Animation_Player.play("damage_anim")
	yield($Animation_Player, "animation_finished")
	if battle_unit_hp <= 0:
		Destroy()

func change_postion():
	pass

func attack_player():
	pass

func _on_Attack_Timer_timeout():
	pass 


func _on_Change_Position_Timer_timeout():
	pass


