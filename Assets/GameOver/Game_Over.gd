extends Node2D


func _ready():
	Ui.visible = false
	$Control/Button.grab_focus()
	$AnimationPlayer.play("game_over")


func _on_Button_pressed():
	Global.player_last_position = Vector2.ZERO
	Global.player_last_scene = ""
	PlayerControll.restart()
	Ui.visible = true
	get_tree().change_scene("res://Assets/World/World_0.tscn")
