extends Control

onready var quests_container = $Quests_Container
onready var quest_info = $Quest_Info

var quest_button = preload("res://Assets/UI/Quest/Quest_Button.tscn")

func _ready():
	print("aaa")
	for quest_key in Global.QUESTS:
		var quest = Global.QUESTS[quest_key]
		if quest["Unlocked"]:
			print("aaaa")
			var _temp = quest_button.instance()
			_temp.connect("focus_entered", self, "_on_quest_button_focus_entered", [quest])
			_temp.text = quest["Title"]
			quests_container.add_child(_temp)
			quest_info.bbcode_text = tr(quest["Description"])

func grab_focus():
	print( Global.QUESTS)
	quests_container.get_children()[0].grab_focus()

func add_quest(_quest_key):
	var _quest = Global.QUESTS[_quest_key]
	var _temp = quest_button.instance()
	_quest["Unlocked"] = true
	_temp.connect("focus_entered", self, "_on_quest_button_focus_entered", [_quest])
	_temp.text = _quest["Title"]
	quests_container.add_child(_temp)
	quest_info.bbcode_text = tr(_quest["Description"])

func _on_quest_button_focus_entered(_quest):
	quest_info.bbcode_text = tr(_quest["Description"])
	if _quest["Has_Track"]:
		quest_info.bbcode_text += "\n" + str(_quest["Progress"]) + " / " + str(_quest["Goal"])
