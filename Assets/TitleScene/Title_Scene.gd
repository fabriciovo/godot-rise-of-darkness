extends Node2D
var filePath = "user://player_data.json"

func _ready():
	SoundController.play_music(SoundController.MUSIC.title)
	check_file_existence()

func check_file_existence():
	var file = File.new()
	if file.file_exists(filePath):
		$Load_Game.disabled = false
		$Load_Game.visible = true
	else:
		$Load_Game.disabled = true
		$Load_Game.visible = false


func _on_Button_pressed():
	var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	if scene_instance == OK:
		Ui.game_start()

func _on_Options_pressed():
	Ui.open_sound_panel()

func _on_Load_Game_pressed():
	var scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	if scene_instance == OK:
		PlayerControll.load_player_data(Global.loadJSONData("player_data"))
		Ui.game_start()
