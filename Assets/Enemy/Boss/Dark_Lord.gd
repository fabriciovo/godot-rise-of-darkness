class_name Dark_Lord extends Dark_Mage

signal start_ending

var fire_projectile = preload("res://Assets/Enemy/World Enemy/Fire_Mage_Projectile.tscn")
var thunder = preload("res://Assets/Enviroment/Thunder.tscn")

var player

func _init():
	ID = "DARK_LORD"

func _ready():
	init()

func init():
	$Animation_Dark_Mage.stop()
	dark_portal_intro_anim()
	$Damage_Area.set_monitoring(false)
	points = get_tree().current_scene.get_node("Dark_Lord_Positions").get_children()
	player = get_tree().current_scene.get_node("Player")
	battle_unit_xp = 50
	battle_unit_max_hp = 150
	battle_unit_damage = 10
	battle_unit_hp = battle_unit_max_hp

func attack_player():
	if Global.stop: return
	animation.play("Attack")
	yield(animation, "animation_finished")

func Destroy():
	spr.visible = false
	var temp_smoke = smoke.instance()
	temp_smoke.position = position
	get_tree().current_scene.add_child(temp_smoke)
	SoundController.play_effect(SoundController.EFFECTS.enemy_die)
	queue_free()

func create_projectile():
	if Global.stop: return
	if battle_unit_hp <= 50:
		for i in 3:
			if Global.stop: return
			var _temp_dark_explosion = dark_explosion.instance()
			_temp_dark_explosion.position = player.position
			get_tree().current_scene.add_child(_temp_dark_explosion)
			yield(get_tree().create_timer(0.8), "timeout")
	else:
		for i in 4:
			if Global.stop: return
			var _temp_projectile = projectile.instance()
			_temp_projectile.position = position
			get_tree().current_scene.add_child(_temp_projectile)
			yield(get_tree().create_timer(0.4), "timeout")
		var _temp_fire_projectile = fire_projectile.instance()
		_temp_fire_projectile.position = position
		_temp_fire_projectile.direction = (player.position - position).normalized()
		get_tree().current_scene.add_child(_temp_fire_projectile)

func _on_Text_Box_on_end_dialog():
	pass

func start():
	$Damage_Area.set_monitoring(true)
	$Change_Position_Timer.start(1)

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
		emit_signal("start_ending")

func dark_portal_teleport():
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

func dark_portal_intro_anim():
	visible = false
	var _dark_portal_inst = dark_portal.instance()
	var _thunder_inst = thunder.instance()
	_dark_portal_inst.global_position = global_position
	_thunder_inst.get_node("AnimationPlayer").play("flash 2")
	get_parent().call_deferred("add_child", _thunder_inst)
	get_parent().call_deferred("add_child", _dark_portal_inst)
	yield(_dark_portal_inst.get_node("AnimationPlayer"), "animation_finished")
	visible = true

func dark_portal_anim():
	visible = false
	var _dark_portal_inst = dark_portal.instance()
	_dark_portal_inst.global_position = global_position
	get_parent().call_deferred("add_child", _dark_portal_inst)
	yield(_dark_portal_inst.get_node("AnimationPlayer"), "animation_finished")
	visible = true
