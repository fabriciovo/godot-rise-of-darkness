class_name World_Boss_Slime extends World_Enemy_Slime

var slime = preload("res://Assets/Enemy/World Enemy/World_Slime.tscn")

func _ready():
	battle_unit_max_hp = 50
	battle_unit_hp = battle_unit_max_hp


func damage(_knockback_value, _damage_value):
	SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
	knockback = _knockback_value
	hit = true
	hits += 1
	scale.x -= 0.10
	scale.y -= 0.10
	for i in hits:
		spawn_slime()
	if scale.x and scale.y <= 0.5:
		take_damage(_damage_value)
	else:
		scale.x -= 0.10
		scale.y -= 0.10
	$Enemy_Animation.play("damage_anim")
	yield($Enemy_Animation, "animation_finished")
	if battle_unit_hp <= 0:
		if quest_key != "":
			Global.QUESTS[quest_key].Progress += 1
		Destroy()
	else:
		timer.start(2)


func _on_DetectArea_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not is_wake_up:
		wake_up()

func take_damage(_damage_value):
	var text = damageText.instance()
	text.set_text(str(_damage_value))
	add_child(text)
	battle_unit_hp -= _damage_value

func spawn_slime():
	var _slime_instance = slime.instance()
	get_parent().call_deferred("add_child", _slime_instance)
	call_deferred("init_slime", _slime_instance)
	
func init_slime(_slime_instance):
	var _max = 300
	var _min = -300
	var _random_x = randf() * (_max - _min) + _min
	var _random_y = randf() * (_max - _min) + _min
	var _random_vector = Vector2(_random_x, _random_y)
	_slime_instance.is_wake_up = true
	_slime_instance.get_node("Area/Area_Shape").disabled = true
	_slime_instance.get_node("Body_Shape").set_deferred("disabled", false)
	_slime_instance.knockback = _random_vector
	_slime_instance.get_node("Sprite").scale.x = 1
	_slime_instance.get_node("Sprite").scale.y = 1
	_slime_instance.visible = true
	_slime_instance.get_node("Sprite").visible = true
	_slime_instance.get_node("Enemy_Animation").play("slime_anim")
	_slime_instance.global_position = global_position
	_slime_instance.get_node("Jump_Timer").start(0.5)
	_slime_instance.get_node("Enable_Timer").start(1)
