class_name Dark_Lord extends Dark_Mage



func _ready():
	battle_unit_xp = 50
	battle_unit_max_hp = 50
	battle_unit_damage = 10
	battle_unit_hp = battle_unit_max_hp
	points = get_tree().current_scene.get_node("Dark_Lord_Positions")


func attack_player():
	if Global.stop: return
	if battle_unit_hp > 10:
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
	Global.dead_enemies.push_front({"id": ID, "soul": has_soul})
	Global.cutscene = true
	text_box.dialog_name = "dark_mage_florest.json"
	text_box.start_dialog()


func _on_Text_Box_on_end_dialog():
	pass

func start():
	$Change_Position_Timer.start(1)
