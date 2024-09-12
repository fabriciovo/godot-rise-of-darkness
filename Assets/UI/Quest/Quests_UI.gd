extends Control

onready var quests_container = $Quests_Container
onready var quest_info = $Quest_Info

var quest_button = preload("res://Assets/UI/Quest/Quest_Button.tscn")

func _ready():
	for _quest_key in Global.QUESTS:
		var _quest = Global.QUESTS[_quest_key]
		var _temp = quest_button.instance()
		_temp.connect("focus_entered", self, "_on_quest_button_focus_entered", [_quest_key])
		_temp.text = _quest["Title"]
		_temp.name = _quest["Title"]
		_temp.quest = _quest_key
		_temp.visible = _quest["Unlocked"]
		quests_container.add_child(_temp)
		quest_info.bbcode_text = tr(_quest["Description"])

func grab_focus():
	for _quest_button_child in quests_container.get_children():
		_quest_button_child.visible = Global.QUESTS[_quest_button_child.quest].Unlocked
	quests_container.get_children()[0].grab_focus()

func add_quest(_quest_key):
	Global.QUESTS[_quest_key].Unlocked = true

func _on_quest_button_focus_entered(_quest_key):
	var _quest = Global.QUESTS[_quest_key]
	quest_info.bbcode_text = tr(_quest["Title"]) + "\n" + tr(_quest["Description"])
	if _quest["Has_Track"]:
		quest_info.bbcode_text += "\n" + str(_quest["Progress"]) + " / " + str(_quest["Goal"])
		if _quest["Progress"] == _quest["Goal"]:
			_quest["Completed"] = true
	if _quest["Completed"]:
		quest_info.bbcode_text += "\n Completed"
