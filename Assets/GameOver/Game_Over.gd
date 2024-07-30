extends Node2D


func _ready():
	Global.in_game = false
	Ui.visible = false
	$Control/Button.grab_focus()
	$AnimationPlayer.play("game_over")

func _on_Button_pressed():
	Global.player_last_position = Vector2.ZERO
	Global.player_last_scene = ""
	PlayerControll.restart()
	Ui.visible = true
	Global.in_game = true
	get_tree().change_scene("res://Assets/World/World_0.tscn")
