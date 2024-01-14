extends GridContainer

var quest_tile = preload("res://Assets/UI/Quest_Tile.tscn")

func _ready():
	for quest_name in Global.QUESTS.keys():
		var quest_data = Global.QUESTS[quest_name]
		var new_quest_panel = quest_tile.instance()
		new_quest_panel.quest_key = quest_name
		new_quest_panel.get_node("Locked_Panel/Container/Title").text = quest_data["Title"]
		if quest_data["Unlocked"]:
			new_quest_panel.get_node("Locked_Panel/Container/Description").text = quest_data["Description"]
		else:
			var progress = str(quest_data["Progress"])
			var goal = str(quest_data["Goal"])
			var description_text = ""
			description_text = "progress: " + progress + " / " + goal
			new_quest_panel.get_node("Locked_Panel/Container/Reward").text = quest_data["Reward"]
			new_quest_panel.get_node("Locked_Panel/Container/Description").text = description_text
		add_child(new_quest_panel)

