extends GridContainer

var quest_tile = preload("res://Assets/UI/Quest_Tile.tscn")

func _ready():
	for quest_name in Global.QUESTS.keys():
		var quest_data = Global.QUESTS[quest_name]
		var new_quest_panel = quest_tile.instance()
		
		new_quest_panel.get_node("Locked_Panel/Title").text = quest_data["Title"]
		new_quest_panel.get_node("Locked_Panel/Description").text = quest_data["Description"]
		new_quest_panel.get_node("Locked_Panel/Reward").text = quest_data["Reward"]
		
		add_child(new_quest_panel)
