extends Node2D

var player = null
var dialog_name = ["ana_npc_start.json", "ana_npc_saved.json", "ana_heal_player.json"]
var can_talk = true

func _ready():
	var _quest_step = Global.NPCS_QUEST_STEP_TRACK.Ana
	$Text_Box_Layer/Text_Box.dialog_name = dialog_name[_quest_step]
	$Text_Box_Layer/Text_Box.start_dialog()

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
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Ana
	can_talk = false
	Global.cutscene = true
	$Text_Box_Layer/Text_Box.dialog_name = dialog_name[quest_step]
	$Text_Box_Layer/Text_Box.start_dialog()

func _on_Text_Box_on_end_dialog():
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Ana
	if quest_step == 0:
		Global.NPCS_QUEST_STEP_TRACK.Ana+=1
	elif quest_step == 1:
		Ui.quests_panel.add_quest("DEFEAT_DARK_MAGES")
		Global.NPCS_QUEST_STEP_TRACK.Ana+=1
	elif quest_step == 2:
		PlayerControll.set_maxhp()
	can_talk = true
	Global.stop = false
	Global.cutscene = false
