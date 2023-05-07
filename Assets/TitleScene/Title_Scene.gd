extends Node2D

func _ready():
	$Control/Title_Player/Title_Player_Animator.play("Title_Player_Anim")
	SoundController.play_music(SoundController.MUSIC.title)


func _on_Button_pressed():
	get_tree().change_scene("res://Assets/World/World_0.tscn")



func _on_Options_pressed():
	Ui.open_sound_panel()
