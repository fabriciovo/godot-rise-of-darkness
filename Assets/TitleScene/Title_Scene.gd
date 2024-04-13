class_name Title_Scene extends Control

var filePath = "user://player_data.json"
onready var start = $Pause_Button_Container/Start
onready var btn_load_game = $Pause_Button_Container/Load_Game
onready var settings_panel = $"/root/Ui/UI_Containers/Settings"

func _ready():
	TranslationServer.set_locale("pt")
	start.set_focus_mode(Control.FOCUS_ALL)
	start.grab_focus()
	SoundController.play_music(SoundController.MUSIC.title)
	check_file_existence()

func _input(_event):
	if _event.is_action_pressed("ui_cancel") and settings_panel.visible:
		settings_panel.visible = false
		start.grab_focus()

func check_file_existence():
	var file = File.new()
	if file.file_exists(filePath):
		btn_load_game.disabled = false
		btn_load_game.visible = true
	else:
		btn_load_game.disabled = true
		btn_load_game.visible = false

func _on_Button_pressed():
	var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	if scene_instance == OK:
		Ui.game_start()

func _on_Options_pressed():
	Ui.open_settings()

func _on_Load_Game_pressed():
	var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	if scene_instance == OK:
		PlayerControll.load_player_data(Global.loadJSONData("player_data"))
		Ui.game_start()

func _on_Quit_pressed():
	get_tree().quit()
