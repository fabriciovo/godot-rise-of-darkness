extends Node2D


func _ready():
	$AnimationPlayer.play("game_over")


func _on_Button_pressed():
	get_tree().change_scene("res://Assets/World/World_0.tscn")
