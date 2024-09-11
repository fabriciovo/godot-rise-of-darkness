class_name Dark_Mage extends Node2D

onready var spr = $Sprite
onready var invincible_timer = $Invincible_Timer
onready var animation_damage = $Animation_Damage
onready var animation = $Animation_Dark_Mage
onready var text_box = $Text_Box_Layer/Text_Box

var dark_explosion = preload("res://Assets/Enemy/World Enemy/Dark_Mage_Explosion_Area.tscn")

var smoke = preload("res://Assets/Animations/smoke.tscn")
var damage_text = preload("res://Assets/UI/FloatText.tscn")
var projectile = preload("res://Assets/Enemy/World Enemy/enemy_projectile.tscn")
var points = []
var ID = name

var intro_dialog = ""
var dath_dialog = ""

var battle_unit_xp = 50
var battle_unit_max_hp = 75
var battle_unit_damage = 10
var battle_unit_hp = battle_unit_max_hp
var teleport_pos = Vector2.ZERO
var has_soul = false
var invincible = false
var hiding = false

func _ready():
	intro_dialog = "dark_mage.json"
	dath_dialog = "dark_mage_death.json"
	add_to_group(Global.GROUPS.ENEMY)
	animation.play("dark_mage_intro")
	points = get_tree().current_scene.get_node("Points").get_children()
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
	text_box.dialog_name = dath_dialog 
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
	hiding = true
	animation.play("hide")
	yield(animation, "animation_finished")
	global_position = get_random_pos()
	animation.play("show")
	yield(animation, "animation_finished")
	invincible = false
	hiding = false
	attack_player()
	if battle_unit_hp > 20:
		$Change_Position_Timer.start(3)
	else:
		$Change_Position_Timer.start(2)

func attack_player():
	if Global.stop: return
	animation.play("Attack")
	yield(animation, "animation_finished")

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
		$Change_Position_Timer.start(2)
	else:
		SoundController.play_music(SoundController.MUSIC.florest)
		Global.stop = false
		Global.cutscene = false
		Global.dark_mages.dark_mage = true
		PlayerControll.set_xp(battle_unit_xp)
		Global.QUESTS["DEFEAT_DARK_MAGES"].Progress+=1
		queue_free()

