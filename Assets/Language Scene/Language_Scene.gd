extends Control
onready var en_btn = $Pause_Button_Container/EN
onready var pt_btn = $Pause_Button_Container/PT
onready var transition = $Transition_Start_Game

func _ready():
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
	var _scene_instance = get_tree().change_scene("res://Assets/TitleScene/Title_Scene.tscn")
	if _scene_instance == OK:
		transition.fade_out()


