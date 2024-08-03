extends Control

onready var player_info = $Pause_Button_Container/Player
onready var inventory = $Pause_Button_Container/Inventory
onready var relics = $Pause_Button_Container/Relics
onready var quests = $Pause_Button_Container/Quests

func set_visible_options():
	if PlayerControll.level >= 2:
		player_info.visible = true
	if PlayerControll.inventory.size() >= 1:
		inventory.visible = true
	if PlayerControll.relics.size() >= 1:
		relics.visible = true
	if Global.trigger_tutorial_animation:
		quests.visible = true
	if Global.trigger_tutorial_animation:
		quests.visible = true
	if Global.quest_menu:
		quests.visible = true
