class_name Title_Scene extends Control

var filePath = "user://player_data.json"
onready var start = $Pause_Button_Container/Start
onready var btn_load_game = $Pause_Button_Container/Load_Game
onready var settings_panel = $"/root/Ui/UI_Containers/Settings"
onready var title_anim = $Title_Animation
onready var container = $Pause_Button_Container
onready var transition = $Transition_Start_Game


func _ready():
	Global.in_game = false
	start.set_focus_mode(Control.FOCUS_ALL)
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
	var _scene_instance = get_tree().change_scene("res://Assets/Introduction/Introduction.tscn")

func _on_Options_pressed():
	Ui.open_settings()

func _on_Load_Game_pressed():
	var _scene_instance = get_tree().change_scene("res://Assets/World/World_0.tscn")
	Global.load_world_data()
	PlayerControll.load_player_data(Global.loadJSONData("player_data"))
	if _scene_instance == OK:
		Ui.game_start()
		Global.in_game = true
		

func _on_Quit_pressed():
	get_tree().quit()

func destroy_title_anim():
	transition.fade_out()
	SoundController.play_music(SoundController.MUSIC.title)
	title_anim.visible = false

func _on_Transition_Start_Game_end_fade_out():
	$Label.visible = true
	container.visible = true
	transition.fade_in()

func _on_Transition_Start_Game_end_fade_in():
	if title_anim.visible:
		title_anim.get_node("AnimationPlayer").play("title")
	else:
		start.grab_focus()

func play_thunder_sound():
	SoundController.play_effect(SoundController.EFFECTS.thunder)
