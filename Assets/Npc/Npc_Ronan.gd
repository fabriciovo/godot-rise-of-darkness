extends Node2D

var player = null
var dialog_name = ["ronan_dialog_1.json", "ronan_dialog_1.json", "ronan_dialog_1.json"]
var can_talk = true
var sword_chest

var smoke = preload("res://Assets/Animations/smoke.tscn")

func _ready():
	sword_chest = get_tree().current_scene.get_node_or_null("Enviroment_Entities/Chest_Sword")
	if Global.NPCS_QUEST_STEP_TRACK.Ronan == 0:
		sword_chest.visible = false
	else: 
		sword_chest.visible = true

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
	start_dialog()

func _on_Text_Box_on_end_dialog():
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Ronan
	if quest_step == 0:
		Global.NPCS_QUEST_STEP_TRACK.Ronan+=1
	elif quest_step == 1:
		pass
	elif quest_step == 2:
		pass
	can_talk = true
	Global.stop = false
	Global.cutscene = false

func start_dialog():
	if not can_talk: return
	var quest_step = Global.NPCS_QUEST_STEP_TRACK.Ronan 
	can_talk = false
	Global.cutscene = true
	$Text_Box_Layer/Text_Box.dialog_name = dialog_name[quest_step]
	$Text_Box_Layer/Text_Box.start_dialog()


func _on_Area2D_body_entered(_body):
	if _body.is_in_group(Global.GROUPS.PLAYER):
		var _quest_step = Global.NPCS_QUEST_STEP_TRACK.Ronan
		if _quest_step == 0:
			var _temp_smoke = smoke.instance()
			_temp_smoke.global_position = sword_chest.global_position
			get_tree().current_scene.add_child(_temp_smoke)
			sword_chest.visible = true
			start_dialog()
