extends Control

onready var quests_container = $Quests_Container

var quest_button = preload("res://Assets/UI/Quest/Quest_Button.tscn")

func set_quest():
	for quest_key in Global.QUESTS:
		var quest = Global.QUESTS[quest_key]
		if quest["Unlocked"]:
			var _temp = quest_button.instance()
			_temp.connect("pressed", self, "_on_quest_button_pressed", [quest])
			_temp.text = quest["Title"]
			quests_container.add_child(_temp)
	quests_container.get_children()[0].grab_focus()

func set_quest_info(quest):
	pass

func _on_quest_button_pressed(quest):
	print("Quest button pressed for quest: ", quest)
	set_quest_info(quest)
