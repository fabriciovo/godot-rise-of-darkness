extends Control

onready var quests_container = $Quests_Container
onready var quest_info = $Quest_Info

var quest_button = preload("res://Assets/UI/Quest/Quest_Button.tscn")

func set_quest():
	for quest_key in Global.QUESTS:
		var quest = Global.QUESTS[quest_key]
		if quest["Unlocked"]:
			var _temp = quest_button.instance()
			_temp.connect("focus_entered", self, "_on_quest_button_focus_entered", [quest])
			_temp.text = quest["Title"]
			quests_container.add_child(_temp)
	quests_container.get_children()[0].grab_focus()

func _on_quest_button_focus_entered(_quest):
	quest_info.bbcode_text = tr(_quest["Description"])
	if _quest["Has_Track"]:
		quest_info.bbcode_text += "\n" + _quest["Progress"] + " / " + _quest["Goal"]
