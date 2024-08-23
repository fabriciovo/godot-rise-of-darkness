class_name Dark_Lord extends KinematicBody2D

onready var spr = $Sprite
onready var invincible_timer = $Invincible_Timer
onready var animation_damage = $Animation_Damage
onready var animation = $Animation_Dark_Mage
onready var text_box = $Text_Box_Layer/Text_Box

var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var fire_projectile = preload("res://Assets/Enemy/World Enemy/Fire_Mage_Projectile.tscn")
var points = []
var player
var battle_unit_xp = 50
var battle_unit_max_hp = 50
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var teleport_pos = Vector2.ZERO
var has_soul = false
var invincible = false
var hiding = false

func _ready():
	points = get_tree().current_scene.get_node("Dark_Lord_Positions").get_children()
	player = get_tree().current_scene.get_node("Player")
	battle_unit_xp = 50
	battle_unit_max_hp = 50
	battle_unit_damage = 10
	battle_unit_hp = battle_unit_max_hp

func attack_player():
	if Global.stop: return
	animation.play("Attack")
	yield(animation, "animation_finished")

func Destroy():
	SoundController.stop_music()
	spr.visible = false
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	SoundController.play_effect(SoundController.EFFECTS.positive_10)
	Global.cutscene = true
	text_box.dialog_name = "dark_mage_florest.json"
	text_box.start_dialog()

func create_projectile():
	if Global.stop: return
	for i in 4:
		print(i)
		var _temp_projectile = projectile.instance()
		_temp_projectile.position = position
		get_tree().current_scene.add_child(_temp_projectile)
		yield(get_tree().create_timer(0.4), "timeout")
	var _temp_fire_projectile = fire_projectile.instance()
	_temp_fire_projectile.position = position
	_temp_fire_projectile.direction = player.position.normalized()
	get_tree().current_scene.add_child(_temp_fire_projectile)

func _on_Text_Box_on_end_dialog():
	pass

func start():
	$Change_Position_Timer.start(1)

func get_random_pos():
	var _size = points.size()
	if _size == 0:
		return Vector2(0,0)
	else:
		var random_index = randi() % _size
		return points[random_index].position

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

func _on_Damage_Area_area_entered(area):
	if invincible or hiding: return
	if area.is_in_group(Global.GROUPS.SWORD):
		damage(PlayerControll.atk)
	if area.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
	if area.is_in_group(Global.GROUPS.ARROW_AREA):
		damage(PlayerControll.atk+1)

func change_postion():
	if Global.stop: return
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
	
func _on_Invincible_Timer_timeout():
	invincible = false
	spr.modulate = Color(1,1,1,1)

func _on_Change_Position_Timer_timeout():
	change_postion()
