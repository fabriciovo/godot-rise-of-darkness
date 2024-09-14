extends CanvasLayer

onready var game_ui = $Game_UI
onready var pause_options = $Pause_Options
onready var settings_panel = $UI_Containers/Settings
onready var player_info = $UI_Containers/Player_Info
onready var ui_containers = $UI_Containers.get_children()
onready var HP = $Game_UI/Items/Stats/HP
onready var MP = $Game_UI/Items/Stats/MP
onready var AP = $Game_UI/Items/Stats/AP
onready var item_1 = $Game_UI/Items/item1/weapon
onready var item_2 = $Game_UI/Items/item2/weapon
onready var key_label = $Game_UI/Items/Stats/key_label
onready var inventory_panel = $UI_Containers/Inventory
onready var quests_panel = $UI_Containers/Quests
onready var level_panel = $Game_UI/Level_Progress_Panel

onready var relics_container = $UI_Containers/Relics

var can_equip_sword = false
var can_equip_heal = false
var can_equip_bomb = false
var can_equip_bow = false

func _ready():
	game_ui.visible = false

func _input(_event):
	if not get_tree().get_current_scene(): return
	if (_event.is_action_pressed("ui_cancel") or _event.is_action_pressed("start")) and pause_options.visible:
		for i in ui_containers.size():
			ui_containers[i].visible = false
		if pause_options.visible:
			pause_options.get_node("Pause_Button_Container/Settings").grab_focus()
	if _event.is_action_pressed("start") and Global.in_game and not Global.dialog and not Global.cutscene:
		Ui.show_hidden_panels()


func _process(_delta):
	HP.text = tr("HP") + ": " + str(PlayerControll.hp)
	MP.text = tr("MP") + ": " + str(PlayerControll.mp)
	AP.text = tr("AP") + ": " + str(PlayerControll.ap)
	key_label.text = tr("KEY") + ": " + str(PlayerControll.key) 
	level_panel.get_node("Level").text = tr("LVL") + ": " + str(PlayerControll.level)
	level_panel.get_node("xp").text = tr("XP") + ": " + str(PlayerControll.xp) + "/" + str(PlayerControll.xp_to_level_up)
	if PlayerControll.equiped_item[0] < 0:
		item_1.visible = false
	else:
		item_1.visible = true
		item_1.frame = PlayerControll.equiped_item[0]
		item_1.frame_coords.y = 2
	if PlayerControll.equiped_item[1] < 0:
		item_2.visible = false
	else:
		item_2.visible = true
		item_2.frame = PlayerControll.equiped_item[1]
		item_2.frame_coords.y = 2
	if pause_options.visible and Global.cutscene:
		pause_options.visible = false

func _on_PlayerControl_hp_changed(value):
	HP.text = tr("HP") + ": " + str(value)

func _on_heal_gui_input(event):
	if can_equip_heal:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.HEAL, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.HEAL, 1)

func _on_bomb_gui_input(event):
	if can_equip_bomb:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOMB, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOMB, 1)

func _on_bow_gui_input(event):
	if can_equip_bow:
		if event.is_action_pressed("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOW, 0)
		if event.is_action_pressed("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.BOW, 1)

func _on_sword_gui_input(event):
	if can_equip_sword:
		if event.is_action_released("action_1"):
			PlayerControll.set_equiped_item(Global.WEAPONS.SWORD, 0)
		if event.is_action_released("action_2"):
			PlayerControll.set_equiped_item(Global.WEAPONS.SWORD, 1)

func set_equip(weapon, slot):
	if can_equip_sword:
		PlayerControll.set_equiped_item(weapon, slot)

func show_hidden_panels():
	pause_options.visible = not pause_options.visible
	Global.stop = pause_options.visible
	get_tree().paused = not get_tree().paused
	pause_options.get_node("Pause_Button_Container/Settings").grab_focus()
	pause_options.set_visible_options()

func open_settings():
	settings_panel.visible = !settings_panel.visible
	if settings_panel.visible:
		settings_panel.get_node("Sound Panel/SFX/SFX_Slider").get_focus_owner()
		settings_panel.get_node("Sound Panel/SFX/SFX_Slider").grab_focus()

func check_if_settings_is_open():
	if settings_panel.visible:
		settings_panel.visible = false

func open_player_info():
	player_info.visible = !player_info.visible
	if player_info.visible:
		player_info.get_node("Upgrades/Upgrade_Panel/upgrade hp").get_focus_owner()
		player_info.get_node("Upgrades/Upgrade_Panel/upgrade hp").grab_focus()

func game_start():
	game_ui.visible = true

func _on_Timer_timeout():
	$Title_Scene.visible = false
	$Title_Scene/Title_Panel/Title_Text.text = ""

func show_text(text):
	$Title_Scene.visible = true
	$Title_Scene/Timer.start(3)
	$Title_Scene/Title_Panel/Title_Text.text = text

func _on_Player_pressed():
	open_player_info()

func _on_Settings_pressed():
	open_settings()

func _on_Inventory_pressed():
	inventory_panel.visible = true
	inventory_panel.set_weapons()

func _on_Relics_pressed():
	relics_container.visible = true
	relics_container.set_relics()

func _on_Quests_pressed():
	quests_panel.visible = true
	quests_panel.grab_focus()

func _on_Save_pressed():
	Global.saveJSONData("player_data",PlayerControll.player_data())
	Global.save_world_data()
