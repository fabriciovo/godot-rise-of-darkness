extends "res://Assets/Buttons/ActionButton.gd"

func _on_pressed():
	var main = get_tree().current_scene
	var playerAim = main.get_node("PlayerAim")
	playerAim.visible = true
	playerAim.active = true
