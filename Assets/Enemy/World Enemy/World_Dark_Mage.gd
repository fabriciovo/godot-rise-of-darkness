class_name Dark_Mage extends Node2D

export(NodePath) onready var point

onready var spr = $Sprite
onready var invincible_timer = $Invincible_Timer
onready var animation_damage = $Animation_Damage
onready var animation = $Animation_Dark_Mage
var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var points = []
var ID = name

var battle_unit_xp = 100
var battle_unit_max_hp = 50
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var teleport_pos = Vector2.ZERO
var has_soul = false
var invincible = false
var hiding = false

func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	global_position = get_random_pos()
	$Change_Position_Timer.start(3)
	point = get_node(point)
	if point:
		points = point.get_children()

func Destroy():
	spr.visible = false
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	queue_free()

func damage(damageValue):
	invincible = true
	SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
	var text = damage_text.instance()
	text.set_text(str(damageValue))
	add_child(text)
	battle_unit_hp -= damageValue
	animation_damage.play("damage_anim")
	yield(animation_damage, "animation_finished")
	invincible_timer.start(1)
	if battle_unit_hp <= 0:
		Destroy()

func change_postion():
	if battle_unit_hp <= 0: return
	invincible = true
	hiding = true
	animation.play("hide")
	yield(animation, "animation_finished")
	global_position = get_random_pos()
	animation.play("show")
	yield(animation, "animation_finished")
	invincible = false
	hiding = false
	attack_player()
	$Change_Position_Timer.start(3)

func attack_player():
	if battle_unit_hp > 10:
		animation.play("Attack")
		yield(animation, "animation_finished")
	else:
		pass

func _on_Change_Position_Timer_timeout():
	change_postion()

func get_random_pos():
	var _size = points.size()
	if _size == 0:
		return Vector2(0,0)
	else:
		var random_index = randi() % _size
		return points[random_index].position

func _on_Damage_Area_area_entered(area):
	if invincible or hiding: return
	if area.is_in_group(Global.GROUPS.SWORD):
		damage(PlayerControll.atk)
	if area.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
	if area.is_in_group(Global.GROUPS.ARROW_AREA):
		damage(PlayerControll.atk+1)


func _on_Invincible_Timer_timeout():
	invincible = false
	spr.modulate = Color(1,1,1,1)


func create_projectile():
	var _temp_projectile = projectile.instance()
	_temp_projectile.position = position
	get_tree().current_scene.add_child(_temp_projectile)
