extends Control
var filePath = "user://player_data.json"
onready var start = $Button_Container/Start
onready var btn_load_game = $Button_Container/Load_Game
func _ready():
	start.set_focus_mode(Control.FOCUS_ALL)
	start.grab_focus()
	SoundController.play_music(SoundController.MUSIC.title)
	check_file_existence()

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
