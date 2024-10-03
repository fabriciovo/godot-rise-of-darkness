class_name Dark_Mage extends Node2D

onready var spr = $Sprite
onready var invincible_timer = $Invincible_Timer
onready var animation_damage = $Animation_Damage
onready var animation = $Animation_Dark_Mage
onready var text_box = $Text_Box_Layer/Text_Box

var dark_explosion = preload("res://Assets/Enemy/World Enemy/Dark_Mage_Explosion_Area.tscn")
var dark_portal = preload("res://Assets/Enemy/Dark_Portal.tscn")
var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var points = []
var ID = name

var intro_dialog = ""
var death_dialog = ""

var battle_unit_xp = 50
var battle_unit_max_hp = 75
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var teleport_pos = Vector2.ZERO
var has_soul = false
var invincible = false
var hiding = false

func _ready():
	add_to_group(Global.GROUPS.ENEMY)
	animation.play("dark_mage_intro")
	points = get_tree().current_scene.get_node("Points").get_children()
	init_dialog()

func init_dialog():
	intro_dialog = "dark_mage.json"
	death_dialog = "dark_mage_death.json"
	text_box.dialog_name = intro_dialog
	text_box.start_dialog()

func Destroy():
	SoundController.stop_music()
	spr.visible = false
	var temp_smoke = smoke.instance()
	add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	yield(temp_smoke.get_node("AnimationPlayer"),"animation_finished")
	SoundController.play_effect(SoundController.EFFECTS.positive_10)
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	Global.cutscene = true
	text_box.dialog_name = death_dialog 
	text_box.start_dialog()
	

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
	if Global.stop: return
	if battle_unit_hp <= 0: return
	invincible = true
	var _current_scene = get_tree().current_scene
	var _random_pos = get_random_pos()
	var _dark_portal_instance = dark_portal.instance()
	var _dark_portal_start_instance = dark_portal.instance()
	_dark_portal_start_instance.global_position = global_position
	_dark_portal_instance.global_position = _random_pos
	_current_scene.add_child(_dark_portal_instance)
	_current_scene.add_child(_dark_portal_start_instance)
	yield(_dark_portal_instance.get_node("AnimationPlayer"), "animation_finished")
	global_position = _random_pos 
	invincible = false
	attack_player()
	$Change_Position_Timer.start(3)

func attack_player():
	if Global.stop: return
	animation.play("Attack")
	yield(animation, "animation_finished")

func _on_Change_Position_Timer_timeout():
	change_postion()

func get_random_pos():
	var _size = points.size()
	var _new_pos = Vector2(0, 0)
	if _size == 0:
		return _new_pos
	else:
		var random_index = randi() % _size
		_new_pos = points[random_index].position
	if _new_pos == global_position:
		return get_random_pos() 
	return _new_pos

func _on_Damage_Area_area_entered(area):
	if invincible or hiding: return
	if area.is_in_group(Global.GROUPS.SWORD):
		damage(PlayerControll.atk)
	if area.is_in_group(Global.GROUPS.ARROW):
		damage(PlayerControll.atk+1)
		area.queue_free()
	if area.is_in_group(Global.GROUPS.ARROW_AREA):
		damage(PlayerControll.atk+1)


func _on_Invincible_Timer_timeout():
	invincible = false
	spr.modulate = Color(1,1,1,1)


func create_projectile():
	if Global.stop: return
	var _current_scene = get_tree().current_scene
	if battle_unit_hp <= 20:
		var _temp_dark_explosion = dark_explosion.instance()
		_temp_dark_explosion.position = _current_scene.get_node("Player").position
		_current_scene.add_child(_temp_dark_explosion)
	else:
		var _temp_projectile = projectile.instance()
		_temp_projectile.position = position
		_current_scene.add_child(_temp_projectile)

func _on_Text_Box_on_end_dialog():
	if spr.visible:
		Global.stop = false
		Global.cutscene = false
		SoundController.transition_to_music(SoundController.MUSIC.invasion)
		change_postion()
	else:
		SoundController.play_music(SoundController.MUSIC.florest)
		Global.stop = false
		Global.cutscene = false
		Global.dark_mages.dark_mage = true
		PlayerControll.set_xp(battle_unit_xp)
		Global.QUESTS["DEFEAT_DARK_MAGES"].Progress+=1
		queue_free()

