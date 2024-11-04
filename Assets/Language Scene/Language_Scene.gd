extends Control
onready var en_btn = $Pause_Button_Container/EN
onready var pt_btn = $Pause_Button_Container/PT
onready var transition = $Transition_Start_Game
onready var confirmation_label = $Confirmation_Label

func _ready():
	Global.in_game = false

	en_btn.set_focus_mode(Control.FOCUS_ALL)
	en_btn.grab_focus()

func _on_PT_focus_entered():
	TranslationServer.set_locale("pt")

func _on_EN_focus_entered():
	TranslationServer.set_locale("en")

func _on_EN_pressed():
	go_to_title()

func _on_PT_pressed():
	go_to_title()

func go_to_title():
	transition.fade_out()
	en_btn.disabled = true
	pt_btn.disabled = true
	en_btn.release_focus()
	pt_btn.release_focus()

func _on_Transition_Start_Game_end_fade_out():
	var _scene_instance = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
