class_name World_Boss_Slime extends World_Enemy_Slime

var slime = preload("res://Assets/Enemy/World Enemy/World_Slime.tscn")

func _ready():
	battle_unit_max_hp = 50
	battle_unit_hp = battle_unit_max_hp


func damage(_knockback_value, _damage_value):
	SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
	knockback = _knockback_value
	hit = true
	hits+=1
	scale.x -= 0.10
	scale.y -= 0.10
	print(scale)
	print(hits)
	for i in hits:
		var max_x = 120
		var min_x = -120
		var max_y = 120
		var min_y = -120
		var random_x = randf() * (max_x - min_x) + min_x
		var random_y = randf() * (max_y - min_y) + min_y
		var random_vector = Vector2(random_x, random_y)
		var _slime_instance = slime.instance()
		_slime_instance.wake_up()
		_slime_instance.global_position = global_position
		#direction = move_and_collide(random_vector * 20)
		get_tree().get_root().call_deferred("add_child", _slime_instance)
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
