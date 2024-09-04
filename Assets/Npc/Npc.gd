extends Node2D

var player = null
var dialog_name = ["wanny_dialog_start_quest.json", "wanny_dialog_during_quest.json", "wanny_quest_completed.json", "wanny_quest_completed.json", "wanny_quest_completed.json"]
var can_talk = true

func _ready():
	if Global.QUESTS["SOULS_QUEST"].Completed:
		Global.NPCS_QUEST_STEP_TRACK.Wanny = 4

func _input(_event):
	if not player: return
	if (_event.is_action_pressed("action_3") or _event.is_action_pressed("action_2") or _event.is_action_pressed("action_1")) and player != null and not Global.stop:
		trigger_dialog_box()

func _on_Input_Area_body_entered(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = body

func _on_Input_Area_body_exited(body):
	if body.is_in_group(Global.GROUPS.PLAYER):
		player = null

func trigger_dialog_box():
	if not can_talk: return
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Wanny
	can_talk = false
	Global.cutscene = true
	$Text_Box_Layer/Text_Box.dialog_name = dialog_name[quest_step]
	$Text_Box_Layer/Text_Box.start_dialog()

func _on_Text_Box_on_end_dialog():
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Wanny
	if quest_step == 0:
		Global.QUESTS["FIND_WANNY"].Completed = true
		Global.NPCS_QUEST_STEP_TRACK.Wanny+=1
		Ui.quests_panel.add_quest("SOULS_QUEST")
		$Text_Box_Layer/Text_Box.dialog_name = "get_relic_3.json"
		PlayerControll.set_relic_item(Global.RELICS.RING_OF_SOULS)
		player.set_item_texture(0, "relics")
		player.play_get_item_animation()
		var player_animator = player.get_node("PlayerAnimation")
		yield(player_animator, "animation_finished")
		$Text_Box_Layer/Text_Box.start_dialog()
		return
	elif quest_step == 1:
		pass
	elif quest_step == 2:
		pass
	elif quest_step == 4:
		PlayerControll.souls_quest_completed = true
	can_talk = true
	Global.stop = false
	Global.cutscene = false
