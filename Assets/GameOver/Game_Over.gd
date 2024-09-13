extends Node2D

onready var button = $Control/Button

func _ready():
	Global.in_game = false
	Ui.visible = false
	$AnimationPlayer.play("game_over")

func _on_Button_pressed():
	Global.player_last_position = Vector2.ZERO
	Global.player_last_scene = ""
	PlayerControll.restart()
	Ui.visible = true
	Global.in_game = true
	SoundController.play_music(SoundController.MUSIC.florest)
	var _chnage_scene = get_tree().change_scene("res://Assets/World/World_0.tscn")

func _on_Timer_timeout():
	button.visible = true
	button.grab_focus()

