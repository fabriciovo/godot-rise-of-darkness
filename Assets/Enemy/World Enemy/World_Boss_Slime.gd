class_name World_Boss_Slime extends World_Enemy_Slime

var slime = preload("res://Assets/Enemy/World Enemy/World_Slime.tscn")

func _ready():
	pass # Replace with function body.


func damage(_knockbackValue, _damageValue):
	SoundController.play_effect(SoundController.EFFECTS.enemy_hit)
	var _slime_instance = slime.instance()
	knockback = _knockbackValue
	var text = damageText.instance()
	text.set_text(str(_damageValue))
	add_child(text)
	hit = true
	battle_unit_hp -= _damageValue
	hits+=1
	$Enemy_Animation.play("damage_anim")
	yield($Enemy_Animation, "animation_finished")
	if battle_unit_hp <= 0:
		if quest_key != "":
			Global.QUESTS[quest_key].Progress += 1
		Destroy()
	else:
		timer.start(1)
	get_tree().root.add_child(_slime_instance)
	_slime_instance.wake_up()


func _on_DetectArea_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER) and not is_wake_up:
		wake_up()
