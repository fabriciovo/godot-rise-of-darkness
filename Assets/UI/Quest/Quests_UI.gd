extends Control

onready var quests_container = $Quests_Container
onready var quest_info = $Quest_Info

var quest_button = preload("res://Assets/UI/Quest/Quest_Button.tscn")
#TODO Refazer toda essa merda aqui q ficou uma bosta
func grab_focus():
	print( Global.QUESTS)
	print(quests_container)
	print(quests_container.get_children())
	for i in quests_container.get_children():
		print(i)
#		var quest_in_container = quests_container[i]
#		print(quest_in_container)
#		print(quest_in_container.quest)
#		quest_in_container.visible = Global.QUESTS[quest_in_container.quest].Unlocked
#	quests_container.get_children()[0].grab_focus()

func add_quest(_quest_key):
	var _quest = Global.QUESTS[_quest_key]
	var _temp = quest_button.instance()
	_quest["Unlocked"] = true
	_temp.connect("focus_entered", self, "_on_quest_button_focus_entered", [_quest])
	_temp.text = _quest["Title"]
	_temp.name = _quest["Title"]
	_temp.quest = _quest_key
	quests_container.add_child(_temp)
	quest_info.bbcode_text = tr(_quest["Description"])

func _on_quest_button_focus_entered(_quest):
	quest_info.bbcode_text = tr(_quest["Description"])
	if _quest["Has_Track"]:
		quest_info.bbcode_text += "\n" + str(_quest["Progress"]) + " / " + str(_quest["Goal"])
