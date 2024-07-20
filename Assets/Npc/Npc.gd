extends Node2D

var player = null
var dialog_name = ["wanny_dialog_start_quest.json", "wanny_dialog_during_quest.json", "wanny_dialog_complete_quest.json", "wanny_quest_completed.json"]
var quest_step = 0
var can_talk = true

func _input(_event):
	if not player: return
	if (_event.is_action_pressed("action_3") or _event.is_action_pressed("action_1") or _event.is_action_pressed("action_2")) and player != null and not Global.stop:
		trigger_dialog_box()

func _on_Input_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = body

func _on_Input_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null

func trigger_dialog_box():
	if not can_talk: return
	Global.stop = true
	$Text_Box_Layer/Text_Box.dialog_name = dialog_name[quest_step]
	$Text_Box_Layer/Text_Box.start_dialog()

func _on_Text_Box_on_end_dialog():
	can_talk = true
	if quest_step == 0:
		can_talk = false
		quest_step+=1
		$Text_Box_Layer/Text_Box.dialog_name = "get_ring_of_souls.json"
		PlayerControll.set_relic_item(Global.RELICS.RING_OF_SOULS)
		player.set_item_texture(0, "relics")
		player.play_get_item_animation()
		var player_animator = player.get_node("PlayerAnimation")
		yield(player_animator, "animation_finished")
		Global.stop = true
		$Text_Box_Layer/Text_Box.start_dialog()
	elif quest_step == 1:
		pass
	elif quest_step == 2:
		pass
	Global.stop = false
